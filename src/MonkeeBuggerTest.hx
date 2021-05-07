package;

import js.Syntax;
import js.html.Element;
import haxe.Json;
import js.Browser.*;

using StringTools;
using Lambda;

class MonkeeBuggerTest {
	var isDebug = true;
	var DEBUG = true;

	public function new() {
		if (DEBUG)
			console.log('${App.NAME} - MonkeeBugger - ${App.getBuildDate()}');

		for (i in 0...10) {
			haxe.Timer.delay(() -> {
				console.log('test ${i} in ${i * 1000}ms');
			}, i * 1000);
		}

		console.log('log');
		console.warn('warn');
		console.error('error');
		console.info('info');

		console.log('deel 1/2', 'deel 2/2');
		console.log('part 1/3', 'part 2/3', 'part 3/3');

		var obj = {prop1: 'prop1Value', prop2: 'prop2Value', child: {childProp1: 'childProp1Value'}}
		console.log(obj);

		trace('trace');
	}

	static public function main() {
		document.addEventListener('DOMContentLoaded', (event) -> {
			var app = new MonkeeBuggerTest();
		});
	}
}
