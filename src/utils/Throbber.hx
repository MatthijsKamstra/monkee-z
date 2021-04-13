package utils;

import js.html.Element;
import js.Browser.*;

class Throbber {
	public static function set(el:Element):Element {
		var _div = document.createDivElement();
		_div.className = 'loader';
		el.appendChild(_div);
		return _div;
	}
}
