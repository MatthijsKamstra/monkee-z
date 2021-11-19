(function ($hx_exports, $global) { "use strict";
class HxOverrides {
	static dateStr(date) {
		let m = date.getMonth() + 1;
		let d = date.getDate();
		let h = date.getHours();
		let mi = date.getMinutes();
		let s = date.getSeconds();
		return date.getFullYear() + "-" + (m < 10 ? "0" + m : "" + m) + "-" + (d < 10 ? "0" + d : "" + d) + " " + (h < 10 ? "0" + h : "" + h) + ":" + (mi < 10 ? "0" + mi : "" + mi) + ":" + (s < 10 ? "0" + s : "" + s);
	}
	static now() {
		return Date.now();
	}
}
class MonkeeDB {
	constructor() {
	}
	static create(name,isOverwrite) {
		if(isOverwrite == null) {
			isOverwrite = false;
		}
		if(MonkeeDB.isDebug) {
			$global.console.info("get local storage");
		}
		MonkeeDB.json = JSON.parse(window.localStorage.getItem(name));
		if(MonkeeDB.json == null || isOverwrite) {
			MonkeeDB.json = { _id : "localdata-" + new Date().getTime(), version : "0.0.1", created : HxOverrides.dateStr(new Date()), updated : HxOverrides.dateStr(new Date())};
			if(MonkeeDB.isDebug) {
				$global.console.log("initialize database:" + JSON.stringify(MonkeeDB.json));
			}
		}
		MonkeeDB.saveData(name);
	}
	static read(name,key) {
		if(MonkeeDB.json == null) {
			MonkeeDB.json = JSON.parse(window.localStorage.getItem(name));
		}
		if(key == null) {
			return MonkeeDB.json;
		}
		if(Object.prototype.hasOwnProperty.call(MonkeeDB.json,key)) {
			return Reflect.getProperty(MonkeeDB.json,key);
		} else {
			return null;
		}
	}
	static load(name) {
		if(MonkeeDB.json == null) {
			MonkeeDB.json = JSON.parse(window.localStorage.getItem(name));
		}
		if(MonkeeDB.json == null) {
			return null;
		} else {
			return MonkeeDB.json;
		}
	}
	static update(name,key,value) {
		if(MonkeeDB.json == null) {
			MonkeeDB.json = JSON.parse(window.localStorage.getItem(name));
		}
		Reflect.setProperty(MonkeeDB.json,key,value);
		Reflect.setProperty(MonkeeDB.json,"updated",HxOverrides.dateStr(new Date()));
		MonkeeDB.saveData(name);
	}
	static delete(name,key) {
		if(MonkeeDB.json == null) {
			MonkeeDB.json = JSON.parse(window.localStorage.getItem(name));
		}
		if(Object.prototype.hasOwnProperty.call(MonkeeDB.json,key)) {
			Reflect.deleteField(MonkeeDB.json,key);
		}
		MonkeeDB.saveData(name);
	}
	static clear(name) {
		MonkeeDB.json = null;
		window.localStorage.removeItem(name);
		if(MonkeeDB.isDebug) {
			$global.console.log("cleared data \"" + name + "\"");
		}
	}
	static saveData(name) {
		window.localStorage.setItem(name,JSON.stringify(MonkeeDB.json));
		if(MonkeeDB.isDebug) {
			$global.console.log(MonkeeDB.json);
		}
	}
}
$hx_exports["MonkeeDB"] = MonkeeDB;
class Reflect {
	static getProperty(o,field) {
		let tmp;
		if(o == null) {
			return null;
		} else {
			let tmp1;
			if(o.__properties__) {
				tmp = o.__properties__["get_" + field];
				tmp1 = tmp;
			} else {
				tmp1 = false;
			}
			if(tmp1) {
				return o[tmp]();
			} else {
				return o[field];
			}
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
	static deleteField(o,field) {
		if(!Object.prototype.hasOwnProperty.call(o,field)) {
			return false;
		}
		delete(o[field]);
		return true;
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
if(typeof(performance) != "undefined" ? typeof(performance.now) == "function" : false) {
	HxOverrides.now = performance.now.bind(performance);
}
{
}
MonkeeDB.isDebug = true;
})(typeof exports != "undefined" ? exports : typeof window != "undefined" ? window : typeof self != "undefined" ? self : this, typeof window != "undefined" ? window : typeof global != "undefined" ? global : typeof self != "undefined" ? self : this);
