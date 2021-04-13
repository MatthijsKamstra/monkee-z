package;

import js.Browser.*;
import js.Browser;
import js.html.*;

class MonkeeReact {
	var DEBUG = false;

	public function new() {
		document.addEventListener('DOMContentLoaded', (event) -> {
			if (DEBUG)
				trace('MonkeeReact');
		});

		var arr = document.querySelectorAll('[data-wrapper]');
		for (i in 0...arr.length) {
			var wrapper:Element = cast arr[i];
			var wrapperName = (wrapper.getAttribute('data-wrapper'));
			// get all data-in from wrapper
			var dataOutArr = wrapper.querySelectorAll('[data-out]');
			// for (j in 0...dataOutArr.length) {
			// 	var el = dataOutArr[j];
			// 	if(DEBUG)trace(el);
			// }
			// get all data-out from wrapper
			var dataInArr = wrapper.querySelectorAll('[data-in]');
			for (j in 0...dataInArr.length) {
				var el:Element = cast dataInArr[j];
				el.onkeypress = function(e:KeyboardEvent) {
					var key = (e.key);
					var value = untyped e.target.value; // cast will add to much haxe stuff to the output
					var total = '${value}${key}';
					for (i in 0...dataOutArr.length) {
						var el:Element = cast dataOutArr[i];
						el.innerText = total;
					}
				}
			}
		}
	}

	static public function main() {
		var app = new MonkeeReact();
	}
}
