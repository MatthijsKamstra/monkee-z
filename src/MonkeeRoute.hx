package;

import utils.Emoji;
import js.html.svg.Element;
import js.Browser.*;
import js.html.*;

class MonkeeRoute {
	var DEBUG = true;

	// get all possible pages to go to, only works when you start at the first page.
	public static var map:Map<String, NavObj> = [];
	public static var defaultTitle = '';
	public static var defaultUrl = '';

	// change title
	var title = '';

	public function new() {
		document.addEventListener('DOMContentLoaded', (event) -> {
			if (DEBUG)
				console.info(App.callIn('MonkeeRoute'));
			init();
		});
	}

	function init() {
		// console.info('------------------ init');

		// get one time the defaultTitle and set the hash to zero
		if (defaultTitle == '') {
			defaultTitle = document.title;
			defaultUrl = window.location.href.split('#').join('');
			location.hash = '';
			map.set('', {
				link: null,
				url: defaultUrl,
				hash: '',
			});
		}
		title = defaultTitle;

		// trace(defaultUrl);
		// trace(map.get(''));

		//  search all element with tag <a monkee>
		var arr:Array<Element> = cast document.querySelectorAll('[monkee]');
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
			init();
		}, true);
		// Listen for the event from MonkeeLoad
		// window.addEventListener(App.ON_LOAD_READY, function(e) { console.warn(e);}, true);

		window.onhashchange = locationHashChanged;
	}

	function locationHashChanged() {
		// console.log("You're visiting : " + location.hash);
		var key = (location.hash).split('#').join('');
		// trace(key);
		if (map.exists(key)) {
			var navObj = map.get(key);
			// trace(navObj);
			if (navObj.url == defaultUrl) {
				location.reload();
			} else {
				window.fetch(navObj.url)
					.then(response -> response.text())
					.then(data -> replaceBody(navObj, data));
			}
		} else {
			console.info('unknown - ${defaultUrl}');
			// window.open('?', '_self');
			window.location.href = defaultUrl;
			location.reload();
		}
	}

	function replaceBody(navObj:NavObj, html:String) {
		document.title = title + ' : ' + navObj.hash;
		location.hash = navObj.hash;

		// // trace(html);
		// var state = {}; // {'page_id': 1, 'user_id': 5};
		// var title = '';
		// var url = ''; // 'hello-world.html';
		// window.history.pushState(state, title, url);

		// before deleting data from body, store it
		var all = untyped Array.prototype.slice.call(document.body.children);
		// trace(all);

		// parse elements
		// document.body.prepend(html);
		// [mck] replaces everything... not a good idea
		document.body.innerHTML = (html);

		for (i in 0...all.length) {
			var el:Element = cast all[i];
			// trace(el);
			// trace(el.localName);
			// for now, put scripts back
			if (el.localName == 'script') {
				document.body.appendChild(el);
			}
		}

		// make sure once the file is parsed, to check for new `<a monkee ` tags
		window.setTimeout(function() {
			init();
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
