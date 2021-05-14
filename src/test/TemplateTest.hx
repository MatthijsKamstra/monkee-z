package test;

import haxe.Json;
import utils.Query;
import utils.Template;

using buddy.Should;

class TemplateTest extends buddy.BuddySuite {
	public function new() {
		// A test suite:
		describe("Using Template.convert", {
			var obj1:Dynamic = {"name": "Matthijs"};
			var obj2:Dynamic = {"name": "Matthijs", "last": "Kamstra"};
			var obj3:Dynamic = {"name": "Matthijs", "last": "Kamstra", "foo": "bar"};

			var template = "Monkee-Z {name} {last}";
			it('"${template}" should return "Monkee-Z Matthijs {last}"', {
				(Template.convert(obj1, template)).should.be('Monkee-Z Matthijs {last}');
			});
			it('"${template}" should return "Monkee-Z Matthijs Kamstra"', {
				(Template.convert(obj2, template)).should.be('Monkee-Z Matthijs Kamstra');
			});
			it('"${template}" should return "Monkee-Z Matthijs Kamstra"', {
				(Template.convert(obj3, template)).should.be('Monkee-Z Matthijs Kamstra');
			});

			var template = "Monkee-Z { name } { last }";
			it('"${template}" should return "Monkee-Z Matthijs Kamstra"', {
				(Template.convert(obj1, template)).should.be('Monkee-Z Matthijs { last }');
			});
			it('"${template}" should return "Monkee-Z Matthijs Kamstra"', {
				(Template.convert(obj2, template)).should.be('Monkee-Z Matthijs Kamstra');
			});
			it('"${template}" should return "Monkee-Z Matthijs Kamstra"', {
				(Template.convert(obj3, template)).should.be('Monkee-Z Matthijs Kamstra');
			});

			var template = "Monkee-Z {  name  } {  last  }";
			it('"${template}" should return "Monkee-Z Matthijs {  last  }"', {
				(Template.convert(obj1, template)).should.be('Monkee-Z Matthijs {  last  }');
			});
			it('"${template}" should return "Monkee-Z Matthijs Kamstra"', {
				(Template.convert(obj2, template)).should.be('Monkee-Z Matthijs Kamstra');
			});
			it('"${template}" should return "Monkee-Z Matthijs Kamstra"', {
				(Template.convert(obj3, template)).should.be('Monkee-Z Matthijs Kamstra');
			});

			var template = "Monkee-Z {name } {last }";
			it('"${template}" should return "Monkee-Z Matthijs {last }"', {
				(Template.convert(obj1, template)).should.be('Monkee-Z Matthijs {last }');
			});
			it('"${template}" should return "Monkee-Z Matthijs Kamstra"', {
				(Template.convert(obj2, template)).should.be('Monkee-Z Matthijs Kamstra');
			});
			it('"${template}" should return "Monkee-Z Matthijs Kamstra"', {
				(Template.convert(obj3, template)).should.be('Monkee-Z Matthijs Kamstra');
			});

			var template = "Monkee-Z { name} { last}";
			it('"${template}" should return "Monkee-Z Matthijs { last}"', {
				(Template.convert(obj1, template)).should.be('Monkee-Z Matthijs { last}');
			});
			it('"${template}" should return "Monkee-Z Matthijs Kamstra"', {
				(Template.convert(obj2, template)).should.be('Monkee-Z Matthijs Kamstra');
			});
			it('"${template}" should return "Monkee-Z Matthijs Kamstra"', {
				(Template.convert(obj3, template)).should.be('Monkee-Z Matthijs Kamstra');
			});
		});
	}
}
