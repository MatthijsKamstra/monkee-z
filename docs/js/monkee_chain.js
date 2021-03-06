(function ($hx_exports, $global) { "use strict";
class MonkeeChain {
	constructor(target,obj) {
		this.template = null;
		this._data = { };
		this.target = null;
		this.targetName = "";
		this.DEBUG = false;
		let _version = "0.0.1";
		$global.console.info("[Monkee-Z]" + " " + "Chain" + " - version: " + _version);
		if(typeof(target) == "string") {
			this.targetName = target;
			this.target = window.document.querySelector(target);
		} else {
			this.targetName = target.id;
			this.target = target;
		}
		if(this.target == null) {
			$global.console.error("Target \"" + this.targetName + "\" possibly not correct target/no element");
			return;
		}
		if(obj.template != null && obj.template != "") {
			this.template = obj.template;
		} else {
			$global.console.error("Element \"" + this.targetName + "\" has no template: " + JSON.stringify(obj.template));
		}
		if(obj.data != null && obj.data != { }) {
			if(obj.allowHTML == true) {
				$global.console.log("leave it like this");
			}
			this._data = obj.data;
		}
		let _gthis = this;
		let handler = { get : function(target,property,receiver) {
			try {
				return new Proxy(target[property],handler);
			} catch( _g ) {
				return utils_Sanitize.escapeHTML(Reflect.get(target,property,receiver));
			}
		}, defineProperty : function(target,property,descriptor) {
			let bool = Reflect.defineProperty(target,property,descriptor);
			_gthis.render();
			return bool;
		}, deleteProperty : function(target,property) {
			let bool = Reflect.deleteProperty(target,property);
			_gthis.render();
			return bool;
		}};
		this.data = new Proxy(this._data,handler);
		this.render();
	}
	render() {
		if(this.DEBUG) {
			let _version = "";
			$global.console.info("[Monkee-Z]" + " " + "RENDER()" + " - version: " + _version);
		}
		if(typeof(this.template) == "string") {
			this.target.innerHTML = this.template;
		} else {
			this.target.innerHTML = this.template.call(this,this._data);
		}
	}
	stringToHTML(str) {
		let parser = new DOMParser();
		let doc = parser.parseFromString(str,"text/html");
		return doc.body;
	}
}
$hx_exports["MonkeeChain"] = MonkeeChain;
class Monk extends MonkeeChain {
	constructor(target,obj) {
		super(target,obj);
	}
}
class Monkee extends MonkeeChain {
	constructor(target,obj) {
		super(target,obj);
	}
}
class MonkeeZ extends MonkeeChain {
	constructor(target,obj) {
		super(target,obj);
	}
}
class M extends MonkeeChain {
	constructor(target,obj) {
		super(target,obj);
	}
}
class StringTools {
	static replace(s,sub,by) {
		return s.split(sub).join(by);
	}
}
class haxe_iterators_ArrayIterator {
	constructor(array) {
		this.current = 0;
		this.array = array;
	}
	hasNext() {
		return this.current < this.array.length;
	}
	next() {
		return this.array[this.current++];
	}
}
class utils_Sanitize {
	static sanitizeHTML(unsafe_str) {
		if(unsafe_str.indexOf("&amp;") != -1) {
			StringTools.replace(unsafe_str,"&","&amp;");
		}
		return StringTools.replace(StringTools.replace(StringTools.replace(StringTools.replace(unsafe_str,"<","&lt;"),">","&gt;"),"\"","&quot;"),"'","&#39;");
	}
	static escapeHTML(unsafe_str) {
		return utils_Sanitize.sanitizeHTML(unsafe_str);
	}
}
{
}
MonkeeChain.VERSION = "0.0.1";
})(typeof exports != "undefined" ? exports : typeof window != "undefined" ? window : typeof self != "undefined" ? self : this, typeof window != "undefined" ? window : typeof global != "undefined" ? global : typeof self != "undefined" ? self : this);
