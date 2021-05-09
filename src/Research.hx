package;

import js.lib.Object;
import haxe.Json;
import js.Browser.*;
import js.lib.Proxy;

// import js.lib.Reflect;

class Research {
	var targetObj = {};

	public function new() {
		trace('Research');

		sanitize();

		// proxi1();
		// proxi2();
		// proxi3();
		// proxi4();
		// proxi5();
		// testOne();
		// testTwo();
		// testThree();
	}

	function sanitize() {
		var xss = "<image src=x onerror=alert('XSS_image')>";
		var json = {
			numberVal: 100,
			intVal: 3,
			floatVal: 4.4,
			stringVal: "hello",
			boolVal: true,
			arrayVal: ['one', 'two'],
			objVal: {},
		}
		var content = Json.stringify(json);

		trace('json.stringVal: ' + json.stringVal);
		json.stringVal = xss;
		trace('json.stringVal: ' + json.stringVal);
		var sanitized = utils.Sanitize.sanitizeJson(json);
		trace('sanitized.stringVal: ' + sanitized.stringVal);
		json = utils.Sanitize.sanitizeJson(json);
		trace('json.stringVal: ' + json.stringVal);

		trace('json.boolVal: ' + json.boolVal);
		untyped json.boolVal = xss;
		trace('json.boolVal: ' + json.boolVal);
		json = utils.Sanitize.sanitizeJson(json);
		trace('json.boolVal: ' + json.boolVal);

		trace('json.arrayVal: ' + json.arrayVal);
		untyped json.arrayVal.push(xss);
		trace('json.arrayVal: ' + json.arrayVal);
		json = utils.Sanitize.sanitizeJson(json);
		trace('json.arrayVal: ' + json.arrayVal);

		trace('json.objVal: ' + json.objVal);
		untyped json.objVal.title = (xss);
		trace('json.objVal: ' + json.objVal);
		json = utils.Sanitize.sanitizeJson(json);
		trace('json.objVal: ' + json.objVal);
	}

	// ____________________________________ proxy ____________________________________

	function render() {
		trace('<< render >>');
	}

	function onChange(property) {
		trace('<< onChange: ${property} >>');
	}

	function proxi5() {
		trace('>> proxi 5');
		var target = {
			stringVal: "hello",
			boolVal: true,
			objVal: {},
			arrayVal: ['one']
		};
		var proxi5Handler = {
			get: function(target:Dynamic, property:String, receiver):Any {
				// The get() trap is fired when a property of the target object is accessed via the proxy object.
				trace('> GET: "${property}"');
				var bool = js.lib.Reflect.get(target, property, receiver);
				// render();
				return bool;
			},
			set: function(target:Dynamic, property:String, val):Any {
				// The set() trap controls behavior when a property of the target object is set.
				trace('> SET: "${property}": ${val}');
				var bool = js.lib.Reflect.set(target, property, val);
				render();
				return bool;
			},
			defineProperty: function(target:Dynamic, property:String, descriptor) {
				trace('> defineProperty: "${property}": ${Json.stringify(descriptor)}');
				render();
				return js.lib.Reflect.defineProperty(target, property, descriptor);
			},
		}

		var data = new Proxy(target, untyped proxi5Handler);

		console.log(untyped data.stringVal);
		console.log(untyped data.stringVal = 'hhehehe');
		console.log(untyped data.stringVal);

		console.log(untyped data.objVal);
		console.log(untyped data.objVal.one); // 1
		untyped data.objVal.one = '2';
		console.log(untyped data.objVal);
		console.log(untyped data.objVal.one);

		console.log(untyped data.newObj);
		console.log(untyped data.newObj = {});
		console.log(untyped data.newObj);
		console.log(untyped data.newObj = {'one': '1'});
		console.log(untyped data.newObj);

		console.log(untyped data.arrayVal);
		console.log(untyped data.arrayVal.push('x'));
		console.log(untyped data.arrayVal);
	}

