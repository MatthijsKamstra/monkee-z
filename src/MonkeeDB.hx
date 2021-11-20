package;

import haxe.Json;
import haxe.Constraints.Function;
import gui.*;
import js.Browser.*;
import js.html.*;

@:expose
class MonkeeDB {
	static var dbJson:Dynamic;

	/**
	 * 0.0.1 	initial
	 */
	static inline var VERSION = '0.0.1';

	static inline final DEBUG = #if debug true #else false #end;

	// CRUD: Create Read Update Delete
	public function new() {
		console.info(App.callIn('DB ${utils.Emoji.monkeeDB}', VERSION));
	}

	// create

	/**
	 * create the database or get the previous information
	 *
	 * if (isOverwrite == false) the 'database' is not created and not overwritten
	 *
	 * @param dbName		dataBase name
	 * @param isOverwrite	possible to reset the database/overwrite with new default data
	 */
	public static function create(dbName:String, ?isOverwrite:Bool = false) {
		if (DEBUG)
			console.info("get local storage");

		dbJson = dbJson.parse(window.localStorage.getItem(dbName));
		// if (DEBUG) console.info(dbJson);
		if (dbJson == null || isOverwrite) {
			dbJson = {
				_id: 'localdata-${Date.now().getTime()}',
				version: '0.0.1',
				created: Date.now().toString(),
				updated: Date.now().toString(),
			}
			// window.localStorage.setItem(dbName, dbJson.stringify(dbJson));

			if (DEBUG) {
				console.log('initialize database:' + dbJson.stringify(dbJson));
			}

			saveData(dbName);
		}
	}

	// read

	/**
	 * read/load data from "database", send key and get specific data
	 *
	 * @example
	 * 				var dbJson = LocalData.read('databasedbName'); // get whole dbJson
	 * 				var version = LocalData.read('databasedbName', 'version'); // version from dbJson (untyped)
	 *
	 * @param dbName		dataBase name
	 * @param key			(optional) key to get from dbJson
	 * @return Dynamic		dbJson/object or null
	 */
	public static function read(dbName:String, ?key:String) {
		if (dbJson == null) {
			dbJson = dbJson.parse(window.localStorage.getItem(dbName));
		}

		if (key == null) {
			return dbJson;
		}

		if (Reflect.hasField(dbJson, key)) {
			return Reflect.getProperty(dbJson, key);
		} else {
			return null;
		}
	}

	/**
	 * load data (syntactic sugar for read without a key param)
	 *
	 * @example
	 * 				var dbJson = LocalData.load('databasedbName'); // get dbJson
	 *
	 * @param dbName		dataBase name
	 * @param key			(optional) key to get from dbJson
	 * @return Dynamic		dbJson/object or null
	 */
	public static function load(dbName:String):Dynamic {
		if (dbJson == null) {
			dbJson = dbJson.parse(window.localStorage.getItem(dbName));
		}
		if (dbJson == null) {
			return null;
		} else {
			return dbJson;
		}
	}

	// update

	/**
	 * update data (essential overwriting data: be careful with arrays and object)
	 *
	 * in the process the `updated` is updated to current date
	 *
	 * @example
	 * 				var dbJson = LocalData.update('databasedbName', 'test', 'foo');
	 *
	 * @param dbName		dataBase name
	 * @param key			(optional) key to get from dbJson
	 * @param value
	 */
	public static function update(dbName:String, key:String, value:Dynamic) {
		if (dbJson == null) {
			dbJson = dbJson.parse(window.localStorage.getItem(dbName));
		}

		// if (Reflect.hasField(dbJson, key)) {
		Reflect.setProperty(dbJson, key, value);
		Reflect.setProperty(dbJson, 'updated', Date.now().toString());
		// }

		saveData(dbName);
	}

	// delete

	/**
	 * [Description]
	 * @example
	 * 				var dbJson = LocalData.delete('databasedbName', 'test');
	 *
	 * @param dbName		dataBase name
	 * @param key			(optional) key to get from dbJson
	 */
	public static function delete(dbName:String, key:String) {
		if (dbJson == null) {
			dbJson = dbJson.parse(window.localStorage.getItem(dbName));
		}

		if (Reflect.hasField(dbJson, key)) {
			Reflect.deleteField(dbJson, key);
		}

		saveData(dbName);
	}

	/**
	 * remove localStorage with ddbName
	 *
	 * @param dbName		dataBase name
	 */
	public static function clear(dbName:String) {
		dbJson = null;
		window.localStorage.removeItem(dbName);
		if (DEBUG)
			console.log('cleared data "$dbName"');
	}

	// ____________________________________ private ____________________________________

	private static function saveData(dbName:String) {
		window.localStorage.setItem(dbName, dbJson.stringify(dbJson));
		if (DEBUG)
			console.log(dbJson);
	}
}
