package;

import haxe.Json;
import haxe.extern.EitherType;
import js.Browser.*;
import js.html.DOMParser;
import js.html.Element;
import js.html.SupportedType;
import js.lib.Function;
import js.lib.Proxy;
import utils.Html;
import utils.Sanitize;

using StringTools;

// typedef js.Lib.Reflect.defineProperty = Reflect.setField;

@:expose
class MonkeeChain {
	var DEBUG = true;
	var targetName:String = '';
	var target:Element = null;
	var data:Dynamic; // original data, set in constructor
	var _data:Dynamic = {}; // proxie
	var template:String = null;

	/**
	 * Simple and lightweight reactivity
	 *
	 * @example
	 * 		var app = new MonkeeChain('#app',{
	 * 			data:{
	 * 				test:'foo'
	 * 			},
	 * 			template: function (props){
	 * 				return `<p>${props.test}</p>`
	 * 			}
	 * 		});
	 *
	 * @param target		- element (document.getElementById('app'))
	 * 						- string ('#app')
	 * @param obj			see typedef
	 */
	public function new(target:EitherType<String, Element>, obj:MonkeeChainObj) {
		if (DEBUG)
			console.info(App.callIn('MonkeeChain'));

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

		if (obj.template != null && obj.template != '') {
			this.template = obj.template;
		} else {
			console.error('Element "${this.targetName}" has no template: ${Json.stringify(obj.template)}');
		}

		if (obj.data != null && obj.data != {}) {
			// [mck] do I need to check when you put the data in?
			// sanitIze everything, even own input ???
			// this._data = Sanitize.sanitizeJson(obj.data);
			if (obj.allowHTML == true) {
				console.log('leave it like this');
			}
			this._data = obj.data;
		}

		var handler = {
			get: function(target:Dynamic, property:String, receiver):Any {
				try {
					return new Proxy(untyped target[property], untyped handler);
				} catch (err) {
					return Sanitize.escapeHTML(js.lib.Reflect.get(target, property, receiver));
				}
			},
			defineProperty: function(target:Dynamic, property:String, descriptor) {
				// trace('defineProperty: ' + property, descriptor);
				// var bool = js.lib.Reflect.defineProperty(target, property, cast Html.sanitizeHTML(descriptor));

				var bool = js.lib.Reflect.defineProperty(target, property, descriptor);
				render();
				return bool;
			},
			deleteProperty: function(target:Dynamic, property:String) {
				// trace('deleteProperty: ' + property);
				var bool = js.lib.Reflect.deleteProperty(target, property);
				render();
				return bool;
			}
		}

		data = new Proxy(this._data, untyped handler);

		render();
	}

	public function render() {
		if (DEBUG)
			console.info(App.callIn('RENDER()'));

		if (Std.is(this.template, String)) {
			this.target.innerHTML = (this.template);
		} else {
			// this.target.innerHTML = cast(this.template, Function).call(this, this.data);
			this.target.innerHTML = untyped (this.template).call(this, this._data);
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

/*
 * Because MonkeeChain is quite long, I made sure more names will work
 *
 * DOESN'T WORK AT THIS MOMENT
 *
 * - Monk
 * - Monkee
 * - MonkeeZ
 * - M
 */
@:keep class Monk extends MonkeeChain {}
@:keep class Monkee extends MonkeeChain {}
@:keep class MonkeeZ extends MonkeeChain {}
@:keep class M extends MonkeeChain {}

typedef MonkeeChainObj = {
	@:optional var _id:String;
	var data:{};
	var template:EitherType<String, Function>;
	@:optional var allowHTML:Bool;
}
