package;

import js.Browser.*;

using StringTools;

// import externs.MonkeeChain;
@:expose
@:keep
class MonkeeZ {
	/**
	 * 0.0.2 	added more to the collection
	 * 0.0.1 	initial
	 */
	static inline var VERSION = '0.0.2';

	public static var bugger:MonkeeBugger = new MonkeeBugger();
	// public static var chain:MonkeeChain = new MonkeeChain();
	public static var db:MonkeeDB = new MonkeeDB();
	public static var fullpage:MonkeeFullpage = new MonkeeFullpage();
	public static var route:MonkeeRoute = new MonkeeRoute();
	// public static var gui:MonkeeGui = new MonkeeGui();
	public static var load:MonkeeLoad = new MonkeeLoad();
	public static var util:MonkeeUtil = new MonkeeUtil();
	public static var wrench:MonkeeWrench = new MonkeeWrench();

	public function new() {
		console.info(App.callIn('MonkeeZ ${utils.Emoji.monkee}', VERSION));
	}

	static public function main() {
		var app = new MonkeeZ();
	}
}
