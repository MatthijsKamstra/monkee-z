package;

import MonkeeChainExterns;

class MonkeeChainJs {
	public function new() {
		trace('MonkeeChainJs');
		init();
	}

	function init() {
		test0();
		test1();
		test2();
		// test3();
		// test4();
	}

	function test0() {
		var app = new MonkeeChainExterns('#app', {
			data: {
				hello: 'matthijs'
			},
			template: function(props:Dynamic) {
				return '<p>${props.hello}</p>';
			},
		});
	}

	function test1() {
		var temp = 'foo';
		var app = new MonkeeChainExterns('#test-string', {
			data: {
				hello: 'matthijs'
			},
			template: '<p>${temp}</p>'
		});
	}

	function test2() {
		var temp = 'foo';
		var obj:DataObj = {
			label: 'label it',
			say: {
				hello: 'matthijs'
			}
		};
		var app = new MonkeeChainExterns('#test-obj', {
			data: obj,
			template: function(props:DataObj):String {
				return '<p>${props.label}</p>';
			}
		});
	}

	function test3() {
		var temp = 'foo';
		var obj:DataObj = {
			label: 'label it',
			say: {
				hello: 'matthijs'
			}
		};
		var app = new MonkeeChainExterns('#test-obj', {
			data: obj,
			template: function(props:DataObj):String {
				return '<p>${props.label}</p>';
			}
		});
	}

	function test4() {
		// some default values
		var firstName = 'Matthijs';
		var lastName = 'Kamstra';
		var obj2:DataObj2 = {
			message: '🐵'
		};

		// Setup the component
		var app = new MonkeeChainExterns('#test-change', {
			data: obj2,
			template: function(props:DataObj2):String {
				return '<p>${firstName} ${lastName}: ${props.message}</p>';
			}
		});

		// update data
		app.data.message = '🙈';
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
