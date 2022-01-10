package util;

import js.Browser.window;
import js.Browser.console;

class WindowWidth {
	public function new() {
		// your code
	}

	/**
	 * @example
	 * 			if(WindowWidth.isMobile()){
	 * 				trace('mobile');
	 * 			};
	 */
	public static function isMobile() {
		var isMobile = window.matchMedia("only screen and (max-width: 760px)").matches;

		console.log(window.matchMedia("only screen and (max-width: 760px)").matches);
		console.log(isMobile);

		return isMobile;
	}

	// public static function
}
