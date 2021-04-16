package utils;

import haxe.Json;

using StringTools;
using Lambda;

class JsonPath {
	// var _json:Any;
	// var _path:String;
	// /**
	//  * search in json for the correct value, return null if not
	//  *
	//  * @example
	//  *
	//  * 			var data = JsonPath.search(str, 'i.want.data');
	//  *
	//  * @param jsonStr
	//  * @param path
	//  */
	// public function new(jsonStr:String, path:String) {
	// 	_json = Json.parse(jsonStr);
	// 	_path = path;
	// }

	/**
	 * search in json for the correct value, return null if not
	 *
	 * convert a string value to path used in json.
	 * can be an array as well
	 *
	 * @example
	 * 			var data = JsonPath.search(str, 'i.want.data');
	 * 			var arr:Array<Dynamic> = cast JsonPath.search(str, 'i.want.data[0]');
	 *
	 * @param jsonStr
	 * @param path
	 */
	public static function search(jsonStr:String, path:String) {
		var result = Json.parse(jsonStr); // cloning the existing json
		// var result = json; // cloning the existing obj

		// trace('----> ' + path);

		// now split the path and iterate through keys
		path.split(".").foreach(function(key) {
			// check for array, if not use the normal way
			if (key.indexOf('[') != -1) {
				// get the number in the string `films[1]`
				var index = Std.parseInt(key.split('[')[1].replace(']', ''));
				// get the array name `films`
				key = key.split('[')[0];
				// get the array
				var arr = Reflect.field(result, key);
				// get the index array based on index
				result = arr[index];
				// ask more than array has, return null
				if (index > arr.length)
					return null;
			} else {
				// trace(result);
				// trace(Reflect.hasField(result, key));
				// if (Reflect.hasField(result, key)) {
				if (!Reflect.hasField(result, key)) {
					result = null;
					return false;
				} else {
					result = Reflect.field(result, key);
				}
			}
			return true;
		});
		// trace(result);
		return result;
	}

	// public static function go(jsonStr:String, path:String) {
	// 	var d = new JsonPath(jsonStr, path);
	// 	var result = d._json; // cloning the existing json
	// 	trace('----> 2  ' + d._path);
	// 	// now split the path and iterate through keys
	// 	d._path.split(".").foreach(function(key) {
	// 		// check for array, if not use the normal way
	// 		if (key.indexOf('[') != -1) {
	// 			// get the number in the string `films[1]`
	// 			var index = Std.parseInt(key.split('[')[1].replace(']', ''));
	// 			// get the array name `films`
	// 			key = key.split('[')[0];
	// 			// get the array
	// 			var arr = Reflect.field(result, key);
	// 			// get the index array based on index
	// 			result = arr[index];
	// 		} else {
	// 			result = Reflect.field(result, key);
	// 		}
	// 		return true;
	// 	});
	// 	// trace(result);
	// 	return result;
	// }
}
