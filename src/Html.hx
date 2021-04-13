package;

import js.html.Element;
import js.Browser.*;
import js.html.XMLHttpRequest;

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
	 * @param target
	 * @param isInner = true
	 */
	public static function processHTML(html:String, target:js.html.Element, isInner = true) {
		if (isInner) {
			target.innerHTML = html;
		} else {
			target.outerHTML = html;
		}
	}

	/**
	 * [Description]
	 * @param html
	 * @param isInner = true
	 */
	public static function htmlToElement(html:String, isInner = true) {
		var template = document.createDivElement();
		html = untyped html.trim(); // Never return a text node of whitespace as the result
		Html.processHTML(html, template, isInner);
		// template.innerHTML = html;
		return template.firstChild;
	}
}
