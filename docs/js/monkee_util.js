// Generated by Haxe 4.1.5
(function ($hx_exports, $global) { "use strict";
class MonkeeUtil {
	constructor() {
		$global.console.info("[Monkee-Z]" + " - " + "MonkeeUtil" + " - build: " + "2021-05-08 11:53:46");
		this.init();
	}
	init() {
		let all = window.document.querySelectorAll("[data-escape]");
		let _g = 0;
		let _g1 = all.length;
		while(_g < _g1) {
			let i = _g++;
			let el = all[i];
			let html = el.getAttribute("data-escape");
			el.innerHTML = MonkeeUtil.escapeHTML(html);
		}
	}
	static embedSpecs(id,filename) {
		$global.console.info("[Monkee-Z]" + " - " + "MonkeeUtil :: embedSpecs" + " - build: " + "2021-05-08 11:53:46");
		let app = new MonkeeChain("" + id,{ data : { json : { name : "", updated : "", size : { minified : "", original : "", uglifyjs : ""}, url : { minified : "", original : "", uglifyjs : ""}}}, template : function(props) {
			return "\n                    <div class=\"card\">\n            \t\t\t<div class=\"card-body\">\n    \t\t\t\t\t\t<strong>File " + props.json.name + ":</strong>\n    \t\t\t\t\t\t<p class=\"text-muted\">Updated: " + props.json.updated + "</p>\n    \t\t\t\t\t\t<ul>\n    \t\t\t\t\t\t\t<li>Download original file: <a href=\"" + props.json.url.original + "\">" + props.json.url.original + "</a> (" + props.json.size.original + ")</li>\n    \t\t\t\t\t\t\t<li>UglifyJs file size: <a href=\"" + props.json.url.uglifyjs + "\">" + props.json.url.uglifyjs + "</a> (" + props.json.size.uglifyjs + ")</li>\n    \t\t\t\t\t\t\t<li>Extra minified file size: <a href=\"" + props.json.url.minified + "\">" + props.json.url.minified + "</a> (" + props.json.size.minified + ")</li>\n    \t\t\t\t\t\t</ul>\n    \t\t    \t    </div>\n    \t\t\t    </div>\n                    ";
		}});
		window.fetch("" + filename).then(function(response) {
			return response.json();
		}).then(function(data) {
			app.data.json = data;
			app.render();
		});
	}
	static embedCode(id,filename) {
		$global.console.info("[Monkee-Z]" + " - " + "MonkeeUtil :: embedCode" + " - build: " + "2021-05-08 11:53:46");
		MonkeeUtil.setLink("//cdnjs.cloudflare.com/ajax/libs/highlight.js/10.7.2/styles/default.min.css");
		MonkeeUtil.setLink("https://cdnjs.cloudflare.com/ajax/libs/highlight.js/10.7.2/styles/monokai-sublime.min.css");
		MonkeeUtil.setScript("//cdnjs.cloudflare.com/ajax/libs/highlight.js/10.7.2/highlight.min.js");
		let app = new MonkeeChain("" + id,{ data : { js : "", code : "test"}, template : function(data) {
			return "\n\t\t        <div class=\"copy-code-wrapper-" + id + "\" style=\"position:relative;\">\n\t\t        <textarea id=\"copy-code-input-" + id + "\" style=\"position:fixed;top:-100px;\">" + data.code + "</textarea>\n\t\t        <pre style=\"border-radius:4px;\"><code class=\"js\">" + data.js + "</code></pre>\n\t\t        <button class=\"btn\" id=\"copy-code-btn-" + id + "\" style=\"position: absolute; top: 15px; right: 15px;\">📋</button>\n\t\t        </div>\n\t\t        ";
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
		window.fetch("" + filename).then(function(response) {
			return response.text();
		}).then(function(data) {
			app.data.code = data;
			app.data.js = MonkeeUtil.escapeHTML(data);
			app.render();
			window.setTimeout(function() {
				hljs.highlightAll();
				setButton();
			},500);
		});
	}
	static escapeHTML(html) {
		return StringTools.replace(StringTools.replace(StringTools.replace(StringTools.replace(html,"&","&amp;"),"\"","&quot;"),"<","&lt;"),">","&gt;");
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
	static setScript(src) {
		let one = window.document.querySelector("[src=\"" + src + "\"]");
		if(one == null) {
			let script = window.document.createElement("script");
			script.src = src;
			window.document.body.appendChild(script);
		}
	}
	static main() {
		window.document.addEventListener("DOMContentLoaded",function(event) {
			let app = new MonkeeUtil();
		});
	}
}
$hx_exports["MonkeeUtil"] = MonkeeUtil;
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
MonkeeUtil.main();
})(typeof exports != "undefined" ? exports : typeof window != "undefined" ? window : typeof self != "undefined" ? self : this, typeof window != "undefined" ? window : typeof global != "undefined" ? global : typeof self != "undefined" ? self : this);
