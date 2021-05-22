package;

import js.Browser.*;

using StringTools;

// import externs.MonkeeChain;
@:expose
@:keep
class MonkeeZ {
	public static var load:MonkeeLoad = new MonkeeLoad();

	// public static var chain:MonkeeChain = new MonkeeChain();
	public static var route:MonkeeRoute = new MonkeeRoute();
	public static var bugger:MonkeeBugger = new MonkeeBugger();
	public static var util:MonkeeUtil = new MonkeeUtil();

	public function new() {
		console.info(App.callIn('MonkeeZ'));
	}

	static public function main() {
		var app = new MonkeeZ();
	}
}
