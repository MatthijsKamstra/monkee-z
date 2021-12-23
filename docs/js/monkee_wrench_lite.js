(function ($hx_exports, $global) { "use strict";
class MonkeeWrenchLite {
	constructor() {
		this.DEBUG_IMAGES = ["https://matthijskamstra.github.io/monkee-z/assets/img/debug/146-500x500.jpg","https://matthijskamstra.github.io/monkee-z/assets/img/debug/500x500.jpg"];
		let _gthis = this;
		window.document.addEventListener("DOMContentLoaded",function(event) {
			$global.console.groupCollapsed("🔧" + " Monkee-Wrench-Lite - v" + "0.0.7");
			$global.console.log("Monkee Wrench Lite is a JavaScript tool to replace missing (background)images, and show broken links");
			$global.console.log("Use by focussing the browser and press \"m\"");
			$global.console.log("Or use " + window.location.href + "?monkeewrench");
			$global.console.log("WIP documentation https://matthijskamstra.github.io/monkee-z/wrench/");
			$global.console.groupEnd();
			_gthis.init();
		});
	}
	init() {
		let _gthis = this;
		window.onkeydown = function(e) {
			_gthis.getkey(e);
		};
		let urlParams = new URLSearchParams(window.location.search);
		let myParam = urlParams.get("monkeewrench");
		if(myParam != null) {
			this.validateElementsOnPage();
			window.onkeydown = null;
		}
	}
	getkey(e) {
		if(e.key == "m") {
			this.validateElementsOnPage();
			window.onkeydown = null;
		}
	}
	validateElementsOnPage() {
		let elementsImg = window.document.getElementsByTagName("img");
		let _g = 0;
		let _g1 = elementsImg.length;
		while(_g < _g1) {
			let i = _g++;
			let el = elementsImg[i];
			this.isUrlValid(el.src,$bind(this,this.setImage),[el]);
		}
		let elementsWithBG = window.document.getElementsByTagName("*");
		let _g2 = 0;
		let _g3 = elementsWithBG.length;
		while(_g2 < _g3) {
			let i = _g2++;
			let el = elementsWithBG[i];
			let url = StringTools.replace(StringTools.replace(StringTools.replace(StringTools.replace(el.style.backgroundImage,"'",""),"\"",""),"url(",""),")","");
			this.isUrlValid(url,$bind(this,this.setBgImage),[el]);
		}
		let elementsLinks = window.document.getElementsByTagName("a");
		let _g4 = 0;
		let _g5 = elementsLinks.length;
		while(_g4 < _g5) {
			let i = _g4++;
			let el = elementsLinks[i];
			let href = el.getAttribute("href");
			if(href == "" || href == "#" || href == null) {
				el.innerHTML = "🔧" + " " + el.innerHTML;
			} else if(href.startsWith("/") || href.indexOf(window.location.host) != -1) {
				this.isUrlValid(el.href,$bind(this,this.setXEmoji),[el]);
			}
		}
	}
	isUrlValid(url,cb,arr) {
		let request = new XMLHttpRequest();
		request.open("GET",url,true);
		let _gthis = this;
		request.onload = function() {
			if(request.status >= 400) {
				cb.apply(_gthis,arr);
			}
		};
		request.send();
	}
	setXEmoji(el) {
		el.innerHTML = "❌" + " " + el.innerHTML;
	}
	setBgImage(el) {
		el.style.backgroundImage = "url(" + this.DEBUG_IMAGES[1] + ")";
	}
	setImage(el) {
		let w = el.width;
		let h = el.height;
		el.src = this.DEBUG_IMAGES[0];
		if(el.getAttribute("width") != null && el.getAttribute("height") != null) {
			el.style.width = "" + w + "px";
			el.style.display = "block";
			el.style.width = "500px";
			el.style.height = "250px";
			el.style.objectFit = "cover";
			el.style.height = "" + Math.round(el.width * (h / w)) + "px";
		}
	}
	static main() {
		let app = new MonkeeWrenchLite();
	}
}
$hx_exports["MonkeeWrenchLite"] = MonkeeWrenchLite;
class StringTools {
	static replace(s,sub,by) {
		return s.split(sub).join(by);
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
MonkeeWrenchLite.VERSION = "0.0.7";
MonkeeWrenchLite.DEBUG = false;
MonkeeWrenchLite.main();
})(typeof exports != "undefined" ? exports : typeof window != "undefined" ? window : typeof self != "undefined" ? self : this, typeof window != "undefined" ? window : typeof global != "undefined" ? global : typeof self != "undefined" ? self : this);
