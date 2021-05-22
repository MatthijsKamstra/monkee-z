import haxe.macro.Context;

class App {
	public static inline var URL:String = "https://matthijskamstra.github.io/monkee-z/";

	public static inline var NAME:String = "[Monkee-Z]";

	// events
	public static inline var ON_LOAD_READY:String = "onLoadReady";
	public static inline var ON_LOAD_UPDATE:String = "onLoadUpdate";

	/**
	 * @example
	 * 		console.log(App.callIn('MonkeeRoute'));
	 *
	 * @param str		name for call out
	 * @param version	current version for that class (use for release, debug gets current date)
	 */
	public static inline function callIn(str:String, version:String) {
		var _version = version;
		#if debug
		_version = App.getBuildDate();
		#end
		return '${NAME} ${str} - version: ${_version}';
	}

	public static inline macro function getBuildDate() {
		#if !display
		var date = Date.now().toString();
		return macro $v{date};
		#else
		var date = Date.now().toString();
		return macro $v{date};
		#end
	}
}
