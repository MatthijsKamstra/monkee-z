// Generated by Haxe 4.1.5
(function ($global) { "use strict";
class Lambda {
	static foreach(it,f) {
		let x = $getIterator(it);
		while(x.hasNext()) {
			let x1 = x.next();
			if(!f(x1)) {
				return false;
			}
		}
		return true;
	}
}
class MonkeeLoad {
	constructor() {
		this.loadingId = 0;
		this.loadingArr = [];
		this.req = new XMLHttpRequest();
		this.arr = ["data-load","data-load-replace","data-load-inner"];
		this.DEBUG = true;
		if(this.DEBUG) {
			$global.console.info("[Monkee-Z]" + " - " + "MonkeeLoad" + " - build: " + "2021-05-08 11:53:44");
		}
		let _g = 0;
		let _g1 = this.arr.length;
		while(_g < _g1) {
			let i = _g++;
			let _configName = this.arr[i];
			let _elements = window.document.querySelectorAll("[" + _configName + "]");
			let _g1 = 0;
			let _g2 = _elements.length;
			while(_g1 < _g2) {
				let i = _g1++;
				let _el = _elements[i];
				let _url = _el.getAttribute(_configName);
				let _isJson = _url.indexOf(".json") != -1;
				let _target = _el.getAttribute("data-target");
				let _nameArr = _el.querySelectorAll("[data-name]");
				let _loadObj = { el : _el, url : _url, isJson : _isJson, isInner : _configName == "data-load-inner", loaderType : "data-load-inner" == _configName ? "inner" : "outer", target : _target, names : _nameArr, throbber : utils_Throbber.set(_el)};
				this.loadingArr.push(_loadObj);
			}
		}
		this.startLoading(this.loadingId);
	}
	startLoading(nr) {
		if(nr >= this.loadingArr.length) {
			return;
		}
		this.loadData(this.loadingArr[nr]);
		this.loadingId++;
	}
	loadData(obj) {
		let _gthis = this;
		this.req.open("GET",obj.url);
		this.req.onload = function() {
			if(obj.throbber != null) {
				obj.throbber.parentElement.removeChild(obj.throbber);
			}
			let body = utils_Html.getBody(_gthis.req.response);
			if(body == "") {
				body = _gthis.req.response;
			}
			let script = utils_Html.getScript(_gthis.req.response);
			if(obj.isJson) {
				if(_gthis.DEBUG) {
					$global.console.warn(obj.url);
				}
				_gthis.jsonConvert(obj,_gthis.req.response);
			} else if(obj.names.length > 0) {
				let _g = 0;
				let _g1 = obj.names.length;
				while(_g < _g1) {
					let i = _g++;
					let el = obj.names[i];
					utils_Html.processHTML(el,body,obj.isInner);
				}
			} else {
				utils_Html.processHTML(obj.el,body,obj.isInner);
			}
			if(script != "") {
				let scriptEl = window.document.createElement("script");
				scriptEl.innerHTML = script;
				window.document.body.appendChild(scriptEl);
			}
			_gthis.startLoading(_gthis.loadingId);
		};
		this.req.onerror = function(error) {
			$global.console.error("error: " + error);
		};
		this.req.send();
	}
	jsonConvert(obj,str) {
		let json = JSON.parse(str);
		if(obj.names.length > 0) {
			let _g = 0;
			let _g1 = obj.names.length;
			while(_g < _g1) {
				let i = _g++;
				let tag = obj.names[i].tagName.toLowerCase();
				if(tag == "input") {
					let input = obj.names[i];
					input.value = json[input.getAttribute("data-name")];
				} else {
					let el = obj.names[i];
					let attr = el.getAttribute("data-name");
					let data = utils_JsonPath.search(JSON.stringify(json),attr);
					el.innerHTML = data;
				}
			}
		} else {
			utils_Html.processHTML(obj.el,str,true);
		}
	}
	static main() {
		window.document.addEventListener("DOMContentLoaded",function(event) {
			let app = new MonkeeLoad();
		});
	}
}
class Reflect {
	static field(o,field) {
		try {
			return o[field];
		} catch( _g ) {
			return null;
		}
	}
}
class Std {
	static parseInt(x) {
		if(x != null) {
			let _g = 0;
			let _g1 = x.length;
			while(_g < _g1) {
				let i = _g++;
				let c = x.charCodeAt(i);
				if(c <= 8 || c >= 14 && c != 32 && c != 45) {
					let nc = x.charCodeAt(i + 1);
					let v = parseInt(x,nc == 120 || nc == 88 ? 16 : 10);
					if(isNaN(v)) {
						return null;
					} else {
						return v;
					}
				}
			}
		}
		return null;
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
class utils_Html {
	static getBody(html) {
		let test = html.toLowerCase();
		let x = test.indexOf("<body");
		if(x == -1) {
			return "";
		}
		x = test.indexOf(">",x);
		if(x == -1) {
			return "";
		}
		let y = test.lastIndexOf("</body>");
		if(y == -1) {
			y = test.lastIndexOf("</html>");
		}
		if(y == -1) {
			y = html.length;
		}
		return html.slice(x + 1,y);
	}
	static getScript(html) {
		let htmlLowerCase = html.toLowerCase();
		let x = htmlLowerCase.indexOf("<script");
		if(x == -1) {
			return "";
		}
		x = htmlLowerCase.indexOf(">",x);
		if(x == -1) {
			return "";
		}
		let y = htmlLowerCase.lastIndexOf("</script>");
		return html.slice(x + 1,y);
	}
	static processHTML(target,html,isInner) {
		if(isInner) {
			target.innerHTML = html;
		} else {
			target.outerHTML = html;
		}
	}
}
class utils_JsonPath {
	static search(jsonStr,path) {
		let result = JSON.parse(jsonStr);
		Lambda.foreach(path.split("."),function(key) {
			if(key.indexOf("[") != -1) {
				let index = Std.parseInt(StringTools.replace(key.split("[")[1],"]",""));
				key = key.split("[")[0];
				let arr = Reflect.field(result,key);
				result = arr[index];
				if(index > arr.length) {
					return null;
				}
			} else if(!Object.prototype.hasOwnProperty.call(result,key)) {
				result = null;
				return false;
			} else {
				result = Reflect.field(result,key);
			}
			return true;
		});
		return result;
	}
}
class utils_Throbber {
	static set(el) {
		let _div = window.document.createElement("div");
		_div.className = "loader";
		el.appendChild(_div);
		return _div;
	}
}
function $getIterator(o) { if( o instanceof Array ) return new haxe_iterators_ArrayIterator(o); else return o.iterator(); }
MonkeeLoad.main();
})(typeof window != "undefined" ? window : typeof global != "undefined" ? global : typeof self != "undefined" ? self : this);
