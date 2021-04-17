package;

import js.html.svg.Element;
import js.Browser.*;
import js.html.*;

class MonkeeRoute {
	var DEBUG = true;

	var all = [];

	public function new() {
		document.addEventListener('DOMContentLoaded', (event) -> {
			if (DEBUG)
				console.info(App.callIn('MonkeeRoute'));
			init();
		});
	}

	function init() {
		//  search all element with tag <a>
		var arr:Array<Element> = [];
		arr = cast document.getElementsByTagName('a');
		for (i in 0...arr.length) {
			var a:LinkElement = cast arr[i];
			// trace(a);
			a.onclick = function(e:Event) {
				e.preventDefault();
				window.fetch(a.href + '.html')
					.then(response -> response.text())
						// .then(data -> console.log(data))
					.then(data -> replaceBody(a, data));
			}
		}
	}

	function replaceBody(a:LinkElement, html:String) {
		// trace(html);
		var state = {}; // {'page_id': 1, 'user_id': 5};
		var title = '';
		var url = ''; // 'hello-world.html';
		window.history.pushState(state, title, url);

		// before deleting data from body, store it
		all = untyped Array.prototype.slice.call(document.body.children);
		// trace(all);

		// parse elements
		// document.body.prepend(html);
		// [mck] replaces everything... not a good idea
		document.body.innerHTML = (html);

		for (i in 0...all.length) {
			var el:Element = cast all[i];
			trace(el);
			trace(el.localName);
			// for now, put scripts back
			if (el.localName == 'script') {
				document.body.appendChild(el);
			}
		}
	}

	static public function main() {
		var app = new MonkeeRoute();
	}
}
