package utils;

import haxe.Json;
import js.html.Element;
import js.Browser.*;
import js.html.XMLHttpRequest;

using StringTools;

class Html {
	public function new() {
		// your code
	}

	/**
	 * extract the body (from documents that have a body)
	 *
	 * @param html
	 */
	public static function getBody(html) {
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

	/**
	 * [Description]
	 * @param html
	 */
	public static function getScript(html) {
		var htmlLowerCase:String = html.toLowerCase(); // to eliminate case sensitivity
		var x:Int = htmlLowerCase.indexOf("<script");
		if (x == -1)
			return "";

		x = htmlLowerCase.indexOf(">", x);
		if (x == -1)
			return "";
		var y = htmlLowerCase.lastIndexOf("</script>");

		// trace(x, y, html.slice(x + 1, y));

		return html.slice(x + 1, y);
	}

	/**
	 * [Description]
	 * @param target
	 * @param html
	 * @param isInner
	 */
	public static function processHTML(target:js.html.Element, html:String, isInner:Bool) {
		if (isInner) {
			target.innerHTML = html;
		} else {
			target.outerHTML = html;
		}
	}

	/**
	 * sanitize string to prefend XSS attack
	 *
	 * @example
	 * 		sanitizeHTML('<img src="x" onerror="alert(1)">');
	 *
	 * @param unsafe_str
	 * @return String
	 */
	public static function sanitizeHTML(unsafe_str:String):String {
		return unsafe_str
			.replace('&', '&amp;')
			.replace('<', '&lt;')
			.replace('>', '&gt;')
			.replace('"', '&quot;')
			.replace("'", '&#39;'); // '&apos;' is not valid HTML 4
	}

	public static function escapeHTML(unsafe_str:String):String {
		return sanitizeHTML(unsafe_str);
	}

	/**
	 * [Description]
	 * @param html
	 * @param isInner = true
	 */
	public static function htmlToElement(html:String, isInner = true) {
		var template = document.createDivElement();
		html = untyped html.trim(); // Never return a text node of whitespace as the result
		Html.processHTML(template, html, isInner);
		// template.innerHTML = html;
		return template.firstChild;
	}
}
