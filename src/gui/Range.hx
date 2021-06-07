package gui;

import haxe.Constraints.Function;

class Range extends InputBase implements IGuiBase {
	var title:String;
	var min:Float;
	var max:Float;
	var value:Float;
	var step:Float;
	var callback:Function;

	public function new(title:String, min:Float, max:Float, value:Float, step:Float, callback:Function) {
		this.title = title; // :String,
		this.min = min; // :Float,
		this.max = max; // :Float,
		this.value = value; // :Float,
		this.step = step; // :Float,
		this.callback = callback; // :Function
	}

	public function add(parent:Element) {
		var div = document.createDivElement();
		div.className = 'form-group';
		parent.appendChild(div);

		div.appendChild(createLabel(this.title, '${this.title} (between ${Std.int(this.min)} and ${Std.int(this.max)}):'));

		var txt = document.createSpanElement();
		txt.id = '${this.title}_value';
		txt.innerText = '${this.value}';

		var input = document.createInputElement();
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
		div.appendChild(input);
		div.appendChild(txt);
	}

	public function listen(st:Dynamic) {
		trace('listen');
		trace(st);
	}
}
