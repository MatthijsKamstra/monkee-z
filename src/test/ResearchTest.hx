package test;

import utils.JsonPath;

using buddy.Should;

class ResearchTest extends buddy.SingleSuite {
	public function new() {
		var content:String = sys.io.File.getContent('docs/data/i.want.it.json');
		var json = haxe.Json.parse(content);

		json = {
			"i": {
				"want": {
					"it": "Oh I know you do...",
					"to": {
						"believe": "You should watch X-files"
					}
				},
				"watch": {
					"films": [
						{"title": "foo", "year": "2001"},
						{"title": "bar", "year": "2002"},
						{"title": "yoo", "year": "2003"}
					]
				}
			}
		};
		// trace(json);

		// A test suite:
		describe("Check paths in json", {
			it('Search json with path: "i.want.it"', {
				var data:String = JsonPath.search(content, 'i.want.it');
				// trace(data);
				data.should.be("Oh I know you do...");
				data.should.contain('Oh');
			});

			it('Search json with path: "i.want.to.believe"', {
				var data:String = JsonPath.search(content, 'i.want.to.believe');
				// trace(data);
				data.should.be("You should watch X-files");
				data.should.contain('X-files');
			});

			it('Search json with path: "i.want.to.fail"', {
				var data:String = JsonPath.search(content, 'i.want.to.fail');
				data.should.be(null);
			});

			it('Search json with path: "i.watch.films"', {
				var data:Array<Dynamic> = cast JsonPath.search(content, 'i.watch.films');
				// trace(data);
				// trace(data.length);
				data.length.should.be(3);
				// data.should.contain('Oh');
			});

			it('Search json with path: "i.watch.films[1]"', {
				var data = JsonPath.search(content, 'i.watch.films[1]'); // {year: 2002, title: bar}
				// trace(data);
				var str = haxe.Json.stringify(json.i.watch.films[1]);
				haxe.Json.stringify(data).should.be(str);
			});

			it('Search json with path: "i.watch.films[1].year"', {
				var data:String = JsonPath.search(content, 'i.watch.films[1].year');
				// trace(data);
				data.should.be("2002");
			});

			it('Search json with path: "i.watch.films[1000].year"', {
				var data:String = JsonPath.search(content, 'i.watch.films[1000].year');
				// trace(data);
				data.should.be(null);
			});

			it('Search json with path: "i.watch.films" and use array', {
				var arr:Array<Dynamic> = cast JsonPath.search(content, 'i.watch.films');
				var data:String = (arr[2].title);
				// trace(data);
				data.length.should.be(3);
				data.should.be("yoo");
			});

			it('Search json with path: "i.want.watch.films[2].year"', {
				var data:String = JsonPath.search(content, 'i.want.watch.films[2].year');
				// trace(data);
				data.should.be(null);
			});
		});
	}
}
