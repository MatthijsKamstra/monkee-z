package gui;

import haxe.Constraints.Function;

class Image {
	var title:String;
	var url:String;

	public function new(title:String, url:String) {
		this.title = title;
		this.url = url;
	}

	public function add(parent:Element) {
		var div = document.createDivElement();
		parent.appendChild(div);

		var img = document.createImageElement();
		img.src = '${this.url}';
		img.name = '${this.title}';
		img.alt = '${this.title}';
		img.className = 'monkee-gui-img';
		div.appendChild(img);

		div.appendChild(img);
	}
}
