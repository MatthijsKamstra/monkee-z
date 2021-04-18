// Generated by Haxe 4.1.5
(function ($hx_exports, $global) { "use strict";
class MonkeeChain {
	constructor(target,obj) {
		this.template = null;
		this.data = { };
		this.target = null;
		this.targetName = "";
		this.DEBUG = true;
		if(this.DEBUG) {
			$global.console.info("[monkee]" + " - " + "MonkeeChain" + " - build: " + "2021-04-18 21:46:38");
		}
		if(typeof(target) == "string") {
			this.targetName = target;
			this.target = window.document.querySelector(target);
		} else {
			this.targetName = target.id;
			this.target = target;
		}
		if(this.target == null) {
			$global.console.error("Target \"" + this.targetName + "\" possibly not correct target/no element");
			return;
		}
		if(obj.data != null && obj.data != { }) {
			this.data = obj.data;
		}
		if(obj.template != null && obj.template != "") {
			this.template = obj.template;
		} else {
			$global.console.error("Element \"" + this.targetName + "\" has template: " + JSON.stringify(obj.template));
		}
		this.render();
	}
	render() {
		if(typeof(this.template) == "string") {
			this.target.innerHTML = this.template;
		} else {
			this.target.innerHTML = this.template.call(this,this.data);
		}
	}
}
$hx_exports["MonkeeChain"] = MonkeeChain;
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
})(typeof exports != "undefined" ? exports : typeof window != "undefined" ? window : typeof self != "undefined" ? self : this, typeof window != "undefined" ? window : typeof global != "undefined" ? global : typeof self != "undefined" ? self : this);

//# sourceMappingURL=monkee_chain.js.map