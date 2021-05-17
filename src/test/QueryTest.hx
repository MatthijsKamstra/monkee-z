package test;

import haxe.Json;
import utils.Query;

using buddy.Should;

class QueryTest extends buddy.BuddySuite {
	public function new() {
		// A test suite:
		describe("Using Query.convert", {
			var obj:Dynamic = {};

			var template = "<p>Monkee-Z {name} {last}</p>";

			var queryString = "../../components/hero2-lite.html";
			it('"${queryString}" should return {}', {
				Query.convert(queryString).should.beType(Dynamic);
				obj = Query.convert(queryString);
				Json.stringify(Query.convert(queryString)).should.be('{}');
			});

			var queryString = "../../components/hero2-lite.html?";
			it('"${queryString}" should return {}', {
				Query.convert(queryString).should.beType(Dynamic);
				obj = Query.convert(queryString);
				Json.stringify(Query.convert(queryString)).should.be('{}');
			});

			var queryString = "../../components/hero2-lite.html?name=Matthijs";
			it('"${queryString}" should return {"name":"Matthijs"}', {
				Query.convert(queryString).should.beType(Dynamic);
				obj = Query.convert(queryString);
				Json.stringify(Query.convert(queryString)).should.be('{"name":"Matthijs"}');
				Json.stringify(Query.convert(queryString)).should.be(Json.stringify({"name": "Matthijs"}));
				(obj.name).should.be('Matthijs');
			});

			var queryString = "../../components/hero2-lite.html?name=Matthijs&last=Kamstra";
			it('"${queryString}" should return {"name":"Matthijs","last":"Kamstra"}', {
				Query.convert(queryString).should.beType(Dynamic);
				obj = Query.convert(queryString);
				Json.stringify(Query.convert(queryString)).should.be('{"name":"Matthijs","last":"Kamstra"}');
				Json.stringify(Query.convert(queryString)).should.be(Json.stringify({"name": "Matthijs", "last": "Kamstra"}));
				(obj.name).should.be('Matthijs');
				(obj.last).should.be('Kamstra');
			});

			var queryString = "../../components/hero2-lite.html?name=Matthijs&last=Kamstra&foo=bar";
			it('"${queryString}" should return {"name":"Matthijs","last":"Kamstra","foo":"bar"}', {
				Query.convert(queryString).should.beType(Dynamic);
				obj = Query.convert(queryString);
				Json.stringify(Query.convert(queryString)).should.be('{"name":"Matthijs","last":"Kamstra","foo":"bar"}');
				Json.stringify(Query.convert(queryString)).should.be(Json.stringify({"name": "Matthijs", "last": "Kamstra", "foo": "bar"}));
				(obj.name).should.be('Matthijs');
				(obj.last).should.be('Kamstra');
				(obj.foo).should.be('bar');
			});
		});
	}
}
