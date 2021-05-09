// Generated by Haxe 4.1.5
(function ($global) { "use strict";
var $estr = function() { return js_Boot.__string_rec(this,''); },$hxEnums = $hxEnums || {},$_;
Math.__name__ = true;
class Reflect {
	static field(o,field) {
		try {
			return o[field];
		} catch( _g ) {
			return null;
		}
	}
	static setProperty(o,field,value) {
		let tmp;
		let tmp1;
		if(o.__properties__) {
			tmp = o.__properties__["set_" + field];
			tmp1 = tmp;
		} else {
			tmp1 = false;
		}
		if(tmp1) {
			o[tmp](value);
		} else {
			o[field] = value;
		}
	}
	static fields(o) {
		let a = [];
		if(o != null) {
			let hasOwnProperty = Object.prototype.hasOwnProperty;
			for( var f in o ) {
			if(f != "__id__" && f != "hx__closures__" && hasOwnProperty.call(o,f)) {
				a.push(f);
			}
			}
		}
		return a;
	}
}
Reflect.__name__ = true;
class Research {
	constructor() {
		console.log("src/Research.hx:14:","Research");
		this.sanitize();
	}
	sanitize() {
		let xss = "<image src=x onerror=alert('XSS_image')>";
		let json = { numberVal : 100, intVal : 3, floatVal : 4.4, stringVal : "hello", boolVal : true, arrayVal : ["one","two"], objVal : { }};
		let content = JSON.stringify(json);
		console.log("src/Research.hx:41:","json.stringVal: " + json.stringVal);
		json.stringVal = xss;
		console.log("src/Research.hx:43:","json.stringVal: " + json.stringVal);
		let sanitized = utils_Sanitize.sanitizeJson(json);
		console.log("src/Research.hx:45:","sanitized.stringVal: " + sanitized.stringVal);
		json = utils_Sanitize.sanitizeJson(json);
		console.log("src/Research.hx:47:","json.stringVal: " + json.stringVal);
		console.log("src/Research.hx:49:","json.boolVal: " + (json.boolVal == null ? "null" : "" + json.boolVal));
		json.boolVal = xss;
		console.log("src/Research.hx:51:","json.boolVal: " + (json.boolVal == null ? "null" : "" + json.boolVal));
		json = utils_Sanitize.sanitizeJson(json);
		console.log("src/Research.hx:53:","json.boolVal: " + (json.boolVal == null ? "null" : "" + json.boolVal));
		console.log("src/Research.hx:55:","json.arrayVal: " + Std.string(json.arrayVal));
		json.arrayVal.push(xss);
		console.log("src/Research.hx:57:","json.arrayVal: " + Std.string(json.arrayVal));
		json = utils_Sanitize.sanitizeJson(json);
		console.log("src/Research.hx:59:","json.arrayVal: " + Std.string(json.arrayVal));
		console.log("src/Research.hx:61:","json.objVal: " + Std.string(json.objVal));
		json.objVal.title = xss;
		console.log("src/Research.hx:63:","json.objVal: " + Std.string(json.objVal));
		json = utils_Sanitize.sanitizeJson(json);
		console.log("src/Research.hx:65:","json.objVal: " + Std.string(json.objVal));
	}
	static main() {
		new Research();
	}
}
Research.__name__ = true;
Object.assign(Research.prototype, {
	__class__: Research
});
class Std {
	static string(s) {
		return js_Boot.__string_rec(s,"");
	}
}
Std.__name__ = true;
class StringTools {
	static replace(s,sub,by) {
		return s.split(sub).join(by);
	}
}
StringTools.__name__ = true;
var ValueType = $hxEnums["ValueType"] = { __ename__ : true, __constructs__ : ["TNull","TInt","TFloat","TBool","TObject","TFunction","TClass","TEnum","TUnknown"]
	,TNull: {_hx_index:0,__enum__:"ValueType",toString:$estr}
	,TInt: {_hx_index:1,__enum__:"ValueType",toString:$estr}
	,TFloat: {_hx_index:2,__enum__:"ValueType",toString:$estr}
	,TBool: {_hx_index:3,__enum__:"ValueType",toString:$estr}
	,TObject: {_hx_index:4,__enum__:"ValueType",toString:$estr}
	,TFunction: {_hx_index:5,__enum__:"ValueType",toString:$estr}
	,TClass: ($_=function(c) { return {_hx_index:6,c:c,__enum__:"ValueType",toString:$estr}; },$_.__params__ = ["c"],$_)
	,TEnum: ($_=function(e) { return {_hx_index:7,e:e,__enum__:"ValueType",toString:$estr}; },$_.__params__ = ["e"],$_)
	,TUnknown: {_hx_index:8,__enum__:"ValueType",toString:$estr}
};
class Type {
	static typeof(v) {
		switch(typeof(v)) {
		case "boolean":
			return ValueType.TBool;
		case "function":
			if(v.__name__ || v.__ename__) {
				return ValueType.TObject;
			}
			return ValueType.TFunction;
		case "number":
			if(Math.ceil(v) == v % 2147483648.0) {
				return ValueType.TInt;
			}
			return ValueType.TFloat;
		case "object":
			if(v == null) {
				return ValueType.TNull;
			}
			let e = v.__enum__;
			if(e != null) {
				return ValueType.TEnum($hxEnums[e]);
			}
			let c = js_Boot.getClass(v);
			if(c != null) {
				return ValueType.TClass(c);
			}
			return ValueType.TObject;
		case "string":
			return ValueType.TClass(String);
		case "undefined":
			return ValueType.TNull;
		default:
			return ValueType.TUnknown;
		}
	}
}
Type.__name__ = true;
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
haxe_iterators_ArrayIterator.__name__ = true;
Object.assign(haxe_iterators_ArrayIterator.prototype, {
	__class__: haxe_iterators_ArrayIterator
});
class js_Boot {
	static getClass(o) {
		if(o == null) {
			return null;
		} else if(((o) instanceof Array)) {
			return Array;
		} else {
			let cl = o.__class__;
			if(cl != null) {
				return cl;
			}
			let name = js_Boot.__nativeClassName(o);
			if(name != null) {
				return js_Boot.__resolveNativeClass(name);
			}
			return null;
		}
	}
	static __string_rec(o,s) {
		if(o == null) {
			return "null";
		}
		if(s.length >= 5) {
			return "<...>";
		}
		let t = typeof(o);
		if(t == "function" && (o.__name__ || o.__ename__)) {
			t = "object";
		}
		switch(t) {
		case "function":
			return "<function>";
		case "object":
			if(o.__enum__) {
				let e = $hxEnums[o.__enum__];
				let n = e.__constructs__[o._hx_index];
				let con = e[n];
				if(con.__params__) {
					s = s + "\t";
					return n + "(" + ((function($this) {
						var $r;
						let _g = [];
						{
							let _g1 = 0;
							let _g2 = con.__params__;
							while(true) {
								if(!(_g1 < _g2.length)) {
									break;
								}
								let p = _g2[_g1];
								_g1 = _g1 + 1;
								_g.push(js_Boot.__string_rec(o[p],s));
							}
						}
						$r = _g;
						return $r;
					}(this))).join(",") + ")";
				} else {
					return n;
				}
			}
			if(((o) instanceof Array)) {
				let str = "[";
				s += "\t";
				let _g = 0;
				let _g1 = o.length;
				while(_g < _g1) {
					let i = _g++;
					str += (i > 0 ? "," : "") + js_Boot.__string_rec(o[i],s);
				}
				str += "]";
				return str;
			}
			let tostr;
			try {
				tostr = o.toString;
			} catch( _g ) {
				return "???";
			}
			if(tostr != null && tostr != Object.toString && typeof(tostr) == "function") {
				let s2 = o.toString();
				if(s2 != "[object Object]") {
					return s2;
				}
			}
			let str = "{\n";
			s += "\t";
			let hasp = o.hasOwnProperty != null;
			let k = null;
			for( k in o ) {
			if(hasp && !o.hasOwnProperty(k)) {
				continue;
			}
			if(k == "prototype" || k == "__class__" || k == "__super__" || k == "__interfaces__" || k == "__properties__") {
				continue;
			}
			if(str.length != 2) {
				str += ", \n";
			}
			str += s + k + " : " + js_Boot.__string_rec(o[k],s);
			}
			s = s.substring(1);
			str += "\n" + s + "}";
			return str;
		case "string":
			return o;
		default:
			return String(o);
		}
	}
	static __nativeClassName(o) {
		let name = js_Boot.__toStr.call(o).slice(8,-1);
		if(name == "Object" || name == "Function" || name == "Math" || name == "JSON") {
			return null;
		}
		return name;
	}
	static __resolveNativeClass(name) {
		return $global[name];
	}
}
js_Boot.__name__ = true;
class utils_Sanitize {
	static sanitizeJson(json) {
		if(utils_Sanitize.IS_DEBUG) {
			console.log("src/utils/Sanitize.hx:18:","---> sanitizeJson " + Std.string(json));
		}
		if(utils_Sanitize.IS_DEBUG) {
			console.log("src/utils/Sanitize.hx:23:",json);
		}
		let _g = 0;
		let _g1 = Reflect.fields(json);
		while(_g < _g1.length) {
			let n = _g1[_g];
			++_g;
			let value = Reflect.field(json,n);
			Type.typeof(value);
			if(typeof(value) == "number" && ((value | 0) === value) || typeof(value) == "number") {
				if(utils_Sanitize.IS_DEBUG) {
					console.log("src/utils/Sanitize.hx:33:","numbers, don't do anything");
				}
			} else if(typeof(value) == "boolean") {
				if(utils_Sanitize.IS_DEBUG) {
					console.log("src/utils/Sanitize.hx:36:","bool, don't do anything");
				}
			} else if(typeof(value) == "string") {
				if(utils_Sanitize.IS_DEBUG) {
					console.log("src/utils/Sanitize.hx:39:","string, sanatize");
				}
				console.log("src/utils/Sanitize.hx:41:",json);
				Reflect.setProperty(json,n,utils_Sanitize.sanitizeHTML(value));
				console.log("src/utils/Sanitize.hx:43:",json);
			} else if(((value) instanceof Array)) {
				if(utils_Sanitize.IS_DEBUG) {
					console.log("src/utils/Sanitize.hx:47:","DO something clever with Array " + value);
				}
				let value1 = value;
				let _g = 0;
				let _g1 = value1.length;
				while(_g < _g1) {
					let i = _g++;
					if(Type.typeof(value1[i]) == ValueType.TObject) {
						utils_Sanitize.sanitizeJson(value1);
						continue;
					}
					value1[i] = utils_Sanitize.sanitizeHTML(value1[i]);
				}
			} else {
				if(utils_Sanitize.IS_DEBUG) {
					console.log("src/utils/Sanitize.hx:64:","DO something clever with OBject " + value);
				}
				utils_Sanitize.sanitizeJson(value);
			}
		}
		return json;
	}
	static sanitizeHTML(unsafe_str) {
		return StringTools.replace(StringTools.replace(StringTools.replace(StringTools.replace(StringTools.replace(unsafe_str,"&","&amp;"),"<","&lt;"),">","&gt;"),"\"","&quot;"),"'","&#39;");
	}
}
utils_Sanitize.__name__ = true;
String.prototype.__class__ = String;
String.__name__ = true;
Array.__name__ = true;
js_Boot.__toStr = ({ }).toString;
utils_Sanitize.IS_DEBUG = true;
Research.main();
})(typeof window != "undefined" ? window : typeof global != "undefined" ? global : typeof self != "undefined" ? self : this);
