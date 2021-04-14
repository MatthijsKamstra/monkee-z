package;

import haxe.Json;

using StringTools;
using Lambda;

class Research {
	public function new() {
		trace('Research');
		var json = {
			"i": {
				"want": {
					"it": "Oh I know you do..."
				}
			}
		}
		// var result = JSON.parse(JSON.stringify(json)); //cloning the existing json
		var result = json; // cloning the existing obj
		var give = 'i.want.it';

		// now split the give and iterate through keys
		give.split(".").foreach(function(key) {
			// result = untyped result[key];
			trace(key);
			return true;
		});
		trace(result);
	}

	static public function main() {
		var app = new Research();
	}
}
