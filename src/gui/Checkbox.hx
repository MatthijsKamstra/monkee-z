package gui;

import gui.*;
import js.Browser.*;
import js.html.*;
import haxe.Constraints.Function;

class Checkbox extends InputBase implements IGuiBase {
	var title:String;
	var isChecked:Bool = false;
	var callback:Function;

	public function new(title:String, isChecked:Bool, callback:Function) {
		this.title = title;
		this.isChecked = isChecked;
		this.callback = callback;
	}

	public function add(parent:Element) {
		var div = document.createDivElement();
		div.className = 'form-group';
		parent.appendChild(div);

		var input = document.createInputElement();
		input.type = 'checkbox';
		input.id = '${this.title}';
		input.name = '${this.title}';
		input.value = '${this.value}';
		input.oninput = function() {
			Reflect.callMethod(callback, callback, [input]);
		}
		div.appendChild(input);

		div.appendChild(createLabel(this.title));
	}
}
