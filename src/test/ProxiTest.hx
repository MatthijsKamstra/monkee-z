package test;

import utils.Proxi;

using buddy.Should;

class ProxiTest extends buddy.BuddySuite {
	public function new() {
		// A test suite:
		describe("Using Proxi", {
			var target = {
				stringVal: "hello",
				boolVal: true,
				objVal: {},
				arrayVal: ['one']
			};

			var proxi = Proxi.create(target);

			it("should be a great testing experience", {});

			it("should make the tester really happy", {
				// mood.should.be("happy");
			});
		});
	}
}
