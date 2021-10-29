package gui;

import gui.*;
import js.Browser.*;
import js.html.*;
import haxe.Constraints.Function;

class Button {
	var title:String;
	var callback:Function;

	public static var ID = 0;

	public function new(title:String, callback:Function) {
		this.title = title;
		this.callback = callback;
	}

	public function add(parent:Element) {
		var div = document.createDivElement();
		div.className = 'form-group';
		parent.appendChild(div);

		var input = document.createInputElement();
		input.type = 'button';
		input.className = 'monkee-btn monkee-btn-${ID}';
		input.id = '${this.title}';
		input.name = '${this.title}';
		input.value = '${this.title}';
		input.onclick = this.callback;

		div.appendChild(input);

		ID++;
	}
}
