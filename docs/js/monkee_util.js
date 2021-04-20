// Generated by Haxe 4.1.5
(function ($hx_exports, $global) { "use strict";
class MonkeeUtil {
	constructor() {
		$global.console.info("[monkee]" + " - " + "MonkeeUtil" + " - build: " + "2021-04-19 20:38:35");
		this.init();
	}
	init() {
		let all = window.document.querySelectorAll("[data-escape]");
		let _g = 0;
		let _g1 = all.length;
		while(_g < _g1) {
			let i = _g++;
			let el = all[i];
			let html = el.getAttribute("data-escape");
			el.innerHTML = MonkeeUtil.escapeHTML(html);
		}
	}
	static escapeHTML(html) {
		return StringTools.replace(StringTools.replace(StringTools.replace(StringTools.replace(html,"&","&amp;"),"\"","&quot;"),"<","&lt;"),">","&gt;");
	}
	static main() {
		window.document.addEventListener("DOMContentLoaded",function(event) {
			let app = new MonkeeUtil();
		});
	}
}
$hx_exports["MonkeeUtil"] = MonkeeUtil;
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
MonkeeUtil.main();
})(typeof exports != "undefined" ? exports : typeof window != "undefined" ? window : typeof self != "undefined" ? self : this, typeof window != "undefined" ? window : typeof global != "undefined" ? global : typeof self != "undefined" ? self : this);

//# sourceMappingURL=monkee_util.js.map