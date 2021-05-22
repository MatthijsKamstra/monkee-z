package;

import haxe.extern.Rest;
import js.Syntax;
import js.html.Element;
import haxe.Json;
import js.Browser.*;

using StringTools;
using Lambda;

class MonkeeBugger {
	/**
	 * 0.0.2	version and debug
	 * 0.0.1 	initial
	 */
	static inline var VERSION = '0.0.2';

	var DEBUG = #if debug true #else false #end;

	// var file = CompileTime.readFile("style.css");

	public function new() {
		document.addEventListener('DOMContentLoaded', (event) -> {
			console.info(App.callIn('MonkeeBugger', VERSION));
			init();
			highjack();
		});
	}

	function init():Element {
		var _id = "debugDiv";
		var div = document.getElementById(_id);
		if (document.getElementById(_id) == null) {
			div = document.createDivElement();
			div.id = _id;
			div.setAttribute('style',
				"@import url('https://fonts.googleapis.com/css2?family=Roboto+Mono&display=swap'); font-family: 'Roboto Mono','Courier New', Courier, monospace;padding: 10px; height: 200px; width: 100%; border: 1px solid #333; overflow:scroll;position: fixed;bottom: 0; color: white; background-color: rgba(0,0,0,0.5)");
			document.body.appendChild(div);
		}
		return div;
	}

	// https://stackoverflow.com/questions/16616722/sending-all-javascript-console-output-into-a-dom-element

	function highjack() {
		var _log = console.log;
		var _warn = console.warn;
		var _info = console.info;
		var _error = console.error;

		// console.log('1', '2');

		untyped console.log = function(msg:Dynamic, msg2:haxe.extern.Rest<Dynamic>) {
			if (msg2 == null) {
				_log(msg); // maintains existing logging via the console.
				output('${msg}');
			} else {
				_log(msg, msg2); // maintains existing logging via the console.
				output('${msg} ${msg2}');
			}

			// _log(__a); // maintains existing logging via the console.
			// output('${__a}');
		}
		untyped console.warn = function(msg:haxe.extern.Rest<Dynamic>) {
			_warn(msg); // maintains existing logging via the console.
			output('${msg}', 'warn');
		}
		untyped console.error = function(msg:haxe.extern.Rest<Dynamic>) {
			_error(msg); // maintains existing logging via the console.
			output('${msg}', 'error');
		}
		untyped console.info = function(msg:haxe.extern.Rest<Dynamic>) {
			_info(msg); // maintains existing logging via the console.
			output('${msg}', 'info');
		}

		window.onerror = function(message:haxe.extern.EitherType<js.html.Event, String>, url:String, linenumber:Int, i:Int, b:Int):Dynamic {
			console.log("JavaScript error: " + message + " on line " + linenumber + " for " + url);
			return {};
		}
	}

	/**
	 * in-page debug screen usefull for mobile debuggin /
	 *
	 * @param {string} message
	 */
	function output(message:String, type:String = 'log') {
		var style = 'color:gray';

		switch (type) {
			case 'log':
				style = 'color:white';
			case 'info':
				style = 'color:black';
			case 'error':
				style = 'background-color:#FF3769; color:white;';
			case 'warn':
				style = 'background-color:#D8B700; color:white;';
			default:
				style = 'color:black';
				// trace("case '" + type + "': trace ('" + type + "');");
		}
		var div = init();

		var d = Date.now();
		var time = '${d.getHours()}'.lpad('0', 2) + ":" + '${d.getMinutes()}'.lpad('0', 2) + ":" + '${d.getSeconds()}'.lpad('0', 2) + " - ";

		var txt = div.innerHTML;
		div.innerHTML = '<div style="border-top:1px solid RGBA(0,0,0,0.3);${style}"><span>${time} ${message}</span></div>${txt}';
	}

	static public function main() {
		var app = new MonkeeBugger();
	}
}
