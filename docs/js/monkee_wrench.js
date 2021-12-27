(function ($hx_exports, $global) { "use strict";
class MonkeeWrench {
	constructor() {
		this.ROOT = window.location.host;
		this.DEBUG_IMAGES = ["https://matthijskamstra.github.io/monkee-z/assets/img/debug/146-500x500.jpg","https://matthijskamstra.github.io/monkee-z/assets/img/debug/500x500.jpg","https://matthijskamstra.github.io/monkee-z/assets/img/debug/1031-500x500.jpg"];
		let _gthis = this;
		window.document.addEventListener("DOMContentLoaded",function(event) {
			$global.console.groupCollapsed("🔧" + " Monkee-Wrench-Lite - v" + "0.0.4");
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
		this.buildSnackbar();
		if(myParam != null) {
			this.buildIcon();
			this.validateElementsOnPage();
			window.onkeydown = null;
		}
	}
	getkey(e) {
		if(e.key == "m") {
			this.buildIcon();
			this.validateElementsOnPage();
			window.onkeydown = null;
		}
	}
	validateElementsOnPage() {
		let elementsImg = window.document.getElementsByTagName("img");
		this.snackbarInfo("Checking images");
		let _g = 0;
		let _g1 = elementsImg.length;
		while(_g < _g1) {
			let i = _g++;
			this.snackbarInfo("Check image " + i);
			let el = elementsImg[i];
			let url = el.src;
			let w = el.width;
			let h = el.height;
			if(!this.UrlExists(url)) {
				this.snackbarInfo("Replacing image: " + url);
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
		this.snackbarInfo("Checking background-images");
		let _g2 = 0;
		let _g3 = elementsWithBG.length;
		while(_g2 < _g3) {
			let i = _g2++;
			let element = elementsWithBG[i];
			let url = StringTools.replace(StringTools.replace(StringTools.replace(StringTools.replace(element.style.backgroundImage,"'",""),"\"",""),"url(",""),")","");
			if(element.style.backgroundImage != "") {
				this.snackbarInfo("Check background-image " + i);
				element.dataset.monkeeWrenchCheck = "true";
			}
			if(!this.UrlExists(url)) {
				this.snackbarInfo("Replacing background-image: " + url);
				element.dataset.monkeeWrenchCheck = "true";
				element.dataset.monkeeWrenchBgImageReplace = "true";
				element.style.backgroundImage = "url(" + this.DEBUG_IMAGES[1] + ")";
				this.addBGImageLabel(element);
			}
		}
		let elementsVideo = window.document.getElementsByTagName("video");
		this.snackbarInfo("Checking video");
		let _g4 = 0;
		let _g5 = elementsVideo.length;
		while(_g4 < _g5) {
			let i = _g4++;
			let element = elementsVideo[i];
			element.dataset.monkeeWrenchCheck = "true";
			let url = element.poster;
			if(!this.UrlExists(url)) {
				this.snackbarInfo("Replacing video: " + url);
				element.dataset.monkeeWrenchPosterImageReplace = "true";
				element.poster = this.DEBUG_IMAGES[2];
			}
		}
		let elementsLinks = window.document.getElementsByTagName("a");
		this.snackbarInfo("Checking links");
		let _g6 = 0;
		let _g7 = elementsLinks.length;
		while(_g6 < _g7) {
			let i = _g6++;
			let el = elementsLinks[i];
			el.dataset.monkeeWrenchCheck = "true";
			let url = el.href;
			let href = el.getAttribute("href");
			let id = el.id;
			if(el.getAttribute("name") != null) {
				continue;
			}
			if(href == "" || href == "#" || href == null) {
				this.snackbarInfo("Checking empty links");
				el.dataset.monkeWrenchEmptyLink = "true";
				el.innerHTML = "🔧" + " " + el.innerHTML;
			}
			if(href == null || href.indexOf("javascript") != -1) {
				continue;
			}
			if(href.startsWith("/") || href.indexOf(this.ROOT) != -1) {
				if(!this.UrlExists(url)) {
					this.snackbarInfo("Checking dead links " + url);
					el.dataset.monkeeWrenchDeadlink = "true";
					el.innerHTML = "❌" + " " + el.innerHTML;
				}
			}
		}
		this.isSnackbarVisible(false);
	}
	buildSnackbar() {
		this.snackbar = window.document.createElement("div");
		this.snackbar.innerHTML = "some text";
		this.snackbar.id = "snackbar";
		this.snackbar.setAttribute("style","visibility: hidden;min-width: 250px;transform: translate(-50%,0);background-color: #333;color: #fff;text-align: center;border-radius: 2px;padding: 16px; position: fixed;z-index: 1;left: 50%;bottom: 30px;");
		window.document.body.appendChild(this.snackbar);
	}
	snackbarInfo(msg) {
		this.isSnackbarVisible(true);
		this.snackbar.innerHTML = msg;
	}
	isSnackbarVisible(isVisible) {
		if(isVisible == null) {
			isVisible = true;
		}
		if(isVisible) {
			this.snackbar.style.visibility = "visible";
		} else {
			this.snackbar.style.visibility = "hidden";
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
			_gthis.validateElementsOnPage();
		};
		window.document.body.appendChild(btn);
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
				console.log("src/MonkeeWrench.hx:332:","json: " + json);
				cb.apply(_gthis,[]);
			} else {
				console.log("src/MonkeeWrench.hx:337:","oeps: status: " + request.status + " // json: " + request.responseText);
			}
		};
		request.onerror = function() {
			console.log("src/MonkeeWrench.hx:343:","error");
		};
		request.send();
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
MonkeeWrench.VERSION = "0.0.4";
MonkeeWrench.DEBUG = false;
MonkeeWrench.main();
})(typeof exports != "undefined" ? exports : typeof window != "undefined" ? window : typeof self != "undefined" ? self : this, typeof window != "undefined" ? window : typeof global != "undefined" ? global : typeof self != "undefined" ? self : this);
