package gui;

import haxe.Constraints.Function;

class InputBase {
	// default
	var input:InputElement;

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
	public function disabled(isDisabled:Bool = true) {
		input.disabled = isDisabled;
		return this;
	}

	public function placeHolder(title:String) {
		input.placeholder = title;
		return this;
	}

	/**
	 * [Description]
	 * @param scope
	 * @param value
	 */
	public function update(scope:Dynamic, value:String) {
		this.scope = scope;
		this.stringValue = value;
		this.isAutoUpdate = true;
		// trace(Reflect.getProperty(scope, value));
		return this;
	}

	public function onUpdateHandler(handler:Function) {
		this.updateHandler = handler;
		return this;
	}
}
