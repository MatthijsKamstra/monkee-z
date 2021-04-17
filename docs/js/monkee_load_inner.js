// Generated by Haxe 4.1.5
(function ($global) { "use strict";
class MonkeeLoadInner {
	constructor() {
		this.loadingId = 0;
		this.loadingArr = [];
		this.dataAtr = "data-load-inner";
		this.req = new XMLHttpRequest();
		this.DEBUG = false;
		let _gthis = this;
		window.document.addEventListener("DOMContentLoaded",function(event) {
			if(_gthis.DEBUG) {
				$global.console.info("[monkee]" + " - " + "MonkeeLoadInner" + " - build: " + "2021-04-17 21:47:32");
			}
			_gthis.init();
		});
	}
	init() {
		let arr = window.document.querySelectorAll("[" + this.dataAtr + "]");
		let _g = 0;
		let _g1 = arr.length;
		while(_g < _g1) {
			let i = _g++;
			let wrapper = arr[i];
			let url = wrapper.getAttribute(this.dataAtr);
			let target = wrapper.getAttribute("data-target");
			let nameArr = wrapper.querySelectorAll("[data-name]");
			if(this.DEBUG) {
				console.log("src/MonkeeLoadInner.hx:40:",target);
				console.log("src/MonkeeLoadInner.hx:41:",nameArr);
			}
			this.loadingArr.push({ el : wrapper, url : url, target : target, names : nameArr});
		}
		this.timer = new utils_Time();
		this.timer.start();
		if(this.DEBUG) {
			$global.console.group("Monkee Loader Inner");
		}
		this.startLoading(this.loadingId);
	}
	startLoading(nr) {
		if(nr >= this.loadingArr.length) {
			if(this.DEBUG) {
				$global.console.groupEnd();
			}
			return;
		}
		let obj = this.loadingArr[nr];
		if(this.DEBUG) {
			$global.console.log("start loading: " + obj.url + " into element");
			$global.console.log(obj);
		}
		this.loadData(obj);
		this.loadingId++;
	}
	loadData(obj) {
		let _gthis = this;
		this.req.open("GET",obj.url);
		this.req.onload = function() {
			let body = utils_Html.getBody(_gthis.req.response);
			if(body == "") {
				body = _gthis.req.response;
			}
			if(obj.url.indexOf("json") != -1) {
				if(_gthis.DEBUG) {
					$global.console.warn(obj.url);
				}
				_gthis.jsonConvert(obj,_gthis.req.response);
			} else if(obj.names.length > 0) {
				let _g = 0;
				let _g1 = obj.names.length;
				while(_g < _g1) {
					let i = _g++;
					let el = obj.names[i];
					utils_Html.processHTML(body,el,true);
				}
			} else {
				utils_Html.processHTML(body,obj.el,true);
			}
			if(_gthis.DEBUG) {
				$global.console.log("- end loading and parsing url: " + obj.url + " into element");
				$global.console.log(_gthis.timer.total());
			}
			_gthis.startLoading(_gthis.loadingId);
		};
		this.req.onerror = function(error) {
			if(_gthis.DEBUG) {
				$global.console.error("[JS] error: " + error);
			}
		};
		this.req.send();
	}
	jsonConvert(obj,str) {
		let json = JSON.parse(str);
		if(this.DEBUG) {
			console.log("src/MonkeeLoadInner.hx:123:",json["lastname"]);
		}
		if(obj.names.length > 0) {
			let _g = 0;
			let _g1 = obj.names.length;
			while(_g < _g1) {
				let i = _g++;
				let input = obj.names[i];
				input.value = json[input.getAttribute("data-name")];
			}
		} else {
			utils_Html.processHTML(str,obj.el,true);
		}
	}
	static main() {
		let app = new MonkeeLoadInner();
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
	static getBody(html) {
		let test = html.toLowerCase();
		let x = test.indexOf("<body");
		if(x == -1) {
			return "";
		}
		x = test.indexOf(">",x);
		if(x == -1) {
			return "";
		}
		let y = test.lastIndexOf("</body>");
		if(y == -1) {
			y = test.lastIndexOf("</html>");
		}
		if(y == -1) {
			y = html.length;
		}
		return html.slice(x + 1,y);
	}
	static processHTML(html,target,isInner) {
		if(isInner == null) {
			isInner = true;
		}
		if(isInner) {
			target.innerHTML = html;
		} else {
			target.outerHTML = html;
		}
	}
}
class utils_Time {
	constructor() {
		this.endtime = .0;
		this.starttime = .0;
		this.starttime = utils_Time.get();
	}
	start() {
		this.starttime = utils_Time.get();
	}
	total() {
		this.endtime = utils_Time.get();
		return this.endtime - this.starttime + "ms";
	}
	static get() {
		return new Date().getTime();
	}
}
MonkeeLoadInner.main();
})(typeof window != "undefined" ? window : typeof global != "undefined" ? global : typeof self != "undefined" ? self : this);
