package utils;

class Query {
	/**
	 * @example
	 * 			"../../components/hero.html?test=hero&foo=bar"
	 *
	 * @param url
	 * @return Dynamic
	 */
	public static function convert(url:String):Dynamic {
		var obj = {};
		if (url.indexOf('?') != -1) {
			var q = url.split('?')[1]; // test=hero
			var arr = [];
			if (q.indexOf('&') != -1) {
				arr = q.split('&');
			} else {
				arr.push(q);
			}
			for (i in 0...arr.length) {
				var _arr = arr[i];

				var key = _arr.split('=')[0];
				var value = _arr.split('=')[1];
				if (value == null)
					return obj;
				Reflect.setField(obj, '${key}', value);
			}
		}
		return obj;
	}
}
