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
		let _version = "0.0.1";
		_version = "2021-11-19 10:02:49";
		$global.console.info("[Monkee-Z]" + " " + ("DB " + "☢️") + " - version: " + _version);
	}
	static create(dbName,isOverwrite) {
		if(isOverwrite == null) {
			isOverwrite = false;
		}
		$global.console.info("get local storage");
		MonkeeDB.dbJson = JSON.parse(window.localStorage.getItem(dbName));
		if(MonkeeDB.dbJson == null || isOverwrite) {
			MonkeeDB.dbJson = { _id : "localdata-" + new Date().getTime(), version : "0.0.1", created : HxOverrides.dateStr(new Date()), updated : HxOverrides.dateStr(new Date())};
			$global.console.log("initialize database:" + JSON.stringify(MonkeeDB.dbJson));
			MonkeeDB.saveData(dbName);
		}
	}
	static read(dbName,key) {
		if(MonkeeDB.dbJson == null) {
			MonkeeDB.dbJson = JSON.parse(window.localStorage.getItem(dbName));
		}
		if(key == null) {
			return MonkeeDB.dbJson;
		}
		if(Object.prototype.hasOwnProperty.call(MonkeeDB.dbJson,key)) {
			return Reflect.getProperty(MonkeeDB.dbJson,key);
		} else {
			return null;
		}
	}
	static load(dbName) {
		if(MonkeeDB.dbJson == null) {
			MonkeeDB.dbJson = JSON.parse(window.localStorage.getItem(dbName));
		}
		if(MonkeeDB.dbJson == null) {
			return null;
		} else {
			return MonkeeDB.dbJson;
		}
	}
	static update(dbName,key,value) {
		if(MonkeeDB.dbJson == null) {
			MonkeeDB.dbJson = JSON.parse(window.localStorage.getItem(dbName));
		}
		Reflect.setProperty(MonkeeDB.dbJson,key,value);
		Reflect.setProperty(MonkeeDB.dbJson,"updated",HxOverrides.dateStr(new Date()));
		MonkeeDB.saveData(dbName);
	}
	static delete(dbName,key) {
		if(MonkeeDB.dbJson == null) {
			MonkeeDB.dbJson = JSON.parse(window.localStorage.getItem(dbName));
		}
		if(Object.prototype.hasOwnProperty.call(MonkeeDB.dbJson,key)) {
			Reflect.deleteField(MonkeeDB.dbJson,key);
		}
		MonkeeDB.saveData(dbName);
	}
	static clear(dbName) {
		MonkeeDB.dbJson = null;
		window.localStorage.removeItem(dbName);
		$global.console.log("cleared data \"" + dbName + "\"");
	}
	static saveData(dbName) {
		window.localStorage.setItem(dbName,JSON.stringify(MonkeeDB.dbJson));
		$global.console.log(MonkeeDB.dbJson);
	}
}
$hx_exports["MonkeeDB"] = MonkeeDB;
class MonkeeDBTest {
	constructor() {
		this.DEBUG = true;
		this.isDebug = true;
		if(this.DEBUG) {
			$global.console.log("[Monkee-Z]" + " - MonkeeDBTest - " + "2021-11-20 13:23:00");
		}
		this.init1();
	}
	init0() {
		let dbName = "test1";
		MonkeeDB.create(dbName);
		$global.console.log(MonkeeDB.read(dbName));
		MonkeeDB.update(dbName,"hello","Matthijs");
		$global.console.log(MonkeeDB.read(dbName,"hello"));
	}
	init1() {
		let dbName = "test2";
		let dbKey = "input_text";
		MonkeeDB.create(dbName);
		$global.console.log(MonkeeDB.read(dbName));
		let obj = MonkeeDB.read(dbName,dbKey);
		if(obj == null) {
			obj = { };
		}
		Reflect.setProperty(obj,"name","Matthijs Kamstra");
		obj["age"] = Std.random(1000);
		MonkeeDB.update(dbName,dbKey,obj);
		$global.console.log(MonkeeDB.read(dbName,dbKey));
		MonkeeDB.clear(dbName);
	}
	static main() {
		window.document.addEventListener("DOMContentLoaded",function(event) {
			let app = new MonkeeDBTest();
		});
	}
}
$hx_exports["MonkeeDBTest"] = MonkeeDBTest;
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
class Std {
	static random(x) {
		if(x <= 0) {
			return 0;
		} else {
			return Math.floor(Math.random() * x);
		}
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
MonkeeDB.VERSION = "0.0.1";
MonkeeDB.DEBUG = true;
MonkeeDBTest.main();
})(typeof exports != "undefined" ? exports : typeof window != "undefined" ? window : typeof self != "undefined" ? self : this, typeof window != "undefined" ? window : typeof global != "undefined" ? global : typeof self != "undefined" ? self : this);

//# sourceMappingURL=monkee_db_test.js.map