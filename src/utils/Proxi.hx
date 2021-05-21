package utils;

import js.lib.Proxy;
import js.lib.Proxy.ProxyHandler;

class Proxi {
	public function new() {
		// your code
	}

	public static function create(target:Dynamic) {
		var proxi6Handler:ProxyHandler<Dynamic> = {
			get: function(target:Dynamic, property:String, receiver):Any {
				// The get() trap is fired when a property of the target object is accessed via the proxy object.
				trace('\n\t---> GET: "${property}"');

				// render();
				return Reflect.getProperty(target, property);
			},
			// set: function(target:Dynamic, property:String, val):Any {
			// 	// The set() trap controls behavior when a property of the target object is set.
			// 	trace('\n\t---> SET: "${property}": ${val}');
			// 	Reflect.setProperty(target, property, val);
			// 	render();
			// 	return Reflect.getProperty(target, property);
			// },
			defineProperty: function(target:Dynamic, property:String, descriptor) {
				trace('\n\t---> defineProperty: "${property}": ${Json.stringify(descriptor)}');
				Reflect.setField(target, property, descriptor.value);
				render();
				return true;
			},
		}

		var data = new Proxy(target, proxi6Handler);

		return data;
	}

	public static function render() {
		trace('<< render >>');
	}
}
