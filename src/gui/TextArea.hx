package gui;
import gui.*;
import js.Browser.*;
import js.html.*;
import haxe.Constraints.Function;

class TextArea implements IGuiBase {
	// element
	var textAreaEl:TextAreaElement;
	// values
	var title:String;
	var value:String;
	var callback:Function;

	public function new(title:String, value:String, ?callback:Function) {
		this.title = title;
		this.value = value;
		this.callback = callback;
	}

	public function add(parent:Element) {
		var div = document.createDivElement();
		parent.appendChild(div);

		var label = document.createLabelElement();
		label.htmlFor = '${this.title}';
		label.className = 'form-label';
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
}
