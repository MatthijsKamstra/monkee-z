package utils;

import Type.ValueType;
import haxe.Json;

using StringTools;

class Sanitize {
	public static var IS_DEBUG = false;

	/**
	 * [Description]
	 * @param json
	 * @return Dynamic
	 */
	public static function sanitizeJson(json:Dynamic):Dynamic {
		if (IS_DEBUG)
			trace('---> sanitizeJson ${json}');

		// var res = Json.parse(Json.stringify(json));
		var res = json;
		if (IS_DEBUG)
			trace(res);
		for (n in Reflect.fields(res)) {
			// trace(n);
			// trace(Reflect.field(res, n));
			var key = n;
			var value = Reflect.field(res, n);
			var type:ValueType = Type.typeof(value);

			if (Std.isOfType(value, Int) || Std.isOfType(value, Float)) {
				if (IS_DEBUG)
					trace('numbers, don\'t do anything');
			} else if (Std.isOfType(value, Bool)) {
				if (IS_DEBUG)
					trace('bool, don\'t do anything');
			} else if (Std.isOfType(value, String)) {
				if (IS_DEBUG)
					trace('string, sanatize');

				if (IS_DEBUG)
					trace(res);
				Reflect.setProperty(res, key, sanitizeHTML(value));
				if (IS_DEBUG)
					trace(res);
			} else if (Std.isOfType(value, Array)) {
				// Reflect.setProperty(res, key, sanitizeHTML(value));
				if (IS_DEBUG)
					trace('DO something clever with Array ${value}');

				// trace('\n--> DO something clever with Array ${value}');
				// trace('\n---> DO something clever with Array ${haxe.Json.parse(value)}');

				// Array<String> NOT Array<{}>
				var _value:Array<Dynamic> = cast value;
				// untyped var value = value;

				for (i in 0..._value.length) {
					// trace("i: " + i);
					// trace("_value[i]: " + _value[i]);
					// trace("_value: " + value);
					// trace('TObject? (${_value[i]})--> ${Type.typeof(_value[i]) == TObject}');
					if (Type.typeof(_value[i]) == TObject) {
						// trace('---> ${_value[i]}');
						// trace('---> ${untyped value[i]}');
						Sanitize.sanitizeJson(_value[i]);
						continue;
					};
					_value[i] = sanitizeHTML(_value[i]);
				}
			} else {
				if (IS_DEBUG)
					trace('DO something clever with Object ${value}');

				// trace('\n--> DO something clever with Object ${value}');
				Sanitize.sanitizeJson(value);
			}
			// #if js
			// // import js.lib.Object;
			// trace('JS: ' + Std.isOfType(value, js.lib.Object));
			// #else
			// trace('NOT JS:  ${(Type.typeof(value) == TObject)}');
			// #end

			// trace('----------------------------');
			// trace('${key}: ${value} (${type})');
			// trace('${key}: ${Reflect.getProperty(res, key)}');
			// trace('----------------------------');
			// trace('----> Array ----> ' + Std.isOfType(value, Array));
			// // trace('----> "array" ----> ' + Std.isOfType(value, "array"));
			// // trace('----> Dynamic ----> ' + Std.isOfType(value, Dynamic));
			// trace('----> TObject ----> ' + Std.isOfType(value, TObject));
			// trace('----> {} ----> ' + Std.isOfType(value, {}));
			// trace('----> Object ----> ' + Std.isOfType(value, Object));
			// // trace('----> Any ----> ' + Std.isOfType(value, Any));
			// trace('----> String ----> ' + Std.isOfType(value, String));
			// trace('----> Bool ----> ' + Std.isOfType(value, Bool));
			// trace('----> x ----> ' + js.Syntax.typeof(value));
			// trace('----> y ----> ' + js.Syntax.typeof(value) == 'string');

			// try {
			// 	trace(value.length);
			// } catch (e) {
			// 	trace('not array');
			// }
		}

		// for (i in Json.parse(json)) {
		// 	trace(i);
		// }
		return res;
	}

	/**
	 * sanitize string to prefend XSS attack
	 *
	 * @example
	 * 		utils.Sanitize.sanitizeHTML('<img src="x" onerror="alert(1)">');
	 *
	 * @param unsafe_str
	 * @return String
	 */
	public static function sanitizeHTML(unsafe_str:String):String {
		// make sure we clean once, not continues.
		if (unsafe_str.indexOf('&amp;') != -1)
			unsafe_str.replace('&', '&amp;');
		return unsafe_str
			.replace('<', '&lt;')
			.replace('>', '&gt;')
			.replace('"', '&quot;')
			.replace("'", '&#39;'); // '&apos;' is not valid HTML 4
	}

	/**
	 * 	@example
	 * 		utils.Sanitize.escapeHTML('<img src="x" onerror="alert(1)">');
	 * @param unsafe_str
	 * @return String
	 */
	public static function escapeHTML(unsafe_str:String):String {
		return sanitizeHTML(unsafe_str);
	}
}
