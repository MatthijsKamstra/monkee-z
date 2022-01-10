package;

import js.html.HTMLCollection;
import js.Syntax;
import js.html.Element;
import js.Browser.*;

using StringTools;

/**
 * trying to create a js only class that will make jquery calls, pure js
 *
 * http://youmightnotneedjquery.com/
 */
class JQ {
	/**
	 * offset
	 * @example `$(el).offset();`
	 *
	 * @param el	element
	 */
	static public function offset(el:Element):Dynamic {
		var rect = el.getBoundingClientRect();
		return {
			top: rect.top + document.documentElement.scrollTop,
			left: rect.left + document.documentElement.scrollLeft
		}
	}

	/**
	 * height
	 * @example `$(el).height();`
	 *
	 * @param el	element
	 */
	static public function height(el:Element) {
		var style = window.getComputedStyle(el);
		var h = style.height.replace('px', '');
		return Std.parseFloat(h);
	}

	/**
	 * width
	 * @example `$(el).width();`
	 *
	 * @param el	element
	 */
	static public function width(el:Element) {
		var style = window.getComputedStyle(el);
		var w = style.width.replace('px', '');
		return Std.parseFloat(w);
	}

	/**
	 * outerHeight
	 * @example `$(el).outerHeight();`
	 *
	 * @param el	element
	 */
	inline static public function outerHeight(el:Element) {
		return el.offsetHeight;
	}

	/**
	 * innerHeight
	 * Returns a `Number` representing the inner height of the element.
	 *
	 * @example `$(el).innerHeight();`
	 *
	 * @param el	element
	 */
	inline static public function innerHeight(el:Element) {
		return el.clientHeight;
	}

	/**
	 * get the first element in the htmlcollection
	 * @param arr
	 */
	inline static public function first(arr:HTMLCollection) {
		return arr[0];
	}

	/**
	 * get the last element in the htmlcollection
	 * @param arr
	 */
	inline static public function last(arr:HTMLCollection) {
		return arr[arr.length - 1];
	}

	/**
	 * [Description]
	 * @param el
	 * @param style
	 * @param value
	 */
	// static public function css(el:Element, css:String, value:String) {
	// 	var temp = css.replace("_", "");
	// 	return el.style[temp];
	// }
}
