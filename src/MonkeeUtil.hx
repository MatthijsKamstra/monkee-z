package;

import haxe.Json;
import js.lib.Function;
import js.html.SupportedType;
import js.html.DOMParser;
import js.lib.Error;
import js.html.Element;
import haxe.extern.EitherType;
import js.Browser.*;

using StringTools;

@:expose
class MonkeeUtil {
	public function new() {
		// if (DEBUG)
		console.info(App.callIn('MonkeeUtil'));
		init();
	}

	function init() {
		var all = document.querySelectorAll('[data-escape]');

		for (i in 0...all.length) {
			var el:Element = cast all[i];
			var html = el.getAttribute('data-escape');
			// el.innerHTML = (html);
			// el.innerText = MonkeeUtil.escapeHTML(html);
			el.innerHTML = MonkeeUtil.escapeHTML(html);
		}
	}

	public static function escapeHTML(html:String) {
		// trace(html);
		return html
			.replace('&', '&amp;')
			.replace('"', '&quot;')
			.replace('<', '&lt;')
			.replace('>', '&gt;');
	}

	static public function main() {
		document.addEventListener('DOMContentLoaded', (event) -> {
			var app = new MonkeeUtil();
		});
	}
}
