package;

import haxe.Json;

using StringTools;
using Lambda;

class Research {
	public function new() {
		var content:String = sys.io.File.getContent('docs/data/i.want.it.json');

		search(content, 'i.want.it'); // Oh I know you do...
		search(content, 'i.want.to.believe'); // You should watch X-files
		search(content, 'i.want.to.fail'); // null
		search(content, 'i.watch.films'); // [{year: 2001, title: foo}, {year: 2002, title: bar}, {year: 2003, title: yoo}]
		search(content, 'i.watch.films[1]'); // {year: 2002, title: bar}
		search(content, 'i.watch.films[1].year'); // 2002
		search(content, 'i.watch.films[1000].year'); // null

		var arr = search(content, 'i.watch.films');
		trace(arr[2].title); // yoo
	}

	/**
	 * search in json for the correct value, return null if not
	 *
	 * @param jsonStr
	 * @param path
	 */
	function search(jsonStr:String, path:String) {
		var result = Json.parse(jsonStr); // cloning the existing json
		// var result = json; // cloning the existing obj

		// now split the path and iterate through keys
		path.split(".").foreach(function(key) {
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
