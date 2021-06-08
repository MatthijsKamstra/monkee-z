package gui;

import haxe.Constraints.Function;

class Text extends InputBase implements IGuiBase {
	// values
	var title:String;
	var _value:String;
	var callback:Function;

	public function new(title:String, value:String, ?callback:Function) {
		this.title = title;
		this._value = value;
		this.callback = callback;
	}

	public function add(parent:Element) {
		var div = document.createDivElement();
		div.className = 'form-group';
		parent.appendChild(div);

		div.appendChild(createLabel(this.title));

		input = document.createInputElement();
		input.type = 'text';
		input.id = '${this.title}';
		input.name = '${this.title}';
		input.value = '${this._value}';
		input.placeholder = '${this.title}';

		input.oninput = function() {
			// trace(input.value);
			if (isAutoUpdate) {
				// trace('isAutoUpdate: ' + isAutoUpdate);
				Reflect.setProperty(this.scope, this.stringValue, input.value);
			}
			if (updateHandler != null) {
				// trace('updateHandler: ' + updateHandler);
				Reflect.callMethod(this.updateHandler, this.updateHandler, [input]);
			}
			if (callback != null)
				Reflect.callMethod(callback, callback, [input]);
		}
		// input.onclick = this.callback;

		div.appendChild(input);
	}
}
