package util;

import js.html.LinkElement;
import js.html.ScriptElement;
import js.html.HTMLCollection;
import js.html.Element;
import js.Browser.*;
import js.Browser.window;

class Debug {
	public function new() {
		// your code
	}

	/**
	 * indentify external scripts and links
	 */
	public static function checkExternals() {
		// check external scripts
		var scripts:HTMLCollection = document.getElementsByTagName("script");
		for (i in 0...scripts.length) {
			var _scripts:ScriptElement = cast scripts[i];
			var src = _scripts.getAttribute("src");
			if (src == null) {
				// console.log('empty script (like script in page)');
				// console.log(_scripts);
			} else {
				if (src.indexOf('http') != -1) {
					console.error(_scripts);
					// console.log(_scripts.src); // outputs the absolute link: `https://`
					// console.log(_scripts.getAttribute("src"));// outputs the relative link: `/assets/x`
				}
			}
		}
		// check external links
		var links:HTMLCollection = document.getElementsByTagName("link");
		for (i in 0...links.length) {
			var _links:LinkElement = cast links[i];
			var href = _links.getAttribute("href");
			if (href.indexOf('http') != -1) {
				console.log(_links);
				// console.log(_links.href); // outputs the absolute link: `https://`
				console.log(_links.getAttribute("href")); // outputs the relative link: `/assets/x`
			}
		}
	}

	// ____________________________________ utils ____________________________________

	/**
	 * [mck] use when the page has a horizontal scrollbar
	 * check for elements that "push" the elements out.
	 * @example Debug.checkElementsWidth();
	 */
	public static function checkElementsWidth() {
		var docWidth = document.documentElement.offsetWidth;
		console.error('[mck] Check the width of the elements vs intended width (create a horizontal scrollbar)');
		console.group('Elements that are to big! (documentWidth: ${docWidth}px)');
		var arr = document.querySelectorAll('*');
		for (i in 0...arr.length) {
			var el:Element = cast arr[i];
			if (el.offsetWidth > docWidth) {
				console.log(el);
			}
		}
		console.groupEnd();
	}

	public static function tempRemoveCapta() {
		console.error('[mck] this should not be in the code, I needed to fix other issues');
		window.setTimeout(function() {
			console.log('3000ms');
			var div = document.getElementsByClassName('grecaptcha-badge')[0];
			div.style.left = '0px';
			div.style.right = 'unset';
		}, 3000);
	}
}
