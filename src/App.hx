import haxe.macro.Context;

class App {
	public static inline var URL:String = "https://";

	public static inline var NAME:String = "[monkee]";

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
