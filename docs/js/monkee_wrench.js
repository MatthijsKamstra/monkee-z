(function ($hx_exports, $global) { "use strict";
class MonkeeWrench {
	constructor() {
		this.ROOT = window.location.host;
		this.DEBUG_IMAGES = ["../assets/img/debug/146-500x500.jpg","../assets/img/debug/500x500.jpg","../assets/img/debug/1031-500x500.jpg"];
		let _version = "0.0.1";
		_version = "2021-10-29 13:16:08";
		$global.console.info("[Monkee-Z]" + " " + ("Wrench " + "🔧") + " - version: " + _version);
		let _gthis = this;
		window.document.addEventListener("DOMContentLoaded",function(event) {
			$global.console.group("Monkee " + "🔧");
			$global.console.log("focus browser and press \"m\"");
			$global.console.log("or use " + window.location.href + "?monkeewrench");
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
	isUrlValid(url,cb) {
		let request = new XMLHttpRequest();
		request.open("GET",url,true);
		let _gthis = this;
		request.onload = function() {
			if(request.status >= 200 && request.status < 400) {
				let json = request.responseText;
				console.log("src/MonkeeWrench.hx:75:","json: " + json);
				cb.apply(_gthis,[]);
			} else {
				console.log("src/MonkeeWrench.hx:80:","oeps: status: " + request.status + " // json: " + request.responseText);
			}
		};
		request.onerror = function() {
			console.log("src/MonkeeWrench.hx:86:","error");
		};
		request.send();
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
		let myParam = urlParams.get("monkeewrench");
		if(myParam != null) {
			this.buildIcon();
			this.replaceMissingAssets();
		}
	}
	addImageLabel(el) {
		let div = window.document.createElement("div");
		div.innerHTML = "🔧" + " img";
		div.style.position = "absolute";
		div.style.bottom = "0px";
		div.style.right = "50%";
		div.style.backgroundColor = "yellow";
		div.style.fontSize = "8px";
		div.style.padding = "0px";
		div.style.paddingLeft = "5px";
		div.style.paddingRight = "5px";
		div.style.textTransform = "uppercase";
		div.style.transform = "translate(50%)";
		div.style.borderRadius = "1px";
		div.style.opacity = "0.5";
		el.parentElement.appendChild(div);
	}
	addBGImageLabel(el) {
		let div = window.document.createElement("div");
		div.innerHTML = "🔧" + " bg-img";
		div.style.position = "absolute";
		div.style.bottom = "0px";
		div.style.right = "50%";
		div.style.backgroundColor = "yellow";
		div.style.fontSize = "8px";
		div.style.padding = "0px";
		div.style.paddingLeft = "5px";
		div.style.paddingRight = "5px";
		div.style.textTransform = "uppercase";
		div.style.transform = "translate(50%)";
		div.style.borderRadius = "1px";
		div.style.opacity = "0.5";
		el.appendChild(div);
		el.style.position = "relative";
	}
	replaceMissingAssets() {
		let elementsImg = window.document.getElementsByTagName("img");
		let _g = 0;
		let _g1 = elementsImg.length;
		while(_g < _g1) {
			let i = _g++;
			let el = elementsImg[i];
			let url = el.src;
			let w = el.width;
			let h = el.height;
			if(!this.UrlExists(url)) {
				el.dataset.monkeeWrenchImageReplace = "true";
				el.src = this.DEBUG_IMAGES[0];
				this.addImageLabel(el);
				if(el.getAttribute("width") != null && el.getAttribute("height") != null) {
					el.style.width = "" + w + "px";
					el.style.display = "block";
					el.style.width = "500px";
					el.style.height = "250px";
					el.style.objectFit = "cover";
					el.style.height = "" + Math.round(el.width * (h / w)) + "px";
				}
			}
		}
		let elementsWithBG = window.document.getElementsByTagName("*");
		let _g2 = 0;
		let _g3 = elementsWithBG.length;
		while(_g2 < _g3) {
			let i = _g2++;
			let element = elementsWithBG[i];
			let url = StringTools.replace(StringTools.replace(StringTools.replace(StringTools.replace(element.style.backgroundImage,"'",""),"\"",""),"url(",""),")","");
			if(element.style.backgroundImage != "") {
				element.dataset.monkeeWrenchCheck = "true";
			}
			if(!this.UrlExists(url)) {
				element.dataset.monkeeWrenchCheck = "true";
				element.dataset.monkeeWrenchBgImageReplace = "true";
				element.style.backgroundImage = "url(" + this.DEBUG_IMAGES[1] + ")";
				this.addBGImageLabel(element);
			}
		}
		let elementsVideo = window.document.getElementsByTagName("video");
		let _g4 = 0;
		let _g5 = elementsVideo.length;
		while(_g4 < _g5) {
			let i = _g4++;
			let element = elementsVideo[i];
			element.dataset.monkeeWrenchCheck = "true";
			let url = element.poster;
			if(!this.UrlExists(url)) {
				element.dataset.monkeeWrenchPosterImageReplace = "true";
				element.poster = this.DEBUG_IMAGES[2];
			}
		}
		let elementsLinks = window.document.getElementsByTagName("a");
		let _g6 = 0;
		let _g7 = elementsLinks.length;
		while(_g6 < _g7) {
			let i = _g6++;
			let el = elementsLinks[i];
			el.dataset.monkeeWrenchCheck = "true";
			let url = el.href;
			let href = el.getAttribute("href");
			let id = el.id;
			if(href == "" || href == "#") {
				el.dataset.monkeeWrenchEmptyLink = "true";
				el.innerHTML = "🔧" + " " + el.innerHTML;
			}
			if(href.startsWith("/") || href.indexOf(this.ROOT) != -1) {
				if(!this.UrlExists(url)) {
					el.dataset.monkeeWrenchDeadlink = "true";
					el.innerHTML = "❌" + " " + el.innerHTML;
				}
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
MonkeeWrench.DEBUG = true;
MonkeeWrench.main();
})(typeof exports != "undefined" ? exports : typeof window != "undefined" ? window : typeof self != "undefined" ? self : this, typeof window != "undefined" ? window : typeof global != "undefined" ? global : typeof self != "undefined" ? self : this);

//# sourceMappingURL=monkee_wrench.js.map