package;

import haxe.Constraints.Function;
import gui.*;
import js.Browser.*;
import js.html.*;

@:expose
class MonkeeGuiTest {
	// settings
	public var title = 'Title here';
	public var patternName = 'Pattern name here';
	public var description = 'Description here\nand here\nand another here';

	// settings in px
	var cellWidth:Float = 50;
	var cellHeight:Float = 60;
	var cellDepth:Float = 70;

	public function new() {
		initGui();
		initGui2();
	}

	function initGui() {
		var gui = MonkeeGui.create(0, 0, document.getElementById('monkee-gui'));
		gui.range('range', 20, 100, 60, 1, onChangeSizeHandler);
		gui.number('number', 20, 100, 70, 1, onChangeSizeHandler);
		gui.inputRangeNumber('range number', 20, 100, 70, 1, onChangeSizeHandler);
		gui.button('Export 2 SVG', export2svg);
		gui.text('Text', 'text');
		gui.text('Disabled text', 'disabled').disabled();
		gui.text('Title', this.title).update(this, 'title').onUpdateHandler(draw);
		gui.textArea('Description', this.description).disabled();
		gui.image('Title name', 'https://picsum.photos/300/200');
	}

	function initGui2() {
		var gui = MonkeeGui.create(0, 0, document.getElementById('monkee-gui-2'));
		gui.text('Pattern name', this.patternName).disabled().listen(this, 'patternName');
		gui.text('Title', this.title).disabled().listen(this, 'title');
	}

	function onChangeSizeHandler(e:InputElement) {
		// trace('onChangeSizeHandler');
		// console.log(e);
		var value = (cast(e, InputElement).value);

		var v = Std.parseFloat(value); // mm

		this.cellWidth = v;
		this.cellHeight = v;
		this.cellDepth = v;

		draw();
	}

	function draw() {
		console.log('DRAW');
	}

	// ____________________________________ export ____________________________________

	function export2svg() {
		console.log('EXPORT SVG');
	}

	function export2png() {
		console.log('EXPORT PNG');
	}

	function export2jpg() {
		console.log('EXPORT JPEG');
	}

	static public function main() {
		var app = new MonkeeGuiTest();
	}
}
