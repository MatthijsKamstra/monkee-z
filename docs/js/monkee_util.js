(function ($hx_exports, $global) { "use strict";
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
class Std {
	static random(x) {
		if(x <= 0) {
			return 0;
		} else {
			return Math.floor(Math.random() * x);
		}
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
MonkeeUtil.VERSION = "0.0.9";
MonkeeUtil.main();
})(typeof exports != "undefined" ? exports : typeof window != "undefined" ? window : typeof self != "undefined" ? self : this, typeof window != "undefined" ? window : typeof global != "undefined" ? global : typeof self != "undefined" ? self : this);
