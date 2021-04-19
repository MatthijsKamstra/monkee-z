// Generated by Haxe 4.1.5
(function ($global) { "use strict";
class MonkeeRoute {
	constructor() {
		this.all = [];
		this.DEBUG = true;
		let _gthis = this;
		window.document.addEventListener("DOMContentLoaded",function(event) {
			if(_gthis.DEBUG) {
				$global.console.info("[monkee]" + " - " + "MonkeeRoute" + " - build: " + "2021-04-19 20:53:10");
			}
			_gthis.init();
		});
	}
	init() {
		let arr = [];
		let _gthis = this;
		arr = window.document.getElementsByTagName("a");
		let _g = 0;
		let _g1 = arr.length;
		while(_g < _g1) {
			let i = _g++;
			let a = arr[i];
			a.onclick = function(e) {
				e.preventDefault();
				window.fetch(a.href + ".html").then(function(response) {
					return response.text();
				}).then(function(data) {
					_gthis.replaceBody(a,data);
				});
			};
		}
	}
	replaceBody(a,html) {
		let state = { };
		let title = "";
		let url = "";
		window.history.pushState(state,title,url);
		this.all = Array.prototype.slice.call(window.document.body.children);
		window.document.body.innerHTML = html;
		let _g = 0;
		let _g1 = this.all.length;
		while(_g < _g1) {
			let i = _g++;
			let el = this.all[i];
			console.log("src/MonkeeRoute.hx:55:",el);
			console.log("src/MonkeeRoute.hx:56:",el.localName);
			if(el.localName == "script") {
				window.document.body.appendChild(el);
			}
		}
	}
	static main() {
		let app = new MonkeeRoute();
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
MonkeeRoute.main();
})(typeof window != "undefined" ? window : typeof global != "undefined" ? global : typeof self != "undefined" ? self : this);
