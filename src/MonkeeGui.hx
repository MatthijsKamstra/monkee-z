package;

import haxe.Constraints.Function;
import gui.*;
import js.Browser.*;
import js.html.*;

/**
	*
	* var guiSettings:js.dat.gui.GUI.GUIOptions = {
				name: '${toString()}',
				autoPlace: false,
				// closed: true
			};
			var gui = new js.dat.gui.GUI(guiSettings);
 */
/**
	var settings = QuickSettings.create(x, y, panelTitle, parent);
	settings.addBoolean(title, value, callback);                // creates a checkbox
	// settings.addButton(title, callback);                        // creates a button
	settings.addColor(title, color, callback);                  // creates a color input
	settings.addDate(title, date, callback);                    // adds a date input
	settings.addDropDown(title, [items], callback);             // creates a dropdown list
	settings.addElement(title, htmlELement);                    // adds any arbitrary HTML element to the panel
	settings.addFileChooser(title, labelStr, filter, callback); // adds a file chooser
	settings.addHTML(title, htmlString);                        // adds any arbitrary HTML to the panel
	settings.addImage(title, imageURL, callback);               // creates and image element with the specified URL
	// settings.addNumber(title, min, max, value, step, callback); // creates a number input
	settings.addPassword(title, text, callback);                // adds a password text field
	settings.addProgressBar(title, max, value, valueDisplay);   // creates a progress bar
	// settings.addRange(title, min, max, value, step, callback);  // creates a range slider
	settings.addText(title, text, callback);                    // creates an input text field
	settings.addTextArea(title, text, callback);                // creates a resizable text area
	settings.addTime(title, time, callback);                    // adds a time input
 */
@:expose
class MonkeeGui {
	public var _x:Int;
	public var _y:Int;
	public var _parent:Element;
	public var _wrapper:DivElement;

	var css = CompileTime.readFile("monkeegui-style.css");

	public function new(x:Int, y:Int, parent:Element) {
		_x = x;
		_y = y;
		_parent = parent;
		// create wrapper for classes
		createWrapper();
	}

	function createWrapper() {
		var style = document.createStyleElement();
		style.innerHTML = css;
		document.body.append(style);

		_wrapper = document.createDivElement();
		_wrapper.className = 'monkee-gui-wrapper';
		_parent.appendChild(_wrapper);
	}

	public static function create(x:Int, y:Int, parent:Element) {
		var monkeeGui = new MonkeeGui(x, y, parent);
		return monkeeGui;
	}

	/**
	 * create a range element
	 *
	 * @param title     range title
	 * @param min       minimal value
	 * @param max       maximum value
	 * @param value     current value
	 * @param step      steps when dragging
	 * @param callback  function
	 */
	public function range(title:String, min:Float, max:Float, value:Float, step:Float, callback:Function) {
		var range = new gui.Range(title, min, max, value, step, callback);
		range.add(_wrapper);
		return range;
	}

	public function inputRange(title:String, min:Float, max:Float, value:Float, step:Float, callback:Function) {
		return range(title, min, max, value, step, callback);
	}

	/**
	 * create a number element
	 *
	 * @param title     number title
	 * @param min       minimal value
	 * @param max       maximum value
	 * @param value     current value
	 * @param step      steps when dragging
	 * @param callback  function
	 */
	public function number(title:String, min:Float, max:Float, value:Float, step:Float, callback:Function) {
		var el = new gui.Number(title, min, max, value, step, callback);
		el.add(_wrapper);
		return el;
	}

	public function inputNumber(title:String, min:Float, max:Float, value:Float, step:Float, callback:Function) {
		return number(title, min, max, value, step, callback);
	}

	/**
	 * create a range, number element
	 *
	 * @param title     range title
	 * @param min       minimal value
	 * @param max       maximum value
	 * @param value     current value
	 * @param step      steps when dragging
	 * @param callback  function
	 */
	public function rangeNumber(title:String, min:Float, max:Float, value:Float, step:Float, callback:Function) {
		var el = new gui.RangeNumber(title, min, max, value, step, callback);
		el.add(_wrapper);
		return el;
	}

	public function inputRangeNumber(title:String, min:Float, max:Float, value:Float, step:Float, callback:Function) {
		return rangeNumber(title, min, max, value, step, callback);
	}

	/**
	 * create a button element
	 *
	 * @param title     button title
	 * @param callback  function
	 */
	public function button(title:String, callback:Function) {
		var el = new gui.Button(title, callback);
		el.add(_wrapper);
		return el;
	}

	public function inputButton(title:String, callback:Function) {
		return button(title, callback);
	}

	/**
	 * create a text element
	 *
	 * @param title     text title
	 * @param callback  function
	 */
	public function textArea(title:String, value:String, ?callback:Function) {
		var el = new gui.TextArea(title, value, callback);
		el.add(_wrapper);
		return el;
	}

	/**
	 * create a text element
	 *
	 * @param title     text title
	 * @param callback  function
	 */
	public function text(title:String, value:String, ?callback:Function) {
		var el = new gui.Text(title, value, callback);
		el.add(_wrapper);
		return el;
	}

	public function inputtext(title:String, value:String, callback:Function) {
		return text(title, value, callback);
	}

	/**
	 * create a text element
	 *
	 * @param title     text title
	 * @param callback  function
	 */
	public function image(title:String, url:String) {
		var el = new gui.Image(title, url);
		el.add(_wrapper);
		return el;
	}
}
