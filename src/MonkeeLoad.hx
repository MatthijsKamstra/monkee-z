package;

import js.html.Element;
import js.Browser.*;
import js.html.XMLHttpRequest;
import AST.LoadObj;

class MonkeeLoad {
	var DEBUG = false;
	var req = new XMLHttpRequest();
	var dataAtr = "data-load";
	var loadingArr:Array<LoadObj> = [];
	var loadingId = 0;
	var time = 0;
	var timeStart = .0;
	var timeEnd = .0;

	// modern solution
	// https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API/Using_Fetch

	public function new() {
		document.addEventListener('DOMContentLoaded', (event) -> {
			if (DEBUG)
				console.info(App.callIn('MonkeeLoad'));
			init();
		});
	}

	function init() {
		var arr = document.querySelectorAll('[${dataAtr}]');
		for (i in 0...arr.length) {
			var wrapper:Element = cast arr[i];
			var url = wrapper.getAttribute(dataAtr);
			if (DEBUG)
				console.log('templates url: ' + url);
			loadingArr.push({
				el: wrapper,
				url: url,
			});

			var _div = document.createDivElement();
			_div.className = 'loader';
			wrapper.appendChild(_div);
		}
		timeStart = Date.now().getTime();
		startLoading(loadingId);
	}

	function getCurrentTime() {
		timeEnd = Date.now().getTime();
		if (DEBUG)
			console.log((timeEnd - timeStart) + 'ms');
	}

	function startLoading(nr:Int) {
		if (nr >= loadingArr.length)
			return;
		var obj = loadingArr[nr];
		if (DEBUG)
			console.log('start loading: ' + obj.url + ' into element');
		loadHTML(obj.url, obj.el);
		loadingId++;
	}

	function loadHTML(url:String, el:js.html.Element) {
		req.open('GET', url);
		req.onload = function() {
			// if (DEBUG) trace(req.response);
			var body = getBody(req.response);
			// if (DEBUG) trace(body);
			if (body == "")
				body = req.response;
			// if (DEBUG) trace(body);

			// inject code
			processHTML(body, el);
			if (DEBUG)
				console.log('- end loading and parsing url: ' + url + ' into element');
			getCurrentTime();
			// load the next
			startLoading(loadingId);
		};

		req.onerror = function(error) {
			if (DEBUG)
				console.error('[JS] error: $error');
		};

		req.send();
	}

	/**
	 * extract the body (from documents that have a body)
	 *
	 * @param html
	 */
	function getBody(html) {
		var test:String = html.toLowerCase(); // to eliminate case sensitivity
		var x:Int = test.indexOf("<body");
		if (x == -1)
			return "";

		x = test.indexOf(">", x);
		if (x == -1)
			return "";
		var y = test.lastIndexOf("</body>");
		if (y == -1)
			y = test.lastIndexOf("</html>");
		if (y == -1)
			y = html.length; // If no HTML then just grab everything till end
		return html.slice(x + 1, y);
	}

	function processHTML(content:String, target:js.html.Element) {
		target.outerHTML = content;
	}

	function htmlToElement(html:String) {
		var template = document.createDivElement();
		html = untyped html.trim(); // Never return a text node of whitespace as the result
		template.innerHTML = html;
		return template.firstChild;
	}

	static public function main() {
		var app = new MonkeeLoad();
	}
}
