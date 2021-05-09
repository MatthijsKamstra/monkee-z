package test;

import buddy.*;

using buddy.Should;

// Implement "Buddy" and define an array of classes within the brackets:
class BuddyMain implements Buddy<[
	//
	BuddyTest,
	ResearchTest,
	SanitizeJsonTest
]> {}
// // All test classes should now extend BuddySuite (not SingleSuite)
// class Tests extends BuddySuite {
// 	public function new() {
// 		// describe("Using Buddy", {
// 		// 	it("should be a great testing experience");
// 		// 	it("should really make the tester happy");
// 		// });
// 	}
// }
