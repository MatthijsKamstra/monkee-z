(function ($global) { "use strict";
class MonkeeFullpage {
	constructor() {
		this.map = new haxe_ds_IntMap();
		this.timer = null;
		this.dirPos = 0;
		this.previousPos = 0.0;
		this.currentPos = 0.0;
		this.slideHeight = 0;
		this.linkArray = [];
		this.colors = ["#7fdbff","#39cccc","#3d9970","#2ecc40","#01ff70","#ffdc00","#ff851b","#ff4136","#f012be","#b10dc9","#85144b","#ffffff","#dddddd","#aaaaaa","#111111","#001f3f","#0074d9"];
		this.DEBUG = true;
		let _version = "0.0.1";
		_version = "2021-11-19 10:02:49";
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
		this.slideHeight = lis[0].scrollHeight;
		let _g = 0;
		let _g1 = lis.length;
		while(_g < _g1) {
			let i = _g++;
			let li = lis[i];
			let t = Math.round(i * this.slideHeight + this.slideHeight * 0.5);
			this.map.h[t] = li.id;
		}
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
		$global.console.log("stopped scrolling");
		let key = this.map.keys();
		while(key.hasNext()) {
			let key1 = key.next();
			if(this.currentPos >= key1) {
				console.log("src/MonkeeFullpage.hx:127:",key1);
				let nextKey = key1 + this.slideHeight;
				console.log("src/MonkeeFullpage.hx:129:",nextKey);
				console.log("src/MonkeeFullpage.hx:131:","" + this.map.h[key1]);
				console.log("src/MonkeeFullpage.hx:132:","scroll to");
				console.log("src/MonkeeFullpage.hx:133:","" + this.map.h[nextKey]);
			}
		}
	}
	onScrollHandler(e) {
		if(this.timer != null) {
			window.clearTimeout(this.timer);
		}
		let _gthis = this;
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
class haxe_ds_IntMap {
	constructor() {
		this.h = { };
	}
	keys() {
		let a = [];
		for( var key in this.h ) if(this.h.hasOwnProperty(key)) a.push(+key);
		return new haxe_iterators_ArrayIterator(a);
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