(function ($hx_exports, $global) { "use strict";
class MonkeeWrench {
	constructor() {
		this.DEBUG = false;
		let _version = "0.0.1";
		$global.console.info("[Monkee-Z]" + " " + ("Wrench " + "🔧") + " - version: " + _version);
		let _gthis = this;
		window.document.addEventListener("DOMContentLoaded",function(event) {
			$global.console.group("Monkee " + "🔧");
			$global.console.log("focus browser and press \"m\"");
			$global.console.log("or use " + window.location.href + "?replaceimages");
			$global.console.groupEnd();
			_gthis.init();
		});
	}
	UrlExists(url) {
		let http = new XMLHttpRequest();
		http.open("HEAD",url,false);
		http.send();
		return http.status != 404;
	}
	getkey(e) {
		if(e.key == "m") {
			this.buildIcon();
			this.replaceMissingAssets();
		}
	}
	buildIcon() {
		let btn = window.document.createElement("div");
		btn.innerHTML = "🔧";
		btn.className = "btn btn-outline-dark";
		btn.title = "Monkee Wrench is used";
		btn.setAttribute("style","position: fixed;bottom: 10px;left: 10px;");
		let _gthis = this;
		btn.onclick = function() {
			_gthis.replaceMissingAssets();
		};
		window.document.body.appendChild(btn);
	}
	init() {
		let _gthis = this;
		window.onkeydown = function(e) {
			_gthis.getkey(e);
		};
		let urlParams = new URLSearchParams(window.location.search);
		let myParam = urlParams.get("replaceimages");
		if(myParam != null) {
			this.buildIcon();
			this.replaceMissingAssets();
		}
	}
	replaceMissingAssets() {
		let elementsImg = window.document.getElementsByTagName("img");
		let _g = 0;
		let _g1 = elementsImg.length;
		while(_g < _g1) {
			let i = _g++;
			let element = elementsImg[i];
			let url = element.src;
			if(!this.UrlExists(url)) {
				element.dataset.replaceimage = "true";
				element.src = "../assets/img/debug/1031-500x500.jpg";
			}
		}
		let elementsWithBG = window.document.getElementsByTagName("*");
		let _g2 = 0;
		let _g3 = elementsWithBG.length;
		while(_g2 < _g3) {
			let i = _g2++;
			let element = elementsWithBG[i];
			let url = StringTools.replace(StringTools.replace(StringTools.replace(StringTools.replace(element.style.backgroundImage,"'",""),"\"",""),"url(",""),")","");
			if(!this.UrlExists(url)) {
				element.dataset.replaceimage = "true";
				element.style.backgroundImage = "url(../assets/img/debug/500x500.jpg)";
			}
		}
		let elementsVideo = window.document.getElementsByTagName("video");
		let _g4 = 0;
		let _g5 = elementsVideo.length;
		while(_g4 < _g5) {
			let i = _g4++;
			let element = elementsVideo[i];
			let url = element.poster;
			if(!this.UrlExists(url)) {
				element.dataset.replaceimage = "true";
				element.poster = "../assets/img/debug/146-500x500.jpg";
			}
		}
	}
	static main() {
		let app = new MonkeeWrench();
	}
}
$hx_exports["MonkeeWrench"] = MonkeeWrench;
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
{
}
MonkeeWrench.VERSION = "0.0.1";
MonkeeWrench.main();
})(typeof exports != "undefined" ? exports : typeof window != "undefined" ? window : typeof self != "undefined" ? self : this, typeof window != "undefined" ? window : typeof global != "undefined" ? global : typeof self != "undefined" ? self : this);
