package;

import externs.MonkeeChain;

class MonkeeChainJs {
	public function new() {
		trace('MonkeeChainJs');
		init();
	}

	function init() {
		test0();
		test1();
		test2();
		test3();
		test4();
	}

	function test0() {
		var app = new MonkeeChain('#app', {
			data: {
				name: 'matthijs'
			},
			template: function(props:Dynamic) {
				return '<p>hello ${props.name}</p>';
			},
		});
	}

	function test1() {
		var title = 'MonkeChain';
		var app = new MonkeeChain('#test-string', {
			data: {},
			template: '<p>${title}</p>'
		});
	}

	function test2() {
		var obj:DataObj = {
			label: 'label it',
			say: {
				hello: 'matthijs'
			}
		};
		var app = new MonkeeChain('#test-obj', {
			data: obj,
			template: function(props:DataObj):String {
				return '<p>${props.label}, ${props.say.hello}</p>';
			}
		});
	}

	function test3() {}

	function test4() {
		// some default values
		var firstName = 'Matthijs';
		var lastName = 'Kamstra';
		var obj2:DataObj2 = {
			message: 'startvalue'
		};

		// Setup the component
		var app = new MonkeeChain('#test-change', {
			data: obj2,
			template: function(props:DataObj2):String {
				return '<p>${firstName} ${lastName} : ${props.message}</p>';
			}
		});

		// update data
		app.data.message = 'endvalue';
		// re-render app
		app.render();
	}

	static public function main() {
		var app = new MonkeeChainJs();
	}
}

typedef DataObj = {
	@:optional var _id:String;
	var label:String;
	var say:{
		hello:String
	};
	@:optional var isTrue:Bool;
}

typedef DataObj2 = {
	@:optional var _id:String;
	var message:String;
}
