package;

import js.lib.Function;
import js.html.Element;
import haxe.extern.EitherType;

// import MonkeeChain.MonkeeChainObj;

@:native('MonkeeChain')
extern class MonkeeChainExterns {
	function new(target:EitherType<String, Element>, obj:MonkeeChainObjz):Void;
	public function render():Void;
}

typedef MonkeeChainObjz = {
	@:optional var _id:String;
	var data:{};
	var template:CommandHandler;
}

typedef CommandHandler = String->(Bool->Void)->Void;
