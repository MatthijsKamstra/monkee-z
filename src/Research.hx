package;

import js.lib.Object;
import haxe.Json;
import js.Browser.*;
import js.lib.Proxy;

class Research {
	var targetObj = {};

	public function new() {
		trace('Research');

		testOne();
		// testTwo();
		// testThree();
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
