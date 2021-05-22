package;

import utils.Emoji;
import js.html.svg.Element;
import js.Browser.*;
import js.html.*;

class MonkeeRoute {
	#if debug
	var DEBUG = true;
	#else
	var DEBUG = false;
	#end

	// get all possible pages to go to, only works when you start at the first page.
	public static var map:Map<String, NavObj> = [];
	public static var defaultTitle = '';
	public static var defaultUrl = '';
	public static var previousLocationHref = '';

	public function new() {
		document.addEventListener('DOMContentLoaded', (event) -> {
			if (DEBUG)
				console.info(App.callIn('MonkeeRoute'));
			setupRoute();
		});
	}

	function setupRoute() {
		// console.info('------------------ setupRoute');

		// get one time the defaultTitle and set the hash to zero
		if (defaultTitle == '') {
			defaultTitle = document.title;
			defaultUrl = window.window.location.href.split('#').join(''); // foo/#
			// window.location.hash = ''; // might not be so good idea

			previousLocationHref = defaultUrl;

			// [mck] strip the first page from hash...
			// window.window.location.href = window.window.location.href.split('#')[0];
			removeHash();

			map.set('', {
				link: null,
				url: defaultUrl,
				hash: '',
			});
		}

		// trace(defaultUrl);
		// trace(map.get(''));

		var arr:Array<Element> = [];

		//  search all element with tag <a monkee>
		var el:Element = cast document.querySelector('[monkee-404]');
		if (el != null) {
			arr.push(el);
		}

		var _hidden:Array<Element> = cast document.querySelectorAll('[monkee-hidden]');
		if (_hidden.length > 0) {
			for (i in 0..._hidden.length) {
				arr.push(_hidden[i]);
			}
		}

		var _monkee:Array<Element> = cast document.querySelectorAll('[monkee]');
		if (_monkee.length > 0) {
			for (i in 0..._monkee.length) {
				arr.push(_monkee[i]);
			}
		}

		// var arr:Array<Element> = cast document.querySelectorAll('[monkee]');
		for (i in 0...arr.length) {
			var _link:LinkElement = cast arr[i];
			var _url = (_link.href.indexOf('.html') == -1) ? _link.href + '.html' : _link.href;
			var _name = (_url.split('/')[_url.split('/').length - 1]).split('.')[0];

			var navObj:NavObj = {
				link: _link,
				url: _url,
				hash: _name,
			};

			if (!map.exists(_name))
				map.set(_name, navObj);
			// trace(Lambda.count(map));

			_link.dataset.monkeeroute = '${Emoji.monkee}';
			_link.onclick = function(e:Event) {
				e.preventDefault();
				window.fetch(navObj.url)
					.then(response -> response.text())
					.then(data -> replaceBody(navObj, data));
			}
		}

		// Listen for the event from MonkeeLoad
		window.addEventListener(App.ON_LOAD_UPDATE, function(e) {
			// console.warn(e);
			// console.warn('----> ${App.ON_LOAD_UPDATE}');
			setupRoute();
		}, true);
		// Listen for the event from MonkeeLoad
		// window.addEventListener(App.ON_LOAD_READY, function(e) { console.warn(e);}, true);

		window.onhashchange = locationHashChanged;
	}

	function removeHash() {
		window.history.pushState("", document.title, window.window.location.pathname + window.window.location.search);
	}

	function locationHashChanged() {
		// console.log("You're visiting : " + window.location.hash);
		var key = (window.location.hash).split('#/').join('');
		trace(key);
		if (map.exists(key)) {
			var navObj = map.get(key);
			// trace(navObj);
			if (navObj.url == defaultUrl) {
				window.location.reload();
			} else {
				window.fetch(navObj.url)
					.then(response -> response.text())
					.then(data -> replaceBody(navObj, data));
			}
		} else {
			if (window.location.hash.indexOf('#/') == -1) {
				// console.log('use default action');

				if (previousLocationHref == window.window.location.href) {
					window.location.reload();
				}
			} else if (map.exists('404')) {
				var navObj = map.get('404');
				window.fetch(navObj.url)
					.then(response -> response.text())
					.then(data -> replaceBody(navObj, data));
			} else {
				console.info('unknown - ${defaultUrl}');
				window.window.location.href = defaultUrl;
				window.location.reload();
				previousLocationHref = window.window.location.href;
			}
		}
	}

	function replaceBody(navObj:NavObj, html:String) {
		document.title = defaultTitle + ' : ' + navObj.hash;
		if (navObj.hash != '404')
			window.location.hash = '/' + navObj.hash;

		previousLocationHref = defaultUrl;

		// before deleting all elements from body, store it
		var all = untyped Array.prototype.slice.call(document.body.children);
		// trace(all);

		// parse elements
		// [mck] replaces everything with the new html
		document.body.innerHTML = (html);

		// [mck] now put scripts back (maybe later other elements as well)
		for (i in 0...all.length) {
			var el:Element = cast all[i];
			// trace(el);
			// trace(el.localName);
			// for now, put scripts back
			if (el.localName == 'script') {
				document.body.appendChild(el);
			}
		}

		// [mck] make sure once the file is parsed, to check for new `<a monkee ` tags
		window.setTimeout(function() {
			setupRoute();
		}, 50);
	}

	static public function main() {
		var app = new MonkeeRoute();
	}
}

typedef NavObj = {
	@:optional var _id:String;
	var link:LinkElement;
	var url:String;
	var hash:String;
}
