package;

import haxe.Json;
import js.lib.Function;
import js.html.SupportedType;
import js.html.DOMParser;
import js.lib.Error;
import js.html.Element;
import haxe.extern.EitherType;
import js.Browser.*;

using StringTools;

@:expose
class MonkeeChainLite {
	var DEBUG = #if debug true #else false #end;
	var targetName:String = '';
	var target:Element = null;
	var data:Dynamic = {};
	var template:String = null;

	/**
	 * Simple and lightweight reactivity
	 *
	 * @example
	 * 		var app = new MonkeeChainLite('#app',{
	 * 			data:{
	 * 				test:'foo'
	 * 			},
	 * 			template: function (props){
	 * 				return `<p>${props.test}</p>`
	 * 			}
	 * 		});
	 *
	 * @param target		element (document.getElementById('app')) or string ('#app')
	 * @param obj			see typedef
	 */
	public function new(target:EitherType<String, Element>, obj:MonkeeChainObj) {
		// if (DEBUG)
		// 	console.info(App.callIn('MonkeeChainLite'));

		// convert data to an element if needed
		if (Std.is(target, String)) {
			this.targetName = target;
			this.target = document.querySelector(target);
		} else {
			this.targetName = untyped target.id;
			this.target = target;
		}

		if (this.target == null) {
			console.error('Target "${this.targetName}" possibly not correct target/no element');
			return;
		}

		if (obj.data != null && obj.data != {}) {
			this.data = obj.data;
		}

		if (obj.template != null && obj.template != '') {
			this.template = obj.template;
		} else {
			console.error('Element "${this.targetName}" has template: ${Json.stringify(obj.template)}');
		}

		render();
	}

	public function render() {
		// if (DEBUG)
		// 	console.info(App.callIn('RENDER()'));

		if (Std.is(this.template, String)) {
			this.target.innerHTML = (this.template);
		} else {
			this.target.innerHTML = untyped (this.template).call(this, this.data);
		}
	}
}

typedef MonkeeChainObj = {
	@:optional var _id:String;
	var data:Dynamic;
	var template:EitherType<String, Function>;
}
