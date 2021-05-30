package gui;
import gui.*;
import js.Browser.*;
import js.html.*;
import haxe.Constraints.Function;

class Button {
	var title:String;

	var callback:Function;

	public static var ID:Int = 0;

	public function new(title:String, callback:Function) {
		this.title = title; // :String,

		this.callback = callback; // :Function

		ID++;

		init();
	}

	function init() {}

	public function add(parent:Element) {
		var div = document.createDivElement();
		parent.appendChild(div);

		var input = document.createButtonElement();
		input.type = 'button';
		input.id = '${this.title}_${ID}';
		input.name = '${this.title}';
		input.innerText = '${this.title}';
		input.onclick = this.callback;

		div.appendChild(input);
	}
}
