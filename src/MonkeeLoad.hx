package;

import utils.Html;
import js.html.InputElement;
import haxe.Json;
import js.html.Element;
import js.Browser.*;
import js.html.XMLHttpRequest;
import AST.LoadObj;

class MonkeeLoad {
	var DEBUG = true;

	// do we need this?
	// var config = {
	// 	inner: 'data-load-inner', // inner
	// 	outer: 'data-load', // outer
	// 	replace: 'data-load-replace' // outer
	// }
	var arr = ['data-load', 'data-load-replace', 'data-load-inner'];
	var req = new XMLHttpRequest();
	var loadingArr:Array<LoadObj> = [];
	var loadingId = 0;

	public function new() {
		// if (DEBUG)
		// 	console.info(App.callIn('MonkeeLoad lite'));

		for (i in 0...arr.length) {
			var _configName = arr[i];
			var elements = document.querySelectorAll('[${_configName}]');
			for (i in 0...elements.length) {
				var wrapper:Element = cast elements[i];
				var url = wrapper.getAttribute(_configName);
				loadingArr.push({
					el: wrapper,
					url: url,
					loaderType: ('data-load-inner' == _configName) ? 'inner' : 'outer'
				});
			}
		}
		startLoading(loadingId);
	}

	function startLoading(nr:Int) {
		if (nr >= loadingArr.length) {
			return;
		}
		loadData(loadingArr[nr]);
		loadingId++;
	}

	function loadData(obj:LoadObj) {
		req.open('GET', obj.url);
		req.onload = function() {
			// make it smaller, by assuming files are without html
			var body = (req.response);
			Html.processHTML(obj.el, body, obj.loaderType == 'inner');
			// load the next
			startLoading(loadingId);
		};

		req.onerror = function(error) {
			// if (DEBUG)
			console.error('error: $error');
		};

		req.send();
	}

	static public function main() {
		document.addEventListener('DOMContentLoaded', (event) -> {
			var app = new MonkeeLoad();
		});
	}
}
