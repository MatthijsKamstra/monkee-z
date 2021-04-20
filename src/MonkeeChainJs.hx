package;

import MonkeeChainExterns;

class MonkeeChainJs {
	public function new() {
		trace('MonkeeChainJs');
		var app = new MonkeeChainExterns('#app', {
			template: function(props:Dynamic) {
				return '<p>${props.hello}</p>';
			},
			data: {
				hello: 'matthijs'
			},
		});
	}

	static public function main() {
		var app = new MonkeeChainJs();
	}
}
