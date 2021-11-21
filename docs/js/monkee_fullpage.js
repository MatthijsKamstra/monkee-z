(function ($global) { "use strict";
Math.__name__ = true;
class MonkeeFullpage {
	constructor() {
		this.isAutoScroll = false;
		this.arr = [];
		this.timer = null;
		this.dirPos = 0;
		this.previousPos = 0.0;
		this.currentPos = 0.0;
		this.slideHeight = 0;
		this.linkArray = [];
		this.colors = ["#7fdbff","#39cccc","#3d9970","#2ecc40","#01ff70","#ffdc00","#ff851b","#ff4136","#f012be","#b10dc9","#85144b","#ffffff","#dddddd","#aaaaaa","#111111","#001f3f","#0074d9"];
		this.DEBUG = true;
		let _version = "0.0.1";
		_version = "2021-11-18 21:26:53";
		$global.console.info("[Monkee-Z]" + " " + ("Fullpage " + "📃") + " - version: " + _version);
		let _gthis = this;
		window.document.addEventListener("DOMContentLoaded",function(event) {
			_gthis.setupStyle();
			_gthis.init();
		});
	}
	getData() {
		let ul = window.document.querySelector("[monkee-fullpage-slides]");
		ul.classList.add("monkee-fullpage-list");
		let lis = ul.getElementsByTagName("li");
		this.slideHeight = Math.floor(lis[0].scrollHeight);
		this.arr = [];
		let _g = 0;
		let _g1 = lis.length;
		while(_g < _g1) {
			let i = _g++;
			let li = lis[i];
			this.arr.push({ el : li, id : li.id, start : Math.floor(i * this.slideHeight), middle : Math.floor(i * this.slideHeight + this.slideHeight * 0.5), end : Math.floor(i * this.slideHeight + this.slideHeight)});
		}
		$global.console.warn(this.arr);
	}
	init() {
		let ul = window.document.querySelector("[monkee-fullpage-slides]");
		ul.classList.add("monkee-fullpage-list");
		ul.onscroll = $bind(this,this.onScrollHandler);
		let lis = ul.getElementsByTagName("li");
		let _gthis = this;
		let _g = 0;
		let _g1 = lis.length;
		while(_g < _g1) {
			let i = _g++;
			let li = lis[i];
			if(i == 0) {
				let resizeObserver = new ResizeObserver(function() {
					_gthis.getData();
				});
				resizeObserver.observe(li);
			}
			li.classList.add("monkee-fullpage-slide");
			if(this.DEBUG) {
				li.setAttribute("style","background-color: " + this.colors[i]);
			}
		}
		let links = window.document.getElementsByTagName("a");
		let first = false;
		let _g2 = 0;
		let _g3 = links.length;
		while(_g2 < _g3) {
			let i = _g2++;
			let link = links[i];
			if(link.getAttribute("href").charAt(0) == "#" && link.getAttribute("href").length > 1) {
				if(first == false) {
					link.classList.add("active");
				}
				this.linkArray.push(link);
				link.onclick = $bind(this,this.onclickHandler);
				first = true;
			}
		}
	}
	onScrollStop() {
		$global.console.group("stopped scrolling");
		let id = "";
		let _g = 0;
		let _g1 = this.arr.length;
		while(_g < _g1) {
			let i = _g++;
			let slideObj = this.arr[i];
			if(this.currentPos >= slideObj.middle) {
				$global.console.log("dirPos: " + this.dirPos + " ");
				$global.console.log("currentPos: " + this.currentPos + " ");
				let prevKey = i - 1;
				let nextKey = i + 1;
				if(prevKey < 0) {
					prevKey = 0;
				}
				if(nextKey > this.arr.length) {
					nextKey = this.arr.length;
				}
				$global.console.log("prevKey: " + prevKey + " // " + Std.string(this.arr[prevKey]));
				$global.console.log("nextKey: " + nextKey + " // " + Std.string(this.arr[nextKey]));
				$global.console.log(">> scroll to");
				if(this.dirPos > 0) {
					$global.console.log("next-id: " + Std.string(this.arr[nextKey]));
					id = this.arr[nextKey].id;
				} else {
					$global.console.log("next-id: " + Std.string(this.arr[prevKey]));
					id = this.arr[prevKey].id;
				}
				$global.console.log("-------");
			}
		}
		$global.console.groupEnd();
		window.document.getElementById(id).scrollIntoView();
	}
	onScrollHandler(e) {
		let _gthis = this;
		if(!this.isAutoScroll) {
			if(this.timer != null) {
				window.clearTimeout(this.timer);
			}
			this.timer = window.setTimeout(function() {
				_gthis.onScrollStop();
			},150);
			this.currentPos = e.currentTarget.scrollTop;
			if(this.currentPos > this.previousPos) {
				this.dirPos = 1;
			} else {
				this.dirPos = -1;
			}
			this.previousPos = this.currentPos;
		}
	}
	onclickHandler(e) {
		let _g = 0;
		let _g1 = this.linkArray.length;
		while(_g < _g1) {
			let i = _g++;
			let link = this.linkArray[i];
			link.classList.remove("active");
		}
		e.currentTarget.classList.add("active");
	}
	setupStyle() {
		let style = window.document.createElement("style");
		style.innerHTML = "\n.monkee-fullpage-list {\n  display: inline-block;\n  margin: 0;\n  padding: 0;\n  width: 100%;\n  height: 100%;\n  list-style-type: none;\n  overflow: auto;\n  scroll-behavior: smooth;\n}\n.monkee-fullpage-list-horizontal {\n  display: block ruby;\n}\n.monkee-fullpage-slide {\n  border: 0px solid pink;\n  width: 100%;\n  height: 100%;\n  display: inline-flex;\n  align-items: center;\n  justify-content: center;\n}\n";
		window.document.head.appendChild(style);
	}
	static main() {
		let app = new MonkeeFullpage();
	}
}
MonkeeFullpage.__name__ = true;
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
var $_;
function $bind(o,m) { if( m == null ) return null; if( m.__id__ == null ) m.__id__ = $global.$haxeUID++; var f; if( o.hx__closures__ == null ) o.hx__closures__ = {}; else f = o.hx__closures__[m.__id__]; if( f == null ) { f = m.bind(o); o.hx__closures__[m.__id__] = f; } return f; }
$global.$haxeUID |= 0;
{
	String.__name__ = true;
	Array.__name__ = true;
}
js_Boot.__toStr = ({ }).toString;
MonkeeFullpage.main();
})(typeof window != "undefined" ? window : typeof global != "undefined" ? global : typeof self != "undefined" ? self : this);

//# sourceMappingURL=monkee_fullpage.js.map