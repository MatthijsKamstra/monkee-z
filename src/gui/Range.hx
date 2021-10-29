package gui;

import gui.*;
import js.Browser.*;
import js.html.*;
import haxe.Constraints.Function;

class Range extends InputBase implements IGuiBase {
	var title:String;
	var min:Float;
	var max:Float;
	// var value:Float; // in InputBase
	var step:Float;
	var callback:Function;

	var txt:SpanElement;

	var wrapper:DivElement;

	public function new(title:String, min:Float, max:Float, value:Float, step:Float, callback:Function) {
		this.title = title; // :String,
		this.min = min; // :Float,
		this.max = max; // :Float,
		this.value = value; // :Float,
		this.step = step; // :Float,
		this.callback = callback; // :Function
	}

	public function add(parent:Element) {
		wrapper = document.createDivElement();
		wrapper.className = 'form-group range-group';
		parent.appendChild(wrapper);

		wrapper.appendChild(createLabel(this.title, '${this.title} (between ${Std.int(this.min)} and ${Std.int(this.max)}):'));

		txt = document.createSpanElement();
		txt.id = '${this.title}_value';
		txt.innerText = '${this.value}';

		input = document.createInputElement();
		input.type = 'range';
		input.id = '${this.title}';
		input.name = '${this.title}';
		input.min = '${this.min}';
		input.max = '${this.max}';
		input.value = '${this.value}';
		input.step = '${this.step}';
		// input.onchange = Reflect.callMethod(callback, callback, [input]);
		input.oninput = function() {
			txt.innerHTML = js.Lib.nativeThis.value;
			Reflect.callMethod(callback, callback, [input]);
		}
		wrapper.appendChild(input);
		wrapper.appendChild(txt);
	}

	override public function listen(scope:Dynamic, variable:String) {
		// trace('listen');
		window.setInterval(function() {
			var __var = (Reflect.getProperty(scope, variable));
			if (__var != this.value) {
				// trace('change');
				this.value = __var;
				this.input.value = '${this.value}';
				this.txt.innerHTML = '${this.value}';
			}
		}, 50);
		return this;
	}

	override public function disabled(isDisabled:Bool = true) {
		input.disabled = isDisabled;
		if (isDisabled)
			wrapper.classList.add('disabled');
		return this;
	}
}
