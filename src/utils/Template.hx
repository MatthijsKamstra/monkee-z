package utils;

using StringTools;

class Template {
	public function new() {
		// your code
	}

	/**
	 * [Description]
	 * @param url
	 * @param template
	 */
	public static function convert(obj:Dynamic, template:String) {
		// var startIndex = template.indexOf('{');
		// var endIndex = template.indexOf('}');

		var arr = [];
		var startIndexArr = template.split('{');
		for (i in 0...startIndexArr.length) {
			var _startIndexArr = startIndexArr[i];
			// trace(_startIndexArr);
			var endIndexArr = _startIndexArr.split('}');
			arr = arr.concat(endIndexArr);
		}

		// trace('arr: ' + arr);
		// trace('sent: ' + arr.join(''));

		for (i in 0...arr.length) {
			var wordUntrim = arr[i];
			var word = arr[i].trim();
			if (Reflect.hasField(obj, word)) {
				// trace('> word: ' + word);
				// trace("< replace: " + Reflect.getProperty(obj, word));
				template = template.replace('{${wordUntrim}}', Reflect.getProperty(obj, word));
				arr[i] = Reflect.getProperty(obj, word);
				// } else {
				// arr[i] = '{${word}}';
			}
		}

		// trace('sent: ' + arr.join(''));

		// return arr.join('');
		return template;
	}
}
