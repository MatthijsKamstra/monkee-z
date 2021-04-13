package;

import utils.Time;
import js.html.Element;
import js.Browser.*;
import js.html.XMLHttpRequest;
import AST.LoadObj;

class MonkeeLoadInner {
	var DEBUG = true;

	var req = new XMLHttpRequest();
	var dataAtr = "data-load-inner";
	var loadingArr:Array<LoadObj> = [];
	var loadingId = 0;
	var timer:Time;

	// modern solution
	// https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API/Using_Fetch

	public function new() {
		document.addEventListener('DOMContentLoaded', (event) -> {
			if (DEBUG)
				console.log('[MonkeeLoadInner] template loading');
			init();
		});
	}

	function init() {
		var arr = document.querySelectorAll('[${dataAtr}]');
		for (i in 0...arr.length) {
			var wrapper:Element = cast arr[i];
			var url = wrapper.getAttribute(dataAtr);
			var target = wrapper.getAttribute('data-target');
			var nameArr:Array<Element> = cast wrapper.querySelectorAll('[data-name]');
			if (DEBUG) {
				trace(target);
				trace(nameArr);
			}
			// if(DEBUG)console.log('templates url: ' + url);
			loadingArr.push({
				el: wrapper,
				url: url,
				target: target,
				names: nameArr,
			});
		}
		timer = new Time();
		timer.start();
		if (DEBUG)
			console.group('Monkee Loader Inner');
		startLoading(loadingId);
	}

	function startLoading(nr:Int) {
		if (nr >= loadingArr.length) {
			if (DEBUG)
				console.groupEnd();
			return;
		}
		var obj = loadingArr[nr];
		if (DEBUG) {
			console.log('start loading: ' + obj.url + ' into element');
			console.log(obj);
		}
		loadHTML(obj);
		loadingId++;
	}

	function loadHTML(obj:LoadObj) {
		req.open('GET', obj.url);
		req.onload = function() {
			// if(DEBUG)trace(req.response);
			var body = Html.getBody(req.response);
			// if(DEBUG)trace(body);
			if (body == "")
				body = req.response;
			// if(DEBUG)trace(body);

			// inject code
			if (obj.names.length > 0) {
				for (i in 0...obj.names.length) {
					var el = obj.names[i];
					Html.processHTML(body, el, true);
				}
			} else {
				Html.processHTML(body, obj.el, true);
			}
			if (DEBUG) {
				console.log('- end loading and parsing url: ' + obj.url + ' into element');
				console.log(timer.total());
			}

			// load the next
			startLoading(loadingId);
		};

		req.onerror = function(error) {
			if (DEBUG)
				console.error('[JS] error: $error');
		};

		req.send();
	}

	static public function main() {
		var app = new MonkeeLoadInner();
	}
}
