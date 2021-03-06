package externs;

import js.lib.Function;
import js.html.Element;
import haxe.extern.EitherType;

// import MonkeeChain.MonkeeChainObj;

@:native('MonkeeChain')
extern class MonkeeChain {
	public var data:Dynamic;

	function new(target:EitherType<String, Element>, obj:MonkeeChainObjz):Void;
	public function render():Void;
}

typedef MonkeeChainObjz = {
	@:optional var _id:String;
	var data:Dynamic;
	var template:EitherType<(props:Dynamic) -> String, String>;
	// var template:(props:Dynamic) -> String;
}
