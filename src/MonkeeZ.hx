class MonkeeZ {
	public function new() {
		trace('MonkeeZ');
		console.info(App.callIn('MonkeeZ'));
	}

	static public function main() {
		var app = new MonkeeZ();
	}
}
