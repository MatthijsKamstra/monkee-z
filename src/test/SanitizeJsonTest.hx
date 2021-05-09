package test;

import utils.Sanitize;
import haxe.Json;

using buddy.Should;

class SanitizeJsonTest extends buddy.BuddySuite {
	public function new() {
		var json = {
			numberVal: 100,
			intVal: 3,
			floatVal: 4.4,
			stringVal: "hello",
			boolVal: true,
			objVal: {},
			arrayVal: ['one', 'two']
		}
		var content = Json.stringify(json);
		// var sanitized = Sanitize.sanitizeJson(json);

		// A test suite:
		describe("Test sanitizing dynamic json", {
			//     data: {
			//         title: "First title"
			//     },
			//     template: function (props) {
			//         return `title: ${props.title}`;
			//     }
			// });
			// app3.data.title = "<image src=x onerror=alert('XSS_image')>";

			it("should be a great testing experience", {
				json.stringVal.should.be("hello");
				json.stringVal = "<image src=x onerror=alert('XSS_image')>";
				json.stringVal.should.be("<image src=x onerror=alert('XSS_image')>");
				trace(json.stringVal);
				Sanitize.sanitizeJson(json);
				trace(json.stringVal);
				// trace(sanitized.stringVal);
				// sanitized.stringVal.should().be('x');
			});

			// it("should make the tester really happy", {
			// 	mood.should.be("happy");
			// });
		});
	}
}
