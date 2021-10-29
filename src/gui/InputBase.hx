package gui;

import gui.*;
import js.Browser.*;
import js.html.*;
import haxe.Constraints.Function;

class InputBase {
	// default
	var input:InputElement;

	// input value
	@:isVar public var value(get, set):Float;

	// autoupdate
	var isAutoUpdate = false;
	var scope:Dynamic;
	var stringValue:String;
	var updateHandler:Function;

	/**
	 * most input have a label, this is a label for all input element
	 *
	 * label.for and input.id are the title
	 *
	 * @example
	 * 				div.appendChild(createLabel(this.title));
	 * // or
	 * 				div.appendChild(createLabel(this.title, 'other message'));
	 *
	 * @param title				label.for and input.id are the title
	 * @param innerStr			if innerstr is null, use the title, otherwise use the innerString for label innertext
	 * @return LabelElement
	 */
	public function createLabel(title:String, ?innerStr:String):LabelElement {
		if (innerStr == null) {
			innerStr = title;
		}
		var label = document.createLabelElement();
		label.htmlFor = '${title}';
		label.className = 'monkee-gui-form-label';
		label.innerText = '${innerStr}';
		return (label);
	}

	// public function add(parent:Element) {}

	/**
	 * default the input is active, so this will disable it
	 *
	 * @example
	 * 			gui.text('Pattern name', this.patternName).disabled(); // disabled
	 * 			gui.text('Pattern name', this.patternName).disabled(true); // disabled
	 * 			gui.text('Pattern name', this.patternName).disabled(false); // not disabled
	 *
	 * @param isDisabled		disabled the input, default true
	 */
	public function disabled(isDisabled:Bool = true) {
		input.disabled = isDisabled;
		return this;
	}

	/**
	 * @example
	 * 				gui.text('Pattern name', this.patternName).placeHolder('What describes this pattern?');
	 *
	 * @param text		string used for placeholder info
	 */
	public function placeHolder(text:String) {
		input.placeholder = text;
		return this;
	}

	/**
	 * listen to a var changing, might be stressfull for browser...
	 *
	 * @param scope		where is the variable located (class?)
	 * @param variable 	string representing the var name (will use Reflect to get new var name)
	 */
	public function listen(scope:Dynamic, variable:String) {
		// trace('listen');
		window.setInterval(function() {
			var __var = (Reflect.getProperty(scope, variable));
			if (__var != this.value) {
				// trace('change');
				this.value = __var;
				this.input.value = '${this.value}';
			}
		}, 50);
		return this;
	}

	/**
	 * not sure what this does...
	 *
	 * @param scope		where is the variable located (class?)
	 * @param variable 	string representing the var name (will use Reflect to get new var name)
	 */
	public function update(scope:Dynamic, value:String) {
		this.scope = scope;
		this.stringValue = value;
		this.isAutoUpdate = true;
		// trace(Reflect.getProperty(scope, value));
		return this;
	}

	/**
	 * does this work?
	 *
	 * @param handler
	 */
	public function onUpdateHandler(handler:Function) {
		this.updateHandler = handler;
		return this;
	}

	// ____________________________________ getter/setter ____________________________________

	function get_value():Float {
		return value;
	}

	function set_value(v:Float):Float {
		return value = v;
	}
}
