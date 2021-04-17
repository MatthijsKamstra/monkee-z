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
	var DEBUG = true;
	var targetName:String = '';
	var target:Element = null;
	var data:Dynamic = null;
	var template:String = null;

	/**
	 * [Description]
	 * @param target
	 * @param obj
	 */
	public function new(target:EitherType<String, Element>, obj:MonkeeChainObj) {
		if (DEBUG)
			console.info(App.callIn('MonkeeChain'));

		// convert data to an element if needed
		if (Std.is(target, String)) {
			this.targetName = target;
			this.target = document.querySelector(target);

			// trace(this.target);
		} else {
			this.targetName = untyped target.id;
			this.target = target;
		}

		if (this.target == null) {
			console.error('Target "${this.targetName}" possibly not correct target/no element');
			return;
		} else {
			// visual check
			this.target.dataset.monkee = 'set';
			this.target.innerText = 'x ${this.targetName} set';
		}

		if (obj.data != null && obj.data != {}) {
			// trace(obj.data);
			this.data = obj.data;
		} else {
			console.error('Element "${this.targetName}" has no data: ${obj.data}');
			this.data = {};
		}

		if (obj.template != null && obj.template != '') {
			// trace(obj.template);
			this.template = obj.template;
		} else {
			console.error('Element "${this.targetName}" has template: ${obj.template}');
		}

		render();
	}

	public function render() {
		// if (DEBUG)
		// 	console.info(App.callIn('RENDER()'));

		if (Std.is(this.template, String)) {
			this.target.innerHTML = (this.template);
		} else {
			// this.target.innerHTML = cast(this.template, Function).call(this, this.data);
			this.target.innerHTML = untyped (this.template).call(this, this.data);
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
