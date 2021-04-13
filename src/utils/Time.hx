package utils;

class Time {
	var starttime = .0;
	var endtime = .0;

	public function new() {
		starttime = Time.get();
	}

	public function start() {
		starttime = Time.get();
	}

	public function end() {
		endtime = Time.get();
	}

	/**
	 * total time in ms
	 */
	public function total() {
		endtime = Time.get();
		return ((endtime - starttime) + 'ms');
	}

	/**
	 * var starttime = Time.get();
	 */
	public static function get() {
		return Date.now().getTime();
	}
}
