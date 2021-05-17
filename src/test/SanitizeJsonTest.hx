package test;

import utils.Sanitize;
import haxe.Json;

using buddy.Should;

class SanitizeJsonTest extends buddy.BuddySuite {
	public function new() {
		var original = {
			numberVal: 100,
			intVal: 3,
			floatVal: 4.4,
			stringVal: "hello",
			boolVal: true,
			arrayVal: ['one', 'two'],
			arrayObjVal: [{description: 'one'}, {description: 'two'}],
			objVal: {},
		}
		// var json = Json.parse(Json.stringify(original));
		var json = original;
		var content = Json.stringify(json);
		// var sanitized = Sanitize.sanitizeJson(json);

		var xss = "<image src=x onerror=alert('XSS_image')>";
		var escapeXss = Sanitize.escapeHTML(xss);
		// var escapeXss = '&lt;image src=x onerror=alert(&#39;XSS_image&#39;)&gt;';

		// A test suite:
		describe("Test sanitizing dynamic json", {
			it("String sanitize json", {
				json.stringVal.should.be("hello");
				json.stringVal = xss;
				json.stringVal.should.be(xss);
				// trace(json.stringVal);
				json = Sanitize.sanitizeJson(json);
				// trace(json.stringVal);
				json.stringVal.should.not.be(xss);
				json.stringVal.should.be(escapeXss);
				json.stringVal.should.beType(String);
			});

			it("Bool 2 String sanitize json", {
				json.boolVal.should.be(true);
				json.boolVal.should.beType(Bool);
				untyped json.boolVal = xss;
				json.boolVal.should.be(xss);
				// trace(json.boolVal);
				json = Sanitize.sanitizeJson(json);
				// trace(json.boolVal);
				json.boolVal.should.not.be(xss);
				json.boolVal.should.be(escapeXss);
				json.boolVal.should.beType(String);
			});

			it("Array 2 String sanitize json", {
				json.arrayVal.should.not.be([]);
				json.arrayVal.should.beType(Array);
				untyped json.arrayVal.push(xss);
				json.arrayVal[2].should.be(xss);
				// trace(json.arrayVal);
				json = Sanitize.sanitizeJson(json);
				// trace(json.arrayVal);
				json.arrayVal[2].should.not.be(xss);
				json.arrayVal[2].should.be(escapeXss);
				// json.arrayVal.should.not.be(xss);
				// json.arrayVal.should.beType(String);
			});

			it("Object 2 String sanitize json", {
				// json.objVal.should.be({}); // weird..
				// trace(json.objVal);
				Reflect.setField(json.objVal, 'title', (xss));
				// trace(json.objVal);
				// trace(untyped json.objVal.title);
				Reflect.getProperty(json.objVal, "title").should.be(xss);
				json = Sanitize.sanitizeJson(json);
				// trace(untyped json.objVal.title);
				Reflect.getProperty(json.objVal, "title").should.not.be(xss);
				Reflect.getProperty(json.objVal, "title").should.be(escapeXss);
			});

			it("multiple times sanitize json", {
				// json.objVal.should.be({}); // weird..
				json = Sanitize.sanitizeJson(json);
				json = Sanitize.sanitizeJson(json);
				json = Sanitize.sanitizeJson(json);
				json.stringVal.should.not.be(xss);
				json.stringVal.should.be(escapeXss);
			});

			var inject = '';

			it("New Array 2 Object 2 String sanitize json", {
				Reflect.getProperty(json, 'newArrayVal').should.not.be([]);
				Reflect.setField(json, 'newArrayVal', []);
				Reflect.getProperty(json, 'newArrayVal').should.beType(Array);
				Reflect.setProperty(json, 'newArrayVal', [{inject: xss}]);
				// trace(Reflect.getProperty(json, 'newArrayVal')[0].inject);
				inject = (Reflect.getProperty(json, 'newArrayVal')[0].inject);
				(inject).should().be(xss);
				json = Sanitize.sanitizeJson(json);
				inject = (Reflect.getProperty(json, 'newArrayVal')[0].inject);
				// trace(inject);
				(inject).should().be(escapeXss);
				// trace('newArrayVal push inject: ' + json);
				untyped json.newArrayVal.push({inject: xss});
				// trace(Reflect.getProperty(json, 'newArrayVal')[1].inject);
				inject = (Reflect.getProperty(json, 'newArrayVal')[1].inject);
				(inject).should().be(xss);
				json = Sanitize.sanitizeJson(json);
				inject = (Reflect.getProperty(json, 'newArrayVal')[1].inject);
				(inject).should().be(escapeXss);
			});
		});
	}
}
