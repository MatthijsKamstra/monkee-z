(function ($hx_exports, $global) { "use strict";
class HxOverrides {
	static cca(s,index) {
		let x = s.charCodeAt(index);
		if(x != x) {
			return undefined;
		}
		return x;
	}
	static substr(s,pos,len) {
		if(len == null) {
			len = s.length;
		} else if(len < 0) {
			if(pos == 0) {
				len = s.length + len;
			} else {
				return "";
			}
		}
		return s.substr(pos,len);
	}
	static now() {
		return Date.now();
	}
}
HxOverrides.__name__ = true;
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
Lambda.__name__ = true;
Math.__name__ = true;
class MonkeeBugger {
	constructor() {
		let _gthis = this;
		window.document.addEventListener("DOMContentLoaded",function(event) {
			let _version = "0.0.2";
			$global.console.info("[Monkee-Z]" + " " + "MonkeeBugger" + " - version: " + _version);
			_gthis.init();
			_gthis.highjack();
		});
	}
	init() {
		let _id = "debugDiv";
		let div = window.document.getElementById(_id);
		if(window.document.getElementById(_id) == null) {
			div = window.document.createElement("div");
			div.id = _id;
			div.setAttribute("style","@import url('https://fonts.googleapis.com/css2?family=Roboto+Mono&display=swap'); font-family: 'Roboto Mono','Courier New', Courier, monospace;padding: 10px; height: 200px; width: 100%; border: 1px solid #333; overflow:scroll;position: fixed;bottom: 0; color: white; background-color: rgba(0,0,0,0.5)");
			window.document.body.appendChild(div);
		}
		return div;
	}
	highjack() {
		let _log = ($_=$global.console,$bind($_,$_.log));
		let _warn = ($_=$global.console,$bind($_,$_.warn));
		let _info = ($_=$global.console,$bind($_,$_.info));
		let _error = ($_=$global.console,$bind($_,$_.error));
		let _gthis = this;
		$global.console.log = function(msg,...msg2) {
			if(msg2 == null) {
				_log(msg);
				_gthis.output("" + Std.string(msg));
			} else {
				_log(msg,msg2);
				_gthis.output("" + Std.string(msg) + " " + (msg2 == null ? "null" : "[" + msg2.toString() + "]"));
			}
		};
		$global.console.warn = function(...msg) {
			_warn(msg);
			_gthis.output("" + (msg == null ? "null" : "[" + msg.toString() + "]"),"warn");
		};
		$global.console.error = function(...msg) {
			_error(msg);
			_gthis.output("" + (msg == null ? "null" : "[" + msg.toString() + "]"),"error");
		};
		$global.console.info = function(...msg) {
			_info(msg);
			_gthis.output("" + (msg == null ? "null" : "[" + msg.toString() + "]"),"info");
		};
		window.onerror = function(message,url,linenumber,i,b) {
			$global.console.log("JavaScript error: " + message + " on line " + linenumber + " for " + url);
			return { };
		};
	}
	output(message,type) {
		if(type == null) {
			type = "log";
		}
		let style = "color:gray";
		switch(type) {
		case "error":
			style = "background-color:#FF3769; color:white;";
			break;
		case "info":
			style = "color:black";
			break;
		case "log":
			style = "color:white";
			break;
		case "warn":
			style = "background-color:#D8B700; color:white;";
			break;
		default:
			style = "color:black";
		}
		let div = this.init();
		let d = new Date();
		let time = StringTools.lpad("" + d.getHours(),"0",2) + ":" + StringTools.lpad("" + d.getMinutes(),"0",2) + ":" + StringTools.lpad("" + d.getSeconds(),"0",2) + " - ";
		let txt = div.innerHTML;
		div.innerHTML = "<div style=\"border-top:1px solid RGBA(0,0,0,0.3);" + style + "\"><span>" + time + " " + message + "</span></div>" + txt;
	}
}
MonkeeBugger.__name__ = true;
class MonkeeLoad {
	constructor() {
		this.onLoadReadyEvent = new Event("onLoadReady");
		this.onLoadUpdateEvent = new Event("onLoadUpdate");
		this.loadingId = 0;
		this.loadingArr = [];
		this.req = new XMLHttpRequest();
		this.arr = ["data-load","data-load-replace","data-load-inner"];
		this.DEBUG = false;
		let _version = "0.0.3";
		$global.console.info("[Monkee-Z]" + " " + "Load" + " - version: " + _version);
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
				let _loadObj = { el : _el, url : _url, query : utils_Query.convert(_url), isJson : _isJson, isInner : _configName == "data-load-inner", loaderType : "data-load-inner" == _configName ? "inner" : "outer", target : _target, names : _nameArr, throbber : utils_Throbber.set(_el)};
				this.loadingArr.push(_loadObj);
			}
		}
		this.startLoading(this.loadingId);
	}
	startLoading(nr) {
		if(nr >= this.loadingArr.length) {
			if(this.DEBUG) {
				$global.console.log("MonkeeLoad :: loading ready : " + this.loadingArr[this.loadingArr.length - 1].url);
			}
			window.dispatchEvent(this.onLoadUpdateEvent);
			window.dispatchEvent(this.onLoadReadyEvent);
			return;
		}
		this.loadData(this.loadingArr[nr]);
		this.loadingId++;
		if(nr > 0) {
			window.dispatchEvent(this.onLoadUpdateEvent);
			if(this.DEBUG) {
				$global.console.log("MonkeeLoad :: loading update : " + this.loadingArr[nr - 1].url);
			}
		}
	}
	loadData(obj) {
		obj.el.classList.add("monkee-load-loading");
		this.req.open("GET",obj.url);
		let _gthis = this;
		this.req.onload = function() {
			if(obj.throbber != null) {
				obj.throbber.parentElement.removeChild(obj.throbber);
			}
			obj.el.classList.remove("monkee-load-loading");
			let body = utils_Html.getBody(_gthis.req.response);
			if(body == "") {
				body = _gthis.req.response;
			}
			let script = utils_Html.getScript(_gthis.req.response);
			if(JSON.stringify(obj.query) != "{}") {
				let template = utils_Template.convert(obj.query,_gthis.req.response);
				utils_Html.processHTML(obj.el,template,obj.isInner);
			} else if(obj.isJson) {
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
}
MonkeeLoad.__name__ = true;
class MonkeeRoute {
	constructor() {
		let _gthis = this;
		window.document.addEventListener("DOMContentLoaded",function(event) {
			let _version = "0.0.4";
			$global.console.info("[Monkee-Z]" + " " + "Route" + " - version: " + _version);
			_gthis.setupRoute();
		});
	}
	setupRoute() {
		if(MonkeeRoute.defaultTitle == "") {
			MonkeeRoute.defaultTitle = window.document.title;
			MonkeeRoute.defaultUrl = window.window.location.href.split("#").join("");
			MonkeeRoute.previousLocationHref = MonkeeRoute.defaultUrl;
			this.removeHash();
			MonkeeRoute.map.h[""] = { link : null, url : MonkeeRoute.defaultUrl, id : ""};
		}
		let arr = [];
		let el = window.document.querySelector("[monkee-404]");
		if(el != null) {
			arr.push(el);
		}
		let _hidden = window.document.querySelectorAll("[monkee-hidden]");
		if(_hidden.length > 0) {
			let _g = 0;
			let _g1 = _hidden.length;
			while(_g < _g1) {
				let i = _g++;
				arr.push(_hidden[i]);
			}
		}
		let _monkee = window.document.querySelectorAll("[monkee]");
		if(_monkee.length > 0) {
			let _g = 0;
			let _g1 = _monkee.length;
			while(_g < _g1) {
				let i = _g++;
				arr.push(_monkee[i]);
			}
		}
		let _gthis = this;
		let _g = 0;
		let _g1 = arr.length;
		while(_g < _g1) {
			let i = _g++;
			let _link = arr[i];
			let _url = _link.href.indexOf(".html") == -1 ? _link.href + ".html" : _link.href;
			let _name = _url.split("/")[_url.split("/").length - 1].split(".")[0];
			let navObj = { link : _link, url : _url, id : _name};
			if(!Object.prototype.hasOwnProperty.call(MonkeeRoute.map.h,_name)) {
				MonkeeRoute.map.h[_name] = navObj;
			}
			_link.dataset.monkeeroute = "🐵";
			_link.onclick = function(e) {
				e.preventDefault();
				window.fetch(navObj.url).then(function(response) {
					return response.text();
				}).then(function(data) {
					_gthis.replaceBody(navObj,data);
				});
			};
		}
		window.addEventListener("onLoadUpdate",function(e) {
			_gthis.setupRoute();
		},true);
		window.onhashchange = $bind(this,this.locationHashChanged);
	}
	removeHash() {
		window.history.pushState("",window.document.title,window.window.location.pathname + window.window.location.search);
	}
	locationHashChanged() {
		let key = window.location.hash.split("#/").join("");
		let _gthis = this;
		if(Object.prototype.hasOwnProperty.call(MonkeeRoute.map.h,key)) {
			let navObj = MonkeeRoute.map.h[key];
			if(navObj.url == MonkeeRoute.defaultUrl) {
				window.location.reload();
			} else {
				window.fetch(navObj.url).then(function(response) {
					return response.text();
				}).then(function(data) {
					_gthis.replaceBody(navObj,data);
				});
			}
		} else if(window.location.hash.indexOf("#/") == -1) {
			if(MonkeeRoute.previousLocationHref == window.window.location.href) {
				window.location.reload();
			}
		} else if(Object.prototype.hasOwnProperty.call(MonkeeRoute.map.h,"404")) {
			let navObj = MonkeeRoute.map.h["404"];
			window.fetch(navObj.url).then(function(response) {
				return response.text();
			}).then(function(data) {
				_gthis.replaceBody(navObj,data);
			});
		} else {
			$global.console.info("unknown - " + MonkeeRoute.defaultUrl);
			window.window.location.href = MonkeeRoute.defaultUrl;
			window.location.reload();
			MonkeeRoute.previousLocationHref = window.window.location.href;
		}
	}
	replaceBody(navObj,html) {
		let tmp = MonkeeRoute.defaultTitle + " : ";
		window.document.title = tmp + navObj.id;
		if(navObj.id != "404") {
			window.location.hash = "/" + navObj.id;
		}
		MonkeeRoute.previousLocationHref = MonkeeRoute.defaultUrl;
		let all = Array.prototype.slice.call(window.document.body.children);
		window.document.body.innerHTML = html;
		let _g = 0;
		let _g1 = all.length;
		while(_g < _g1) {
			let i = _g++;
			let el = all[i];
			if(el.localName == "script") {
				window.document.body.appendChild(el);
			}
		}
		let _gthis = this;
		window.setTimeout(function() {
			_gthis.setupRoute();
		},50);
	}
}
MonkeeRoute.__name__ = true;
class MonkeeUtil {
	constructor() {
		this.DEBUG = false;
		let _version = "0.0.9";
		$global.console.info("[Monkee-Z]" + " " + "Util" + " - version: " + _version);
		this.init();
		this.autoEmbedCode();
	}
	autoEmbedCode() {
		let all = window.document.querySelectorAll("[data-monkee-code]");
		let _g = 0;
		let _g1 = all.length;
		while(_g < _g1) {
			let i = _g++;
			let el = all[i];
			let type = el.getAttribute("data-monkee-code");
			this.embedCode2(el,type);
		}
	}
	embedCode2(el,type) {
		let _version = "0.0.9";
		$global.console.info("[Monkee-Z]" + " " + "Util :: embedCode2" + " - version: " + _version);
		if(el.id == "") {
			el.id = "monkee-util-embed-" + new Date().getTime() + ("-" + Std.random(10000) + "-" + Std.random(10000));
		}
		let id = el.id;
		let _code = utils_Sanitize.escapeHTML(el.getElementsByTagName("code")[0].innerHTML);
		let spaced = _code.split("\t").join("  ");
		MonkeeUtil.setLink("//cdnjs.cloudflare.com/ajax/libs/highlight.js/10.7.2/styles/default.min.css");
		MonkeeUtil.setLink("https://cdnjs.cloudflare.com/ajax/libs/highlight.js/10.7.2/styles/monokai-sublime.min.css");
		MonkeeUtil.setScript("//cdnjs.cloudflare.com/ajax/libs/highlight.js/10.7.2/highlight.min.js");
		let app = new MonkeeChain("#" + id,{ data : { code : spaced, codeEscaped : utils_Sanitize.escapeHTML(spaced), codeType : type}, template : function(data) {
			return "\n\t\t        <div class=\"copy-code-wrapper-" + id + "\" style=\"position:relative;\" data-type=\"" + data.codeType + "\">\n\t\t        <textarea id=\"copy-code-input-" + id + "\" style=\"position:fixed;top:-100px;\">" + data.code + "</textarea>\n\t\t        <pre style=\"border-radius:4px;\"><code class=\"" + data.codeType + "\">" + data.codeEscaped + "</code></pre>\n\t\t        <button class=\"btn\" id=\"copy-code-btn-" + id + "\" style=\"position: absolute; top: 15px; right: 15px;\">📋</button>\n\t\t        </div>\n\t\t        ";
		}});
		let setButton = function() {
			let wrapper = window.document.getElementById("copy-code-wrapper-" + id);
			let btn = window.document.getElementById("copy-code-btn-" + id);
			btn.classList.add("btn-light");
			let input = window.document.getElementById("copy-code-input-" + id);
			input.setAttribute("style","position:fixed;top:-100px;");
			btn.onclick = function(e) {
				e.preventDefault();
				input.select();
				window.document.execCommand("copy");
				window.alert("Code is copied");
			};
		};
		setButton();
	}
	init() {
		let all = window.document.querySelectorAll("[data-escape]");
		let _g = 0;
		let _g1 = all.length;
		while(_g < _g1) {
			let i = _g++;
			let el = all[i];
			let html = el.getAttribute("data-escape");
			el.innerHTML = utils_Sanitize.escapeHTML(html);
		}
	}
	static mdTable2HTMLTable(id,filename) {
		let _version = "0.0.9";
		$global.console.info("[Monkee-Z]" + " " + "Util :: embedSpecs" + " - version: " + _version);
		let createTable = function(arr) {
			let html = "<table class=\"table table-striped table-sm\">";
			let _g = 0;
			let _g1 = arr.length;
			while(_g < _g1) {
				let i = _g++;
				let row = arr[i];
				html += "<tr>";
				let _g1 = 0;
				let _g2 = row.length;
				while(_g1 < _g2) {
					let j = _g1++;
					let col = row[j];
					html += "<td>" + col + "<td>";
				}
				html += "</tr>";
			}
			html += "<table>";
			return html;
		};
		let app_markdown = new MonkeeChain("" + id,{ data : { md : "", arr : []}, template : function(props) {
			return "\n\t        \t\t<div>" + createTable(props.arr) + "</div>\n\t        \t";
		}});
		window.fetch("../assets/md/monkee_load.md").then(function(response) {
			return response.text();
		}).then(function(data) {
			let arr = [];
			let linesArr = data.split("\n");
			let _g = 0;
			let _g1 = linesArr.length;
			while(_g < _g1) {
				let i = _g++;
				let _linesArr = linesArr[i];
				console.log("src/MonkeeUtil.hx:177:",_linesArr);
				if(i == 1) {
					continue;
				}
				let line = linesArr[i];
				let col = line.split(" | ");
				if(col.length <= 1) {
					continue;
				}
				let tempColArr = [];
				let _g1 = 0;
				let _g2 = col.length;
				while(_g1 < _g2) {
					let j = _g1++;
					let val = StringTools.replace(StringTools.replace(StringTools.replace(col[j],"| ","")," |",""),"","");
					tempColArr.push(val);
				}
				arr.push(tempColArr);
			}
			app_markdown.data.md = data;
			app_markdown.data.arr = arr;
			app_markdown.render();
		});
	}
	static embedSpecs(id,filename) {
		let _version = "0.0.9";
		$global.console.info("[Monkee-Z]" + " " + "Util :: embedSpecs" + " - version: " + _version);
		let app = new MonkeeChain("" + id,{ data : { json : { name : "", updated : "", size : { minified : "", original : "", uglifyjs : ""}, url : { minified : "", original : "", uglifyjs : ""}}}, template : function(props) {
			return "\n                    <div class=\"card\">\n            \t\t\t<div class=\"card-body\">\n    \t\t\t\t\t\t<strong>File " + props.json.name + ":</strong>\n    \t\t\t\t\t\t<p class=\"text-muted\">Updated: " + props.json.updated + "</p>\n    \t\t\t\t\t\t<ul>\n    \t\t\t\t\t\t\t<li>Download original file: <a href=\"" + props.json.url.original + "\">" + StringTools.replace(props.json.name,".js",".js") + "</a> (" + props.json.size.original + ")</li>\n    \t\t\t\t\t\t\t<li>UglifyJs file size: <a href=\"" + props.json.url.uglifyjs + "\">" + StringTools.replace(props.json.name,".js",".min.js") + "</a> (" + props.json.size.uglifyjs + ")</li>\n    \t\t\t\t\t\t\t<li>Extra minified file size: <a href=\"" + props.json.url.minified + "\">" + StringTools.replace(props.json.name,".js",".min.min.js") + "</a> (" + props.json.size.minified + ")</li>\n    \t\t\t\t\t\t</ul>\n    \t\t    \t    </div>\n    \t\t\t    </div>\n                    ";
		}});
		window.fetch("" + filename).then(function(response) {
			return response.json();
		}).then(function(data) {
			app.data.json = data;
			app.render();
		});
	}
	static embedCode(id,filename) {
		let _version = "0.0.9";
		$global.console.info("[Monkee-Z]" + " " + "Util :: embedCode" + " - version: " + _version);
		let _code = "";
		if(filename == null) {
			let _d = window.document.querySelector("" + id);
			_code = utils_Sanitize.escapeHTML(_d.getElementsByTagName("code")[0].innerHTML);
		}
		MonkeeUtil.setLink("//cdnjs.cloudflare.com/ajax/libs/highlight.js/10.7.2/styles/default.min.css");
		MonkeeUtil.setLink("https://cdnjs.cloudflare.com/ajax/libs/highlight.js/10.7.2/styles/monokai-sublime.min.css");
		MonkeeUtil.setScript("//cdnjs.cloudflare.com/ajax/libs/highlight.js/10.7.2/highlight.min.js");
		let app = new MonkeeChain("" + id,{ data : { code : "test", codeEscaped : "", codeType : "js"}, template : function(data) {
			return "\n\t\t        <div class=\"copy-code-wrapper-" + id + "\" style=\"position:relative;\" data-type=\"" + data.codeType + "\">\n\t\t        <textarea id=\"copy-code-input-" + id + "\" style=\"position:fixed;top:-100px;\">" + data.code + "</textarea>\n\t\t        <pre style=\"border-radius:4px;\"><code class=\"" + data.codeType + "\">" + data.codeEscaped + "</code></pre>\n\t\t        <button class=\"btn\" id=\"copy-code-btn-" + id + "\" style=\"position: absolute; top: 15px; right: 15px;\">📋</button>\n\t\t        </div>\n\t\t        ";
		}});
		let setButton = function() {
			let wrapper = window.document.getElementById("copy-code-wrapper-" + id);
			let btn = window.document.getElementById("copy-code-btn-" + id);
			btn.classList.add("btn-light");
			let input = window.document.getElementById("copy-code-input-" + id);
			input.setAttribute("style","position:fixed;top:-100px;");
			btn.onclick = function(e) {
				e.preventDefault();
				input.select();
				window.document.execCommand("copy");
				window.alert("Code is copied");
			};
		};
		setButton();
		if(filename != null) {
			window.fetch("" + filename).then(function(response) {
				return response.text();
			}).then(function(data) {
				let spaced = data.split("\t").join("  ");
				app.data.code = spaced;
				app.data.codeEscaped = utils_Sanitize.escapeHTML(spaced);
				app.data.codeType = filename.split(".")[filename.split(".").length - 1];
				app.render();
				window.setTimeout(function() {
					hljs.highlightAll();
					setButton();
				},500);
			});
		} else {
			let spaced = _code.split("\t").join("  ");
			app.data.code = spaced;
			app.data.codeEscaped = utils_Sanitize.escapeHTML(spaced);
			app.render();
			window.setTimeout(function() {
				hljs.highlightAll();
				setButton();
			},500);
		}
	}
	static setLink(href) {
		let one = window.document.querySelector("[href=\"" + href + "\"]");
		if(one == null) {
			let link = window.document.createElement("link");
			link.rel = "stylesheet";
			link.href = "" + href;
			window.document.body.appendChild(link);
		}
	}
	static setScript(src,callback) {
		let one = window.document.querySelector("[src=\"" + src + "\"]");
		if(one == null) {
			let script = window.document.createElement("script");
			script.onload = function(e) {
				$global.console.log(e);
				if(callback != null) {
					callback.apply(callback,[]);
				}
			};
			script.src = src;
			window.document.body.appendChild(script);
		} else if(callback != null) {
			callback.apply(callback,[]);
		}
	}
	static main() {
		window.document.addEventListener("DOMContentLoaded",function(event) {
			let app = new MonkeeUtil();
		});
	}
}
$hx_exports["MonkeeUtil"] = MonkeeUtil;
MonkeeUtil.__name__ = true;
class utils_Query {
	static convert(url) {
		let obj = { };
		if(url.indexOf("?") != -1) {
			let q = url.split("?")[1];
			let arr = [];
			if(q.indexOf("&") != -1) {
				arr = q.split("&");
			} else {
				arr.push(q);
			}
			let _g = 0;
			let _g1 = arr.length;
			while(_g < _g1) {
				let i = _g++;
				let _arr = arr[i];
				let key = _arr.split("=")[0];
				let value = _arr.split("=")[1];
				if(value == null) {
					return obj;
				}
				obj["" + key] = value;
			}
		}
		return obj;
	}
}
utils_Query.__name__ = true;
class utils_Throbber {
	static set(el) {
		let _div = window.document.createElement("div");
		_div.className = "loader";
		el.appendChild(_div);
		return _div;
	}
}
utils_Throbber.__name__ = true;
class MonkeeZ {
	constructor() {
		let _version = "0.0.1";
		$global.console.info("[Monkee-Z]" + " " + "MonkeeZ" + " - version: " + _version);
	}
	static main() {
		let app = new MonkeeZ();
	}
}
$hx_exports["MonkeeZ"] = MonkeeZ;
MonkeeZ.__name__ = true;
class Reflect {
	static field(o,field) {
		try {
			return o[field];
		} catch( _g ) {
			return null;
		}
	}
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
}
Reflect.__name__ = true;
class Std {
	static string(s) {
		return js_Boot.__string_rec(s,"");
	}
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
	static random(x) {
		if(x <= 0) {
			return 0;
		} else {
			return Math.floor(Math.random() * x);
		}
	}
}
Std.__name__ = true;
class StringTools {
	static isSpace(s,pos) {
		let c = HxOverrides.cca(s,pos);
		if(!(c > 8 && c < 14)) {
			return c == 32;
		} else {
			return true;
		}
	}
	static ltrim(s) {
		let l = s.length;
		let r = 0;
		while(r < l && StringTools.isSpace(s,r)) ++r;
		if(r > 0) {
			return HxOverrides.substr(s,r,l - r);
		} else {
			return s;
		}
	}
	static rtrim(s) {
		let l = s.length;
		let r = 0;
		while(r < l && StringTools.isSpace(s,l - r - 1)) ++r;
		if(r > 0) {
			return HxOverrides.substr(s,0,l - r);
		} else {
			return s;
		}
	}
	static trim(s) {
		return StringTools.ltrim(StringTools.rtrim(s));
	}
	static lpad(s,c,l) {
		if(c.length <= 0) {
			return s;
		}
		let buf_b = "";
		l -= s.length;
		while(buf_b.length < l) buf_b += c == null ? "null" : "" + c;
		buf_b += s == null ? "null" : "" + s;
		return buf_b;
	}
	static replace(s,sub,by) {
		return s.split(sub).join(by);
	}
}
StringTools.__name__ = true;
class haxe_ds_StringMap {
	constructor() {
		this.h = Object.create(null);
	}
}
haxe_ds_StringMap.__name__ = true;
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
class js_Boot {
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
}
js_Boot.__name__ = true;
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
utils_Html.__name__ = true;
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
utils_JsonPath.__name__ = true;
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
utils_Sanitize.__name__ = true;
class utils_Template {
	static convert(obj,template) {
		let arr = [];
		let startIndexArr = template.split("{");
		let _g = 0;
		let _g1 = startIndexArr.length;
		while(_g < _g1) {
			let i = _g++;
			let _startIndexArr = startIndexArr[i];
			let endIndexArr = _startIndexArr.split("}");
			arr = arr.concat(endIndexArr);
		}
		let _g2 = 0;
		let _g3 = arr.length;
		while(_g2 < _g3) {
			let i = _g2++;
			let wordUntrim = arr[i];
			let word = StringTools.trim(arr[i]);
			if(Object.prototype.hasOwnProperty.call(obj,word)) {
				template = StringTools.replace(template,"{" + wordUntrim + "}",Reflect.getProperty(obj,word));
				arr[i] = Reflect.getProperty(obj,word);
			}
		}
		return template;
	}
}
utils_Template.__name__ = true;
function $getIterator(o) { if( o instanceof Array ) return new haxe_iterators_ArrayIterator(o); else return o.iterator(); }
var $_;
function $bind(o,m) { if( m == null ) return null; if( m.__id__ == null ) m.__id__ = $global.$haxeUID++; var f; if( o.hx__closures__ == null ) o.hx__closures__ = {}; else f = o.hx__closures__[m.__id__]; if( f == null ) { f = m.bind(o); o.hx__closures__[m.__id__] = f; } return f; }
$global.$haxeUID |= 0;
if(typeof(performance) != "undefined" ? typeof(performance.now) == "function" : false) {
	HxOverrides.now = performance.now.bind(performance);
}
{
	String.__name__ = true;
	Array.__name__ = true;
	Date.__name__ = "Date";
}
js_Boot.__toStr = ({ }).toString;
MonkeeRoute.map = new haxe_ds_StringMap();
MonkeeRoute.defaultTitle = "";
MonkeeRoute.defaultUrl = "";
MonkeeRoute.previousLocationHref = "";
MonkeeUtil.VERSION = "0.0.9";
MonkeeZ.VERSION = "0.0.1";
MonkeeZ.load = new MonkeeLoad();
MonkeeZ.route = new MonkeeRoute();
MonkeeZ.bugger = new MonkeeBugger();
MonkeeZ.util = new MonkeeUtil();
MonkeeZ.main();
})(typeof exports != "undefined" ? exports : typeof window != "undefined" ? window : typeof self != "undefined" ? self : this, typeof window != "undefined" ? window : typeof global != "undefined" ? global : typeof self != "undefined" ? self : this);
