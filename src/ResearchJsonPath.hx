package;

import utils.JsonPath;
import haxe.Json;

using StringTools;
using Lambda;

class ResearchJsonPath {
	public function new() {
		var content:String = sys.io.File.getContent('docs/data/i.want.it.json');

		trace(JsonPath.search(content, 'i.want.it')); // Oh I know you do...
		trace(JsonPath.search(content, 'i.want.to.believe')); // You should watch X-files
		trace(JsonPath.search(content, 'i.want.to.fail')); // null
		trace(JsonPath.search(content, 'i.watch.films')); // [{year: 2001, title: foo}, {year: 2002, title: bar}, {year: 2003, title: yoo}]));
		trace(JsonPath.search(content, 'i.watch.films[1]')); // {year: 2002, title: bar}
		trace(JsonPath.search(content, 'i.watch.films[1].year')); // 2002
		trace(JsonPath.search(content, 'i.watch.films[1000].year')); // null

		var arr:Array<Dynamic> = cast JsonPath.search(content, 'i.watch.films');
		trace(arr[2].title); // yoo
	}

	static public function main() {
		var app = new ResearchJsonPath();
	}
}
