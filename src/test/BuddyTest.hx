package test;

using buddy.Should;

class BuddyTest extends buddy.BuddySuite {
	public function new() {
		// A test suite:
		describe("Using Buddy", {
			var experience = "?";
			var mood = "?";

			beforeEach({
				experience = "great";
			});

			it("should be a great testing experience", {
				experience.should.be("great");
			});

			it("should make the tester really happy", {
				mood.should.be("happy");
			});

			afterEach({
				mood = "happy";
			});
		});
	}
}
