(function ($global) { "use strict";
class MonkeeRoute {
	constructor() {
		let _gthis = this;
		window.document.addEventListener("DOMContentLoaded",function(event) {
			let _version = "0.0.4";
			$global.console.info("[Monkee-Z]" + " " + "Route" + " - version: " + _version);
			_gthis.setupRoute();
		});
	}
	setupRoute() {
		if(MonkeeRoute.defaultTitle == "") {
			MonkeeRoute.defaultTitle = window.document.title;
			MonkeeRoute.defaultUrl = window.window.location.href.split("#").join("");
			MonkeeRoute.previousLocationHref = MonkeeRoute.defaultUrl;
			this.removeHash();
			MonkeeRoute.map.h[""] = { link : null, url : MonkeeRoute.defaultUrl, id : ""};
		}
		let arr = [];
		let el = window.document.querySelector("[monkee-404]");
		if(el != null) {
			arr.push(el);
		}
		let _hidden = window.document.querySelectorAll("[monkee-hidden]");
		if(_hidden.length > 0) {
			let _g = 0;
			let _g1 = _hidden.length;
			while(_g < _g1) {
				let i = _g++;
				arr.push(_hidden[i]);
			}
		}
		let _monkee = window.document.querySelectorAll("[monkee]");
		if(_monkee.length > 0) {
			let _g = 0;
			let _g1 = _monkee.length;
			while(_g < _g1) {
				let i = _g++;
				arr.push(_monkee[i]);
			}
		}
		let _gthis = this;
		let _g = 0;
		let _g1 = arr.length;
		while(_g < _g1) {
			let i = _g++;
			let _link = arr[i];
			let _url = _link.href.indexOf(".html") == -1 ? _link.href + ".html" : _link.href;
			let _name = _url.split("/")[_url.split("/").length - 1].split(".")[0];
			let navObj = { link : _link, url : _url, id : _name};
			if(!Object.prototype.hasOwnProperty.call(MonkeeRoute.map.h,_name)) {
				MonkeeRoute.map.h[_name] = navObj;
			}
			_link.dataset.monkeeroute = "🐵";
			_link.onclick = function(e) {
				e.preventDefault();
				window.fetch(navObj.url).then(function(response) {
					return response.text();
				}).then(function(data) {
					_gthis.replaceBody(navObj,data);
				});
			};
		}
		window.addEventListener("onLoadUpdate",function(e) {
			_gthis.setupRoute();
		},true);
		window.onhashchange = $bind(this,this.locationHashChanged);
	}
	removeHash() {
		window.history.pushState("",window.document.title,window.window.location.pathname + window.window.location.search);
	}
	locationHashChanged() {
		let key = window.location.hash.split("#/").join("");
		let _gthis = this;
		if(Object.prototype.hasOwnProperty.call(MonkeeRoute.map.h,key)) {
			let navObj = MonkeeRoute.map.h[key];
			if(navObj.url == MonkeeRoute.defaultUrl) {
				window.location.reload();
			} else {
				window.fetch(navObj.url).then(function(response) {
					return response.text();
				}).then(function(data) {
					_gthis.replaceBody(navObj,data);
				});
			}
		} else if(window.location.hash.indexOf("#/") == -1) {
			if(MonkeeRoute.previousLocationHref == window.window.location.href) {
				window.location.reload();
			}
		} else if(Object.prototype.hasOwnProperty.call(MonkeeRoute.map.h,"404")) {
			let navObj = MonkeeRoute.map.h["404"];
			window.fetch(navObj.url).then(function(response) {
				return response.text();
			}).then(function(data) {
				_gthis.replaceBody(navObj,data);
			});
		} else {
			$global.console.info("unknown - " + MonkeeRoute.defaultUrl);
			window.window.location.href = MonkeeRoute.defaultUrl;
			window.location.reload();
			MonkeeRoute.previousLocationHref = window.window.location.href;
		}
	}
	replaceBody(navObj,html) {
		let tmp = MonkeeRoute.defaultTitle + " : ";
		window.document.title = tmp + navObj.id;
		if(navObj.id != "404") {
			window.location.hash = "/" + navObj.id;
		}
		MonkeeRoute.previousLocationHref = MonkeeRoute.defaultUrl;
		let all = Array.prototype.slice.call(window.document.body.children);
		window.document.body.innerHTML = html;
		let _g = 0;
		let _g1 = all.length;
		while(_g < _g1) {
			let i = _g++;
			let el = all[i];
			if(el.localName == "script") {
				window.document.body.appendChild(el);
			}
		}
		let _gthis = this;
		window.setTimeout(function() {
			_gthis.setupRoute();
		},50);
	}
	static main() {
		let app = new MonkeeRoute();
	}
}
class haxe_ds_StringMap {
	constructor() {
		this.h = Object.create(null);
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
MonkeeRoute.map = new haxe_ds_StringMap();
MonkeeRoute.defaultTitle = "";
MonkeeRoute.defaultUrl = "";
MonkeeRoute.previousLocationHref = "";
MonkeeRoute.main();
})(typeof window != "undefined" ? window : typeof global != "undefined" ? global : typeof self != "undefined" ? self : this);
