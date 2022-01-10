package;

import haxe.macro.Context;

class App {
	public static inline var NAME:String = "[ING Art Management]";

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
