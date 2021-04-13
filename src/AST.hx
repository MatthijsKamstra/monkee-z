import js.html.Element;

typedef LoadObj = {
	@:optional var _id:String;
	var url:String;
	var el:Element;
	@:optional var target:String;
	@:optional var names:Array<Element>;
	@:optional var throbber:Element;
	// time
	@:optional var starttime:Float;
	@:optional var endtime:Float;
	//
	@:optional var type:String;
	@:optional var isInner:Bool;
}
