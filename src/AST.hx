import js.html.Element;

typedef LoadObj = {
	@:optional var _id:String;
	var url:String;
	var el:Element;
	@:optional var target:String;
	@:optional var names:Array<Element>;
}
