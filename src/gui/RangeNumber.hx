package gui;

import gui.*;
import js.Browser.*;
import js.html.*;
import haxe.Constraints.Function;

class RangeNumber extends InputBase implements IGuiBase {
	var title:String;
	var min:Float;
	var max:Float;
	// var value:Float;
	var step:Float;
	var callback:Function;

	public function new(title:String, min:Float, max:Float, value:Float, step:Float, callback:Function) {
		this.title = title; // :String,
		this.min = min; // :Float,
		this.max = max; // :Float,
		this.value = value; // :Float,
		this.step = step; // :Float,
		this.callback = callback; // :Function

		init();
	}

	function init() {}

	public function add(parent:Element) {
		var div = document.createDivElement();
		div.className = 'form-group';
		parent.appendChild(div);

		div.appendChild(createLabel(this.title, '${this.title} (between ${Std.int(this.min)} and ${Std.int(this.max)}):'));

		var input = document.createInputElement();

		var inputNr = document.createInputElement();
		inputNr.type = 'number';
		inputNr.id = '${this.title}';
		inputNr.name = '${this.title}';
		inputNr.min = '${this.min}';
		inputNr.max = '${this.max}';
		inputNr.value = '${this.value}';
		inputNr.step = '${this.step}';
		// inputNr.onchange = this.callback;
		inputNr.oninput = function() {
			input.value = js.Lib.nativeThis.value;
			Reflect.callMethod(callback, callback, [inputNr]);
		}

		input.type = 'range';
		input.id = '${this.title}';
		input.name = '${this.title}';
		input.min = '${this.min}';
		input.max = '${this.max}';
		input.value = '${this.value}';
		input.step = '${this.step}';
		// input.onchange = this.callback;
		input.oninput = function() {
			inputNr.value = js.Lib.nativeThis.value;
			Reflect.callMethod(callback, callback, [input]);
		}
		div.appendChild(input);

		div.appendChild(inputNr);
	}
}
