package gui;
import gui.*;
import js.Browser.*;
import js.html.*;
import haxe.Constraints.Function;

class Image {
	var title:String;
	var url:String;

	var callback:Function;

	public static var ID:Int = 0;

	public function new(title:String, url:String) {
		this.title = title; // :String,
		this.url = url; // :String,
	}

	function init() {}

	public function add(parent:Element) {
		var div = document.createDivElement();
		parent.appendChild(div);

		var img = document.createImageElement();
		img.src = '${this.url}';
		img.name = '${this.title}';
		img.alt = '${this.title}';
		img.className = 'form-img img-fluid';
		div.appendChild(img);

		div.appendChild(img);
	}
}
