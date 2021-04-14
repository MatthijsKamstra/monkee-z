package;

import haxe.Json;

using StringTools;
using Lambda;

class Research {
	// json
	var json = {
		"i": {
			"want": {
				"it": "Oh I know you do...",
				"to": {
					"believe": "You should watch X-files"
				},
			},
			"watch": {
				"films": [
					{"title": "foo", "year": "2001"},
					{"title": "bar", "year": "2002"},
					{"title": "yoo", "year": "2003"},
				]
			}
		}
	};

	public function new() {
		search('i.want.it'); // Oh I know you do...
		search('i.want.to.believe'); // You should watch X-files
		search('i.want.to.fail'); // null
		search('i.watch.films'); // [{year: 2001, title: foo}, {year: 2002, title: bar}, {year: 2003, title: yoo}]
		search('i.watch.films[1]'); // {year: 2002, title: bar}
		search('i.watch.films[1].year'); // 2002
	}

	/**
	 * search in json for the correct value, return null if not
	 *
	 * @param search
	 */
	function search(search:String) {
		// var result = JSON.parse(JSON.stringify(json)); //cloning the existing json
		var result = json; // cloning the existing obj

		// now split the searchString and iterate through keys
		search.split(".").foreach(function(key) {
			// check for array, if not use the normal way
			if (key.indexOf('[') != -1) {
				// get the number in the string `films[1]`
				var index = Std.parseInt(key.split('[')[1].replace(']', ''));
				// get the array name `films`
				key = key.split('[')[0];
				// get the array
				var arr = Reflect.field(result, key);
				// get the index array based on index
				result = arr[index];
			} else {
				result = Reflect.field(result, key);
			}
			return true;
		});
		trace(result);
		return result;
	}

	static public function main() {
		var app = new Research();
	}
}
