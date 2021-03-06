(function ($global) { "use strict";
class MonkeeLoadLite {
	constructor() {
		this.loadingId = 0;
		this.loadingArr = [];
		this.req = new XMLHttpRequest();
		this.arr = ["data-load","data-load-replace","data-load-inner"];
		let _g = 0;
		let _g1 = this.arr.length;
		while(_g < _g1) {
			let i = _g++;
			let _configName = this.arr[i];
			let elements = window.document.querySelectorAll("[" + _configName + "]");
			let _g1 = 0;
			let _g2 = elements.length;
			while(_g1 < _g2) {
				let i = _g1++;
				let wrapper = elements[i];
				let url = wrapper.getAttribute(_configName);
				this.loadingArr.push({ el : wrapper, url : url, loaderType : "data-load-inner" == _configName ? "inner" : "outer"});
			}
		}
		this.startLoading(this.loadingId);
	}
	startLoading(nr) {
		if(nr >= this.loadingArr.length) {
			return;
		}
		this.loadData(this.loadingArr[nr]);
		this.loadingId++;
	}
	loadData(obj) {
		obj.el.classList.add("monkee-load-loading");
		this.req.open("GET",obj.url);
		let _gthis = this;
		this.req.onload = function() {
			obj.el.classList.remove("monkee-load-loading");
			let body = _gthis.req.response;
			utils_Html.processHTML(obj.el,body,obj.loaderType == "inner");
			_gthis.startLoading(_gthis.loadingId);
		};
		this.req.onerror = function(error) {
			$global.console.error("error: " + error);
		};
		this.req.send();
	}
	static main() {
		window.document.addEventListener("DOMContentLoaded",function(event) {
			let app = new MonkeeLoadLite();
		});
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
class utils_Html {
	static processHTML(target,html,isInner) {
		if(isInner) {
			target.innerHTML = html;
		} else {
			target.outerHTML = html;
		}
	}
}
{
}
MonkeeLoadLite.main();
})(typeof window != "undefined" ? window : typeof global != "undefined" ? global : typeof self != "undefined" ? self : this);
