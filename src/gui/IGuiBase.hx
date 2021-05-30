package gui;
import gui.*;
import js.Browser.*;
import js.html.*;
interface IGuiBase {
	// public var type:String;
	// @:isVar public var id(get, set):String;
	// // TODO remove settings
	// public function svg(?settings:Settings):String;
	// public function ctx(ctx:js.html.CanvasRenderingContext2D):Void;
	// public function gl(gl:js.html.webgl.RenderingContext):Void;
	// public function toString():String;
	// public function getName():String;
	public function add(parent:Element):Void;
	public function disabled(isDisabled:Bool = true):Dynamic;
}
