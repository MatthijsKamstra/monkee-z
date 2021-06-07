package gui;

import haxe.Constraints.Function;

class TextArea implements IGuiBase {
	// element
	var textAreaEl:TextAreaElement;
	// values
	var title:String;
	// var value:String;
	var callback:Function;

	@:isVar public var value(get, set):String;

	function get_value():String {
		return value;
	}

	function set_value(str:String):String {
		if (textAreaEl != null)
			textAreaEl.value = str;
		return value = str;
	}

	public function new(title:String, value:String, ?callback:Function) {
		this.title = title;
		this.value = value;
		this.callback = callback;
	}

	public function add(parent:Element) {
		var div = document.createDivElement();
		div.className = 'form-group';
		parent.appendChild(div);

		var label = document.createLabelElement();
		label.htmlFor = '${this.title}';
		label.className = '__form-label';
		label.innerText = '${this.title}';
		div.appendChild(label);

		textAreaEl = document.createTextAreaElement();
		textAreaEl.id = '${this.title}';
		textAreaEl.name = '${this.title}';
		textAreaEl.value = '${this.value}';

		div.appendChild(textAreaEl);
	}

	public function disabled(isDisabled:Bool = true) {
		textAreaEl.disabled = isDisabled;
		return this;
	}

	public function placeHolder(title:String) {
		textAreaEl.placeholder = title;
		return this;
	}
}
