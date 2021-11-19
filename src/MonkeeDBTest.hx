package;

import MonkeeDB.*;
import js.Browser.*;

@:expose
class MonkeeDBTest {
	var isDebug = true;
	var DEBUG = true;

	public function new() {
		if (DEBUG)
			console.log('${App.NAME} - MonkeeDBTest - ${App.getBuildDate()}');

		// init0();
		init1();
	}

	function init0() {
		var dbName = 'test1';
		MonkeeDB.create(dbName);
		console.log(MonkeeDB.read(dbName));
		MonkeeDB.update(dbName, 'hello', 'Matthijs');
		console.log(MonkeeDB.read(dbName, 'hello'));
	}

	function init1() {
		var dbName = 'test2';
		var dbKey = 'input_text';
		create(dbName);
		console.log(read(dbName));
		var obj = read(dbName, dbKey);
		if (obj == null) {
			obj = {};
		}
		Reflect.setProperty(obj, 'name', 'Matthijs Kamstra');
		untyped obj['age'] = Std.random(1000);
		update(dbName, dbKey, obj);
		console.log(read(dbName, dbKey));
		clear(dbName);
	}

	static public function main() {
		document.addEventListener('DOMContentLoaded', (event) -> {
			var app = new MonkeeDBTest();
		});
	}
}
