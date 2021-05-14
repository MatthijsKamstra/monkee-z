package;

import utils.Html;
import utils.JsonPath;
import haxe.Json;
import js.html.InputElement;
import utils.Time;
import utils.Throbber;
import js.html.Element;
import js.Browser.*;
import js.html.XMLHttpRequest;
import AST.LoadObj;

using StringTools;
using Lambda;

class MonkeeLoadTest {
	var DEBUG = true;

	public function new() {
		trace("DEBUG: " + DEBUG);
	}

	static public function main() {
		var app = new MonkeeLoadTest();
	}
}
