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

class MonkeeJson {
	var DEBUG = false;
	var req = new XMLHttpRequest();
	var dataAttributesArr = ['data-load', 'data-load-inner'];
	var loadingArr:Array<LoadObj> = [];
	var loadingId = 0;

	public function new() {
		document.addEventListener('DOMContentLoaded', (event) -> {
			if (DEBUG)
				console.info(App.callIn('MonkeeJson'));
			init();
		});
	}

	function init() {
		for (i in 0...dataAttributesArr.length) {
			var dataAtr = dataAttributesArr[i];
			var arr = document.querySelectorAll('[${dataAtr}]');
			for (i in 0...arr.length) {
				var wrapper:Element = cast arr[i];
				var url = wrapper.getAttribute(dataAtr);
				var target = wrapper.getAttribute('data-target');
				var nameArr:Array<Element> = cast wrapper.querySelectorAll('[data-name]');

				// trace(dataAtr);

				loadingArr.push({
					el: wrapper,
					url: url,
					target: target,
					names: nameArr,
					throbber: Throbber.set(wrapper),
					starttime: Date.now().getTime(),
					type: dataAtr,
					isInner: (dataAtr == 'data-load-inner'),
				});
			}
		}
		startLoading(loadingId);
	}

	function startLoading(nr:Int) {
		if (nr >= loadingArr.length) {
			return;
		}
		var obj = loadingArr[nr];
		loadData(obj);
		loadingId++;
	}

	function loadData(obj:LoadObj) {
		req.open('GET', obj.url);
		req.onload = function() {
			// set loading time
			obj.endtime = Date.now().getTime();
			// remove throbber
			obj.throbber.parentElement.removeChild(obj.throbber);
			var body = Html.getBody(req.response);
			if (body == "")
				body = req.response;

			console.log('${obj.url}: ' + (obj.endtime - obj.starttime) + 'ms');

			if (obj.url.indexOf('json') != -1) {
				if (DEBUG)
					console.warn(obj.url);

				jsonConvert(obj, req.response);
			} else {
				// inject code
				if (obj.names.length > 0) {
					for (i in 0...obj.names.length) {
						var el = obj.names[i];
						Html.processHTML(body, el, obj.isInner);
					}
				} else {
					Html.processHTML(body, obj.el, obj.isInner);
				}
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
			Html.processHTML(str, obj.el, true);
		}
	}

	static public function main() {
		var app = new MonkeeJson();
	}
}
