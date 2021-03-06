(function ($global) { "use strict";
Math.__name__ = true;
class MonkeeBugger {
	constructor() {
		let _gthis = this;
		window.document.addEventListener("DOMContentLoaded",function(event) {
			let _version = "0.0.2";
			$global.console.info("[Monkee-Z]" + " " + "MonkeeBugger" + " - version: " + _version);
			_gthis.init();
			_gthis.highjack();
		});
	}
	init() {
		let _id = "debugDiv";
		let div = window.document.getElementById(_id);
		if(window.document.getElementById(_id) == null) {
			div = window.document.createElement("div");
			div.id = _id;
			div.setAttribute("style","@import url('https://fonts.googleapis.com/css2?family=Roboto+Mono&display=swap'); font-family: 'Roboto Mono','Courier New', Courier, monospace;padding: 10px; height: 200px; width: 100%; border: 1px solid #333; overflow:scroll;position: fixed;bottom: 0; color: white; background-color: rgba(0,0,0,0.5)");
			window.document.body.appendChild(div);
		}
		return div;
	}
	highjack() {
		let _log = ($_=$global.console,$bind($_,$_.log));
		let _warn = ($_=$global.console,$bind($_,$_.warn));
		let _info = ($_=$global.console,$bind($_,$_.info));
		let _error = ($_=$global.console,$bind($_,$_.error));
		let _gthis = this;
		$global.console.log = function(msg,...msg2) {
			if(msg2 == null) {
				_log(msg);
				_gthis.output("" + Std.string(msg));
			} else {
				_log(msg,msg2);
				_gthis.output("" + Std.string(msg) + " " + (msg2 == null ? "null" : "[" + msg2.toString() + "]"));
			}
		};
		$global.console.warn = function(...msg) {
			_warn(msg);
			_gthis.output("" + (msg == null ? "null" : "[" + msg.toString() + "]"),"warn");
		};
		$global.console.error = function(...msg) {
			_error(msg);
			_gthis.output("" + (msg == null ? "null" : "[" + msg.toString() + "]"),"error");
		};
		$global.console.info = function(...msg) {
			_info(msg);
			_gthis.output("" + (msg == null ? "null" : "[" + msg.toString() + "]"),"info");
		};
		window.onerror = function(message,url,linenumber,i,b) {
			$global.console.log("JavaScript error: " + message + " on line " + linenumber + " for " + url);
			return { };
		};
	}
	output(message,type) {
		if(type == null) {
			type = "log";
		}
		let style = "color:gray";
		switch(type) {
		case "error":
			style = "background-color:#FF3769; color:white;";
			break;
		case "info":
			style = "color:black";
			break;
		case "log":
			style = "color:white";
			break;
		case "warn":
			style = "background-color:#D8B700; color:white;";
			break;
		default:
			style = "color:black";
		}
		let div = this.init();
		let d = new Date();
		let time = StringTools.lpad("" + d.getHours(),"0",2) + ":" + StringTools.lpad("" + d.getMinutes(),"0",2) + ":" + StringTools.lpad("" + d.getSeconds(),"0",2) + " - ";
		let txt = div.innerHTML;
		div.innerHTML = "<div style=\"border-top:1px solid RGBA(0,0,0,0.3);" + style + "\"><span>" + time + " " + message + "</span></div>" + txt;
	}
	static main() {
		let app = new MonkeeBugger();
	}
}
MonkeeBugger.__name__ = true;
class Std {
	static string(s) {
		return js_Boot.__string_rec(s,"");
	}
}
Std.__name__ = true;
class StringTools {
	static lpad(s,c,l) {
		if(c.length <= 0) {
			return s;
		}
		let buf_b = "";
		l -= s.length;
		while(buf_b.length < l) buf_b += c == null ? "null" : "" + c;
		buf_b += s == null ? "null" : "" + s;
		return buf_b;
	}
}
StringTools.__name__ = true;
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
var $_;
function $bind(o,m) { if( m == null ) return null; if( m.__id__ == null ) m.__id__ = $global.$haxeUID++; var f; if( o.hx__closures__ == null ) o.hx__closures__ = {}; else f = o.hx__closures__[m.__id__]; if( f == null ) { f = m.bind(o); o.hx__closures__[m.__id__] = f; } return f; }
$global.$haxeUID |= 0;
{
	String.__name__ = true;
	Array.__name__ = true;
	Date.__name__ = "Date";
}
js_Boot.__toStr = ({ }).toString;
MonkeeBugger.main();
})(typeof window != "undefined" ? window : typeof global != "undefined" ? global : typeof self != "undefined" ? self : this);
