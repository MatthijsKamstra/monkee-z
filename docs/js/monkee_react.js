(function ($global) { "use strict";
class MonkeeReact {
	constructor() {
		window.document.addEventListener("DOMContentLoaded",function(event) {
			let _version = "0.0.2";
			$global.console.info("[Monkee-Z]" + " " + "React" + " - version: " + _version);
		});
		let arr = window.document.querySelectorAll("[data-wrapper]");
		let _g = 0;
		let _g1 = arr.length;
		while(_g < _g1) {
			let i = _g++;
			let wrapper = arr[i];
			let wrapperName = wrapper.getAttribute("data-wrapper");
			let dataOutArr = wrapper.querySelectorAll("[data-out]");
			let dataInArr = wrapper.querySelectorAll("[data-in]");
			let _g1 = 0;
			let _g2 = dataInArr.length;
			while(_g1 < _g2) {
				let j = _g1++;
				let el = dataInArr[j];
				el.onkeypress = function(e) {
					let key = e.key;
					let value = e.target.value;
					let total = "" + value + key;
					let _g = 0;
					let _g1 = dataOutArr.length;
					while(_g < _g1) {
						let i = _g++;
						let el = dataOutArr[i];
						el.innerText = total;
					}
				};
			}
		}
	}
	static main() {
		let app = new MonkeeReact();
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
MonkeeReact.main();
})(typeof window != "undefined" ? window : typeof global != "undefined" ? global : typeof self != "undefined" ? self : this);
