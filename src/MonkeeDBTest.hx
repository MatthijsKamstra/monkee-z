package;

import haxe.Constraints.Function;
import gui.*;
import js.Browser.*;
import js.html.*;

@:expose
class MonkeeDBTest {
	var isDebug = true;
	var DEBUG = true;

	public function new() {
		if (DEBUG)
			console.log('${App.NAME} - MonkeeDBTest - ${App.getBuildDate()}');

		init0();
	}

	function init0() {
		var dbName = 'test1';
		MonkeeDB.create(dbName);
		console.log(MonkeeDB.read(dbName));
	}

	static public function main() {
		document.addEventListener('DOMContentLoaded', (event) -> {
			var app = new MonkeeDBTest();
		});
	}
}
