package;

import utils.Emoji;
import js.html.svg.Element;
import js.Browser.*;
import js.html.*;

class MonkeeFullpage {
	/**
	 * 0.0.1 	initial (wip)
	 */
	static inline var VERSION = '0.0.1';

	var DEBUG = #if debug true #else false #end;

	public function new() {
		document.addEventListener('DOMContentLoaded', (event) -> {
			console.info(App.callIn('Fullpage', VERSION));
			setupRoute();
		});
	}

	static public function main() {
		var app = new MonkeeFullpage();
	}
}
