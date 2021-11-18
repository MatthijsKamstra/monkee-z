(function ($global) { "use strict";
class MonkeeFullpage {
	constructor() {
		this.linkArray = [];
		this.colors = ["#7fdbff","#39cccc","#3d9970","#2ecc40","#01ff70","#ffdc00","#ff851b","#ff4136","#f012be","#b10dc9","#85144b","#ffffff","#dddddd","#aaaaaa","#111111","#001f3f","#0074d9"];
		let _gthis = this;
		window.document.addEventListener("DOMContentLoaded",function(event) {
			let _version = "0.0.1";
			_version = "2021-11-12 20:46:43";
			$global.console.info("[Monkee-Z]" + " " + "Fullpage" + " - version: " + _version);
			_gthis.setupStyle();
			_gthis.init();
		});
	}
	init() {
		let ul = window.document.querySelector("[monkee-fullpage-slides]");
		ul.classList.add("monkee-fullpage-list");
		let lis = ul.getElementsByTagName("li");
		let _g = 0;
		let _g1 = lis.length;
		while(_g < _g1) {
			let i = _g++;
			let li = lis[i];
			li.classList.add("monkee-fullpage-slide");
			li.setAttribute("style","background-color: " + this.colors[i]);
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
		style.innerHTML = "\n\n.monkee-fullpage-list {\n  display: inline-block;\n  margin: 0;\n  padding: 0;\n  width: 100%;\n  height: 100%;\n  list-style-type: none;\n  overflow: auto;\n  scroll-behavior: smooth;\n}\n.monkee-fullpage-list-horizontal {\n  display: block ruby;\n}\n.monkee-fullpage-slide {\n  border: 0px solid pink;\n  width: 100%;\n  height: 100%;\n  display: inline-flex;\n  align-items: center;\n  justify-content: center;\n}\n  ";
		window.document.head.appendChild(style);
	}
	static main() {
		let app = new MonkeeFullpage();
	}
}
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
var $_;
function $bind(o,m) { if( m == null ) return null; if( m.__id__ == null ) m.__id__ = $global.$haxeUID++; var f; if( o.hx__closures__ == null ) o.hx__closures__ = {}; else f = o.hx__closures__[m.__id__]; if( f == null ) { f = m.bind(o); o.hx__closures__[m.__id__] = f; } return f; }
$global.$haxeUID |= 0;
{
}
MonkeeFullpage.main();
})(typeof window != "undefined" ? window : typeof global != "undefined" ? global : typeof self != "undefined" ? self : this);

//# sourceMappingURL=monkee_fullpage.js.map