	function proxi4() {
		trace('>> proxi 4');

		var target = {
			message1: "hello",
			message2: "everyone",
			data: {},
			array: ['one']
		};

		var handler = {
			get: function(target:Dynamic, property:String, receiver):Any {
				try {
					return new Proxy(untyped target[property], untyped handler);
				} catch (err) {
					return js.lib.Reflect.get(target, property, receiver);
				}
				// return Reflect.getProperty(target, property);
			},
			defineProperty: function(target:Dynamic, property:String, descriptor) {
				onChange(property);
				return js.lib.Reflect.defineProperty(target, property, descriptor);
			},
			deleteProperty: function(target:Dynamic, property:String) {
				onChange(property);
				return js.lib.Reflect.deleteProperty(target, property);
			}
		}

		var proxy = new Proxy(target, untyped handler);

		console.log(untyped proxy.message1 = 'hhehehe'); // hello
		console.log(untyped proxy.message1); // hello
		console.log(untyped proxy.message2); // everyone

		// trace(Reflect.getProperty(proxy, 'message1'));
		// trace(Reflect.getProperty(proxy, 'message2'));

		untyped proxy.message1 = 'hi';
		// Reflect.setProperty(proxy, 'message1', 'hii');

		console.log(untyped proxy.message1); // hi
		// trace(Reflect.getProperty(proxy, 'message1'));

		// Reflect.setProperty(proxy, 'data', {'one': '1', 'two': '2'});
		// trace(Reflect.getProperty(proxy, 'data'));

		console.log(untyped proxy.data.one); // 1
		untyped proxy.data.one = '2';
		console.log(untyped proxy.data.one); // 2
		console.log(untyped proxy.array); // 2
		console.log(untyped proxy.array.push('x')); // 2
		console.log(untyped proxy.array); // 2
	}

	function proxi3() {
		trace('>> proxi 3');

		var target = {
			message1: "hello",
			message2: "everyone",
			data: {}
		};

		var handler = {
			get: function(target, prop:String, receiver):Any {
				return Reflect.getProperty(target, prop);
			},
			set: function(target, prop:String, value:Any, receiver):Bool {
				console.warn('changed! ${prop}');
				render();
				Reflect.setProperty(target, prop, value);
				return true;
			}
		};

		var proxy = new Proxy(target, handler);

		console.log(untyped proxy.message1); // hello
		console.log(untyped proxy.message2); // everyone

		trace(Reflect.getProperty(proxy, 'message1'));
		trace(Reflect.getProperty(proxy, 'message2'));

		untyped proxy.message1 = 'hi';
		Reflect.setProperty(proxy, 'message1', 'hii');

		console.log(untyped proxy.message1); // hi
		trace(Reflect.getProperty(proxy, 'message1'));

		Reflect.setProperty(proxy, 'data', {'one': '1', 'two': '2'});
		trace(Reflect.getProperty(proxy, 'data'));

		console.log(untyped proxy.data.one); // 1
		untyped proxy.data.one = '2';
		console.log(untyped proxy.data.one); // 2
	}

	function proxi2() {
		trace('proxi 2');
		var target:TestObj = {firstName: 'Arfat', lastName: 'Salman'};

		var handler = {
			get: function(target:TestObj, property:String, receiver):Any {
				console.log('GET ${property}');
				// return untyped target[property];
				return Reflect.getProperty(target, property);
			}
		};

		var proxy = new Proxy(target, handler);
		trace("x");
		console.log(untyped proxy.firstName);
	}

	function proxi1() {
		trace('proxi 1');
		var target = {
			message1: "hello",
			message2: "everyone"
		};

		var handler1 = {
			get: function(target, prop:String, receiver):Any {
				if (prop == "message2") {
					return "world";
				}
				return Reflect.getProperty(target, prop);
			}
		};

		var proxy1 = new Proxy(target, handler1);

		console.log(untyped proxy1.message1); // hello
		console.log(untyped proxy1.message2); // everyone
	}

	// Demo
	var myVar = 123;
	var varWatch = 0;

	function testThree() {
		Object.defineProperty(this, 'varWatch', {
			get: function() {
				return myVar;
			},
			set: function(v) {
				myVar = v;
				console.log('Value changed! New value: ' + v);
			}
		});

		console.log(varWatch);
		varWatch = 456;
		console.log(varWatch);
	}

	function testTwo() {
		var validator = {
			set: function(target:{}, property:String, value:Any, receiver:Null<{}>) {
				console.log('The property ${property} has been updated with ${Json.stringify(value)}');
				return true;
			}
		};
		var store = new Proxy({}, validator);
		Reflect.setField(store, 'a', 'hello');

		// store.a = 'hello';
		// console => The property a has been updated with hello
	}

	function testOne() {
		var targetProxy:{} = new js.lib.Proxy(targetObj, {
			set: function(target:{}, key:String, value:Any, receiver:Null<{}>) {
				console.log('${key} set to ${Json.stringify(value)}');
				untyped target[key] = value;
				return true;
			}
		});
		untyped targetProxy.hello_world = "test"; // console: 'hello_world set to test'
	}

	static public function main() {
		var app = new Research();
	}
}

typedef TestObj = {
	@:optional var _id:String;
	var firstName:String;
	var lastName:String;
}
