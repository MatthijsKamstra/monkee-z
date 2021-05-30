package gui;
import gui.*;
import js.Browser.*;
import js.html.*;
import haxe.Constraints.Function;

class GuiBase {
	// default
	var input:InputElement;

	// autoupdate
	var isAutoUpdate = false;
	var scope:Dynamic;
	var stringValue:String;
	var updateHandler:Function;

	// public function add(parent:Element) {}
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
}
