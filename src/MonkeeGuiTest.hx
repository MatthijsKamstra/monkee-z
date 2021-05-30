package ;

import haxe.Constraints.Function;




import gui.*;
import js.Browser.*;
import js.html.*;


class MonkeeGuiTest {

	// settings
	var title = '';
    var patternName = '';
    var description = '';

	// settings in px
	var cellWidth = 189.0;
	var cellHeight = 189.0;
	var cellDepth = 189.0;

    public function new() {
        var gui = MonkeeGui.create(0, 0, document.getElementById('monkee-gui'));
		gui.range('size_in_mm', 20, 100, cellWidth, 1, onChangeSizeHandler);
		gui.number('size_in_mm', 20, 100, cellWidth, 1, onChangeSizeHandler);
		gui.button('Export 2 SVG', export2svg);
		gui.button('Export 2 PNG', export2png);
		gui.button('Export 2 JPG', export2jpg);
		gui.text('Pattern name', this.patternName).disabled();
		gui.text('Title', this.title).update(this, 'title').onUpdateHandler(draw);
		gui.textArea('Description', this.description, onChangeSizeHandler).disabled();
		gui.image('Title name', 'public/img/shapes/cube2.png');
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
		console.log('DRAW (${this.description})');
    }

    // ____________________________________ export ____________________________________

	function export2svg() {
		console.log('SVG');
	}

	function export2png() {
		console.log('PNG');
	}

	function export2jpg() {
		console.log('JPEG');
	}


    static public function main () {
        var app = new MonkeeGuiTest();
    }
}