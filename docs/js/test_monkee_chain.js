// Generated by Haxe 4.1.5
(function ($global) { "use strict";
Math.__name__ = true;
class MonkeeChainTest {
	constructor() {
		console.log("src/MonkeeChainTest.hx:8:","MonkeeChainTest");
		this.init();
	}
	init() {
		this.test0();
		this.test1();
		this.test2();
		this.test3();
		this.test4();
	}
	test0() {
		let app = new MonkeeChain("#app",{ data : { name : "matthijs"}, template : function(props) {
			return "<p>hello " + Std.string(props.name) + "</p>";
		}});
	}
	test1() {
		let title = "MonkeChain";
		let app = new MonkeeChain("#test-string",{ data : { }, template : "<p>" + title + "</p>"});
	}
	test2() {
		let obj = { label : "label it", say : { hello : "matthijs"}};
		let app = new MonkeeChain("#test-obj",{ data : obj, template : function(props) {
			return "<p>" + props.label + ", " + props.say.hello + "</p>";
		}});
	}
	test3() {
		let app = new MonkeeChain("#test-timer",{ data : { time : new Date()}, template : function(props) {
			return "<strong>The time is:</strong> " + props.time;
		}});
		window.setInterval(function() {
			app.data.time = new Date();
			app.render();
		},1000);
	}
	test4() {
		let firstName = "Matthijs";
		let lastName = "Kamstra";
		let obj2 = { message : "startvalue"};
		let app = new MonkeeChain("#test-change",{ data : obj2, template : function(props) {
			return "<p>" + firstName + " " + lastName + " : " + props.message + "</p>";
		}});
		app.data.message = "endvalue";
		app.render();
	}
	static main() {
		let app = new MonkeeChainTest();
	}
}
MonkeeChainTest.__name__ = true;
class Std {
	static string(s) {
		return js_Boot.__string_rec(s,"");
	}
}
Std.__name__ = true;
class haxe_iterators_ArrayIterator {
	constructor(array) {
		this.current = 0;
		this.array = array;
	}
	hasNext() {
		return this.current < this.array.length;
	}
	next() {
		return this.array[this.current++];
	}
}
haxe_iterators_ArrayIterator.__name__ = true;
class js_Boot {
	static __string_rec(o,s) {
		if(o == null) {
			return "null";
		}
		if(s.length >= 5) {
			return "<...>";
		}
		let t = typeof(o);
		if(t == "function" && (o.__name__ || o.__ename__)) {
			t = "object";
		}
		switch(t) {
		case "function":
			return "<function>";
		case "object":
			if(((o) instanceof Array)) {
				let str = "[";
				s += "\t";
				let _g = 0;
				let _g1 = o.length;
				while(_g < _g1) {
					let i = _g++;
					str += (i > 0 ? "," : "") + js_Boot.__string_rec(o[i],s);
				}
				str += "]";
				return str;
			}
			let tostr;
			try {
				tostr = o.toString;
			} catch( _g ) {
				return "???";
			}
			if(tostr != null && tostr != Object.toString && typeof(tostr) == "function") {
				let s2 = o.toString();
				if(s2 != "[object Object]") {
					return s2;
				}
			}
			let str = "{\n";
			s += "\t";
			let hasp = o.hasOwnProperty != null;
			let k = null;
			for( k in o ) {
			if(hasp && !o.hasOwnProperty(k)) {
				continue;
			}
			if(k == "prototype" || k == "__class__" || k == "__super__" || k == "__interfaces__" || k == "__properties__") {
				continue;
			}
			if(str.length != 2) {
				str += ", \n";
			}
			str += s + k + " : " + js_Boot.__string_rec(o[k],s);
			}
			s = s.substring(1);
			str += "\n" + s + "}";
			return str;
		case "string":
			return o;
		default:
			return String(o);
		}
	}
}
js_Boot.__name__ = true;
String.__name__ = true;
Array.__name__ = true;
Date.__name__ = "Date";
js_Boot.__toStr = ({ }).toString;
MonkeeChainTest.main();
})({});

//# sourceMappingURL=test_monkee_chain.js.map