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

		// proxi1();
		// proxi2();
		// proxi3();
		proxi4();
		// testOne();
		// testTwo();
		// testThree();
	}

	function render() {
		trace('{{{render}}}');
	}

	function onChange() {
		trace('{{{onChange}}}');
	}

	function proxi4() {
		trace('>> proxi 4');

		var target = {
			message1: "hello",
			message2: "everyone",
			data: {}
		};

		var handler = {
			get: function(target, property:String, receiver):Any {
				try {
					return new Proxy(untyped target[property], untyped handler);
				} catch (err) {
					return js.lib.Reflect.get(target, property, receiver);
				}
				// return Reflect.getProperty(target, property);
			},
			defineProperty: untyped function(target, property, descriptor) {
				onChange();
				return js.lib.Reflect.defineProperty(target, property, descriptor);
			},
			deleteProperty: untyped function(target, property) {
				onChange();
				return js.lib.Reflect.deleteProperty(target, property);
			}
		}

		var proxy = new Proxy(target, untyped handler);

		console.log(untyped proxy.message1); // hello
		console.log(untyped proxy.message2); // everyone

		trace(Reflect.getProperty(proxy, 'message1'));
		trace(Reflect.getProperty(proxy, 'message2'));

		// untyped proxy.message1 = 'hi';
		// Reflect.setProperty(proxy, 'message1', 'hii');

		// console.log(untyped proxy.message1); // hi
		// trace(Reflect.getProperty(proxy, 'message1'));

		// Reflect.setProperty(proxy, 'data', {'one': '1', 'two': '2'});
		// trace(Reflect.getProperty(proxy, 'data'));

		// console.log(untyped proxy.data.one); // 1
		// untyped proxy.data.one = '2';
		// console.log(untyped proxy.data.one); // 2
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
