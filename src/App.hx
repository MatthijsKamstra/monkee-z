import haxe.macro.Context;

class App {
	public static inline var URL:String = "https://";

	public static inline var NAME:String = "[Monkee-Z]";

	// events
	public static inline var ON_LOAD_READY:String = "onLoadReady";
	public static inline var ON_LOAD_UPDATE:String = "onLoadUpdate";

	/**
	 * @example
	 * 		console.log(App.callIn('MonkeeRoute'));
	 *
	 * @param str
	 */
	public static inline function callIn(str:String) {
		return '${NAME} - ${str} - build: ${App.getBuildDate()}';
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
