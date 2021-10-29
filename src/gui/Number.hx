package gui;

import gui.*;
import js.Browser.*;
import js.html.*;
import haxe.Constraints.Function;

class Number extends InputBase implements IGuiBase {
	var title:String;
	var min:Float;
	var max:Float;
	// var value:Float;
	var step:Float;
	var callback:Function;

	public function new(title:String, min:Float, max:Float, value:Float, step:Float, callback:Function) {
		this.title = title;
		this.min = min;
		this.max = max;
		this.value = value;
		this.step = step;
		this.callback = callback;
	}

	public function add(parent:Element) {
		var div = document.createDivElement();
		div.className = 'form-group';
		parent.appendChild(div);

		div.appendChild(createLabel(this.title, '${this.title} (between ${Std.int(this.min)} and ${Std.int(this.max)}):'));

		var input = document.createInputElement();
		input.type = 'number';
		input.id = '${this.title}';
		input.name = '${this.title}';
		input.min = '${this.min}';
		input.max = '${this.max}';
		input.value = '${this.value}';
		input.step = '${this.step}';
		// input.onchange = this.callback;
		input.oninput = function() {
			Reflect.callMethod(callback, callback, [input]);
		}
		div.appendChild(input);
	}
}
