package;

import utils.Html;
import utils.JsonPath;
import haxe.Json;
import js.html.InputElement;
import utils.Time;
import utils.Throbber;
import js.html.Element;
import js.Browser.*;
import js.html.XMLHttpRequest;
import AST.LoadObj;

using StringTools;
using Lambda;

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
		if (DEBUG)
			console.info(App.callIn('MonkeeLoad'));

		for (i in 0...arr.length) {
			var _configName = arr[i];
			var _elements = document.querySelectorAll('[${_configName}]');
			for (i in 0..._elements.length) {
				var _el:Element = cast _elements[i];
				var _url = _el.getAttribute(_configName);
				var _isJson = _url.indexOf('.json') != -1;
				var _target = _el.getAttribute('data-target');
				var _nameArr:Array<Element> = cast _el.querySelectorAll('[data-name]');
				var _loadObj:LoadObj = {
					el: _el,
					url: _url,
					isJson: _isJson,
					isInner: (_configName == 'data-load-inner'),
					loaderType: ('data-load-inner' == _configName) ? 'inner' : 'outer',
					target: _target,
					names: _nameArr,
					throbber: Throbber.set(_el),
				}
				// if (_isJson) {}
				loadingArr.push(_loadObj);
				// trace(loadingArr);
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
			// remove throbber
			if (obj.throbber != null)
				obj.throbber.parentElement.removeChild(obj.throbber);

			// body
			var body = Html.getBody(req.response);
			if (body == "")
				body = req.response;

			// Html.processHTML(obj.el, body, obj.loaderType == 'inner');

			if (obj.isJson) {
				if (DEBUG)
					console.warn(obj.url);

				jsonConvert(obj, req.response);
			} else {
				// inject code
				if (obj.names.length > 0) {
					for (i in 0...obj.names.length) {
						var el = obj.names[i];
						Html.processHTML(el, body, obj.isInner);
					}
				} else {
					Html.processHTML(obj.el, body, obj.isInner);
				}
			}

			// load the next
			startLoading(loadingId);
		};

		req.onerror = function(error) {
			// if (DEBUG)
			console.error('error: $error');
		};

		req.send();
	}

	function jsonConvert(obj:LoadObj, str:String) {
		var json = Json.parse(str);

		// if (DEBUG) {
		// 	// console.warn(json);
		// 	// trace(json.firstname);
		// 	// trace(Reflect.getProperty(json, 'firstname'));
		// 	// trace(untyped json['lastname']);
		// }
		if (obj.names.length > 0) {
			for (i in 0...obj.names.length) {
				// trace(obj.names[i]);
				// trace(obj.names[i].nodeName);
				// trace(obj.names[i].tagName);
				var tag = obj.names[i].tagName.toLowerCase();
				switch (tag) {
					case 'input':
						// trace('input');
						var input:InputElement = cast obj.names[i];
						// input.value = Reflect.getProperty(json, input.getAttribute('data-name'));
						input.value = untyped json[input.getAttribute('data-name')];
					// case 'code', 'pre':
					default:
						// trace("case '" + tag + "': trace ('" + tag + "');");
						// trace('code');
						var el = cast obj.names[i];
						var attr:String = el.getAttribute('data-name');
						var data = JsonPath.search(Json.stringify(json), attr);
						el.innerHTML = data;
				}
			}
		} else {
			Html.processHTML(obj.el, str, true);
		}
	}

	static public function main() {
		document.addEventListener('DOMContentLoaded', (event) -> {
			var app = new MonkeeLoad();
		});
	}
}
