package gui;

import haxe.Constraints.Function;

class Radio extends InputBase implements IGuiBase {
	var title:String;
	var callback:Function;

	public function new(title:String, value:Float, callback:Function) {
		this.title = title;
		this.value = value;
		this.callback = callback;

		console.warn('WIP, don\'t use (yet)');
	}

	public function add(parent:Element) {
		var div = document.createDivElement();
		div.className = 'form-group';
		parent.appendChild(div);

		var input = document.createInputElement();
		input.type = 'radio';
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
