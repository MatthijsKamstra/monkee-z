// Generated by Haxe 4.1.5
(function ($global) { "use strict";
class MonkeeRoute {
	constructor() {
		console.log("src/MonkeeRoute.hx:5:","MonkeeRoute");
	}
	static main() {
		let app = new MonkeeRoute();
	}
}
class haxe_iterators_ArrayIterator {
	constructor(array) {
		this.current = 0;
		this.array = array;
	}
	hasNext() {
		return this.current < this.array.length;
	}
	next() {
		return this.array[this.current++];
	}
}
MonkeeRoute.main();
})({});
