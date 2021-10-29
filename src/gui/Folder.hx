package gui;

import gui.*;
import js.Browser.*;
import js.html.*;

class Folder extends InputBase implements IGuiBase {
	var title:String;
	var isClosed:Bool;

	public var content:DivElement;

	public static var ID = 0;

	public function new(title:String, ?isClosed:Bool = false) {
		this.title = title;
		this.isClosed = isClosed;

		ID++;
	}

	/**
		<section class="accordion">
			<input type="checkbox" name="collapse" id="handle1" checked="checked">
			<h2 class="handle">
				<label for="handle1">26A. Trappist Single</label>
			</h2>
			<div class="content">
				<p><strong>Overall Impression:</strong> A pale, bitter, highly attenuated and well carbonated Trappist ale, showing a fruity-spicy Trappist yeast character, a spicy-floral hop profile, and a soft, supportive grainy-sweet malt palate.</p>
				<p><strong>History:</strong> While Trappist breweries have a tradition of brewing a lower-strength beer as a monk’s daily ration, the bitter, pale beer this style describes is a relatively modern invention reflecting current tastes. Westvleteren first brewed theirs in 1999, but replaced older lower-gravity products.</p>
			</div>
		</section>
	 */
	public function add(parent:Element) {
		var div = document.createDivElement();
		div.className = 'form-group';
		parent.appendChild(div);

		var section = document.createElement('section');
		section.className = 'accordion';
		div.appendChild(section);

		var input = document.createInputElement();
		input.id = 'handle_${ID}';
		input.type = 'checkbox';
		input.name = 'collapse';
		input.checked = !this.isClosed;

		section.appendChild(input);

		var label = document.createLabelElement();
		label.htmlFor = 'handle_${ID}';
		// label.className = 'monkee-gui-form-label';
		label.innerText = '${title}';

		section.appendChild(label);

		content = document.createDivElement();
		content.className = 'content';
		// content.innerHTML = '<p>Your detailed contents...</p>';

		section.appendChild(content);
	}

	// public function image(title:String, url:String) {
	// 	var el = new gui.Image(title, url);
	// 	el.add(content);
	// 	return el;
	// }
}
