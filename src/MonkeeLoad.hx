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
					url: unquery(_url),
					query: query(_url),
					isJson: _isJson,
					isInner: (_configName == 'data-load-inner'),
					loaderType: ('data-load-inner' == _configName) ? 'inner' : 'outer',
					target: _target,
					names: _nameArr,
					throbber: Throbber.set(_el),
				}

				trace(_loadObj);

				// if (_isJson) {}
				loadingArr.push(_loadObj);
				// trace(loadingArr);
			}
		}
		startLoading(loadingId);
	}

	/**
	 * @example
	 * 			"../../components/hero.html?test=hero"
	 * @param url
	 */
	function query(url:String) {
		var obj = null;
		if (url.indexOf('?') != -1) {
			var q = url.split('?')[1]; // test=hero
			var _var0 = q.split('=')[0];
			var _var1 = q.split('=')[1];
			obj = {};
			Reflect.setField(obj, '${_var0}', _var1);
		}
		return obj;
	}

	function unquery(url:String) {
		var _url = url;
		if (url.indexOf('?') != -1) {
			_url = url.split('?')[0];
		}
		return _url;
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

			var script = Html.getScript(req.response);

			// Html.processHTML(obj.el, body, obj.loaderType == 'inner');

			if (obj.query != null) {
				console.warn(obj.query);
				convertTemplate(obj, req.response);
			} else if (obj.isJson) {
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

			// inject script from templates
			if (script != "") {
				// [mck] this is probably the worst idea I had, but lets see where this goes
				// trace('add script element');
				var scriptEl = document.createScriptElement();
				scriptEl.innerHTML = script;
				document.body.appendChild(scriptEl);
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

	function convertTemplate(obj:LoadObj, template:String) {
		var startIndex = template.indexOf('{');
		var endIndex = template.indexOf('}');

		var word = template.substring(startIndex + 1, endIndex).trim();
		var _replace = template.substring(startIndex, endIndex + 1);

		trace(word);
		trace(obj.query);
		trace(Reflect.getProperty(obj.query, '${word}'));

		template = template.replace(_replace, Reflect.getProperty(obj.query, '${word}'));

		Html.processHTML(obj.el, template, obj.isInner);
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
