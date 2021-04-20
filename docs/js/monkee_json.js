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
class MonkeeJson {
	constructor() {
		this.loadingId = 0;
		this.loadingArr = [];
		this.dataAttributesArr = ["data-load","data-load-inner"];
		this.req = new XMLHttpRequest();
		this.DEBUG = false;
		let _gthis = this;
		window.document.addEventListener("DOMContentLoaded",function(event) {
			if(_gthis.DEBUG) {
				$global.console.info("[monkee]" + " - " + "MonkeeJson" + " - build: " + "2021-04-19 10:37:49");
			}
			_gthis.init();
		});
	}
	init() {
		let _g = 0;
		let _g1 = this.dataAttributesArr.length;
		while(_g < _g1) {
			let i = _g++;
			let dataAtr = this.dataAttributesArr[i];
			let arr = window.document.querySelectorAll("[" + dataAtr + "]");
			let _g1 = 0;
			let _g2 = arr.length;
			while(_g1 < _g2) {
				let i = _g1++;
				let wrapper = arr[i];
				let url = wrapper.getAttribute(dataAtr);
				let target = wrapper.getAttribute("data-target");
				let nameArr = wrapper.querySelectorAll("[data-name]");
				this.loadingArr.push({ el : wrapper, url : url, target : target, names : nameArr, throbber : utils_Throbber.set(wrapper), starttime : new Date().getTime(), type : dataAtr, isInner : dataAtr == "data-load-inner"});
			}
		}
		this.startLoading(this.loadingId);
	}
	startLoading(nr) {
		if(nr >= this.loadingArr.length) {
			return;
		}
		let obj = this.loadingArr[nr];
		this.loadData(obj);
		this.loadingId++;
	}
	loadData(obj) {
		let _gthis = this;
		this.req.open("GET",obj.url);
		this.req.onload = function() {
			obj.endtime = new Date().getTime();
			obj.throbber.parentElement.removeChild(obj.throbber);
			let body = utils_Html.getBody(_gthis.req.response);
			if(body == "") {
				body = _gthis.req.response;
			}
			$global.console.log("" + obj.url + ": " + (obj.endtime - obj.starttime) + "ms");
			if(obj.url.indexOf("json") != -1) {
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
			_gthis.startLoading(_gthis.loadingId);
		};
		this.req.onerror = function(error) {
			if(_gthis.DEBUG) {
				$global.console.error("[JS] error: " + error);
			}
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
		let app = new MonkeeJson();
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
MonkeeJson.main();
})(typeof window != "undefined" ? window : typeof global != "undefined" ? global : typeof self != "undefined" ? self : this);

//# sourceMappingURL=monkee_json.js.map