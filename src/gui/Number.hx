package gui;
import gui.*;
import js.Browser.*;
import js.html.*;
import haxe.Constraints.Function;

class Number {
	var title:String;
	var min:Float;
	var max:Float;
	var value:Float;
	var step:Float;
	var callback:Function;

	public static var ID:Int = 0;

	public function new(title:String, min:Float, max:Float, value:Float, step:Float, callback:Function) {
		this.title = title; // :String,
		this.min = min; // :Float,
		this.max = max; // :Float,
		this.value = value; // :Float,
		this.step = step; // :Float,
		this.callback = callback; // :Function

		ID++;

		init();
	}

	function init() {}

	public function add(parent:Element) {
		var div = document.createDivElement();
		parent.appendChild(div);

		var label = document.createLabelElement();
		label.htmlFor = '${this.title}_${ID}';
		label.className = 'form-label';
		label.innerText = '${this.title} (between ${Std.int(this.min)} and ${Std.int(this.max)}):';
		div.appendChild(label);

		var input = document.createInputElement();
		input.type = 'number';
		input.id = '${this.title}_${ID}';
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
