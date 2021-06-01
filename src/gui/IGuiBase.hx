package gui;

interface IGuiBase {
	public function add(parent:Element):Void;
	public function disabled(isDisabled:Bool = true):Dynamic;
	// function createLabel(title:String, ?innerStr:String):LabelElement;
}
