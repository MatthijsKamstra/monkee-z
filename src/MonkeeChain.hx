package;

import js.lib.Function;
import js.html.SupportedType;
import js.html.DOMParser;
import js.lib.Error;
import js.html.Element;
import haxe.extern.EitherType;
import js.Browser.*;

using StringTools;

@:expose
class MonkeeChain {
	var target:Element = null;
	var targetArr:Array<Element> = [];

	var data:Dynamic = {};
	var template:String = null;

	public function new(?target:EitherType<String, Element>, obj:MonkeeChainObj) {
		console.info(App.callIn('MonkeeChain'));

		if (Std.is(target, String)) {
			this.target = document.querySelector(target);
			// // trace('string');
			// var firstChar = '$target'.charAt(0);
			// var name = '$target'.substring(1, '$target'.length);
			// // trace(firstChar);
			// // '$target'.indexOf()
			// if (firstChar == '.') {
			// 	this.target = document.getElementsByClassName(name)[0]; // for now
			// 	this.targetArr = cast document.getElementsByClassName(name);
			// } else if (firstChar == '#') {
			// 	this.target = document.getElementById(name);
			// } else {
			// 	this.target = document.getElementById(target);
			// }
		} else {
			// trace('element');
			this.target = target;
		}

		if (this.target == null) {
			try {
				throw new Error('target is not set!');
				// throw new Error('Whoops!');
			} catch (e:Error) {
				console.error(e.name + ': ' + e.message);
			}
		} else {
			this.target.dataset.monkee = 'set';
			this.target.innerText = 'x ${target} set';
		}

		if (obj.data != null && obj.data != {}) {
			// trace(obj.data);
			this.data = obj.data;
		} else {
			console.error('no data ${obj.data}');
		}

		if (obj.template != null && obj.template != '') {
			// trace(obj.template);
			this.template = obj.template;
		} else {
			console.error('no template ${obj.template}');
		}
	}

	public function render() {
		console.info(App.callIn('render'));
		if (Std.is(this.template, String)) {
			this.target.innerHTML = (this.template);
		} else {
			// trace(this.template);

			// trace(untyped typeof(this.template) == "function");
			// trace(Std.is(this.template, Function));
			// trace(Type.typeof(this.template));
			// trace(Type.typeof(this.template) == TFunction);
			// trace(Reflect.isFunction(this.template));
			// trace(cast(this.template, Function).call(this, []));

			// this.target.innerHTML = cast(this.template, Function).call(this, this.data);
			this.target.innerHTML = untyped (this.template).call(this, this.data);

			// trace(el);
		}
	}

	/**
	 * Convert a template string into HTML DOM nodes
	 * @param  {String} str The template string
	 * @return {Node}       The template HTML
	 */
	public function stringToHTML(str:String):Element {
		var parser = new DOMParser();
		var doc = parser.parseFromString(str, SupportedType.TEXT_HTML);
		return doc.body;
	};
}

typedef MonkeeChainObj = {
	@:optional var _id:String;
	var data:Dynamic;
	var template:Dynamic;
}
