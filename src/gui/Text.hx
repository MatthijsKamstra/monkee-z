package gui;
import gui.*;
import js.Browser.*;
import js.html.*;
import haxe.Constraints.Function;

class Text {
	// default
	var input:InputElement;

	// values
	var title:String;
	var value:String;
	var callback:Function;

	// autoupdate
	var isAutoUpdate = false;
	var scope:Dynamic;
	var stringValue:String;
	var updateHandler:Function;

	public function new(title:String, value:String, ?callback:Function) {
		this.title = title;
		this.value = value;
		this.callback = callback;
		init();
	}

	function init() {}

	public function disabled(isDisabled:Bool = true) {
		input.disabled = isDisabled;
		return this;
	}

	/**
	 * [Description]
	 * @param scope
	 * @param value
	 */
	public function update(scope:Dynamic, value:String) {
		this.scope = scope;
		this.stringValue = value;
		this.isAutoUpdate = true;
		// trace(Reflect.getProperty(scope, value));
		return this;
	}

	public function onUpdateHandler(handler:Function) {
		this.updateHandler = handler;
		return this;
	}

	public function add(parent:Element) {
		var div = document.createDivElement();
		parent.appendChild(div);

		var label = document.createLabelElement();
		label.htmlFor = '${this.title}';
		label.className = 'form-label';
		label.innerText = '${this.title}';
		div.appendChild(label);

		input = document.createInputElement();
		input.type = 'text';
		input.id = '${this.title}';
		input.name = '${this.title}';
		input.value = '${this.value}';

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
