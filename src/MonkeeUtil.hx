package;

import js.Syntax;
import haxe.Json;
import js.lib.Function;
import js.html.SupportedType;
import js.html.DOMParser;
import js.lib.Error;
import js.html.Element;
import haxe.extern.EitherType;
import js.Browser.*;

using StringTools;

@:expose
@:keep
class MonkeeUtil {
	public function new() {
		// if (DEBUG)
		console.info(App.callIn('MonkeeUtil'));
		init();
	}

	function init() {
		var all = document.querySelectorAll('[data-escape]');

		for (i in 0...all.length) {
			var el:Element = cast all[i];
			var html = el.getAttribute('data-escape');
			// el.innerHTML = (html);
			// el.innerText = MonkeeUtil.escapeHTML(html);
			el.innerHTML = MonkeeUtil.escapeHTML(html);
		}
	}

	/**
	 * [Description]
	 * @param id
	 * @param filename
	 */
	public static function embedCode(id:String, filename:String) {
		console.info(App.callIn('MonkeeUtil :: embedCode'));
		trace(id, filename);
		// setup up highlight.js
		var link = document.createLinkElement();
		link.rel = 'stylesheet';
		link.href = '//cdnjs.cloudflare.com/ajax/libs/highlight.js/10.7.2/styles/default.min.css';
		document.body.appendChild(link);

		var link = document.createLinkElement();
		link.rel = 'stylesheet';
		link.href = 'https://cdnjs.cloudflare.com/ajax/libs/highlight.js/10.7.2/styles/monokai-sublime.min.css';
		document.body.appendChild(link);

		var script = document.createScriptElement();
		script.src = '//cdnjs.cloudflare.com/ajax/libs/highlight.js/10.7.2/highlight.min.js';
		document.body.appendChild(script);

		// Setup the component
		// Syntax.code('
		// var app = new MonkeeChain("#_{id}", {
		//     data: {
		//         js: "",
		//         code: "test"
		//     },
		//     template: function (data) {
		//         return `
		//         <div class="code-wrapper">
		//         <textarea id="input" style="position:fixed;top:-100px;">_{data.code}</textarea>
		//         <pre style="border-radius:4px;"><code class="js">_{data.js}</code></pre>
		//         <button class="btn" id="copy-code-btn">📋</button>

		//         </div>

		//         `;
		//     }
		// });
		// ');

		// setButton(); // first try

		// Fetch API data
		window.fetch('${filename}')
			.then(function(response) {
				return response.text();
			}).then(function(data) {
			console.log(data);
			// app.data.code = data;
			// app.data.js = data
			// 	.replaceAll('&', '&amp;')
			// 	.replaceAll('"', '&quot;')
			// 	.replaceAll('<', '&lt;')
			// 	.replaceAll('>', '&gt;');
			// app.render();
			// setTimeout(function() {
			// 	hljs.highlightAll();
			// 	setButton(); // second try
			// }, 500);
			});

		// function setButton() {
		// 	var btn = document.getElementById('copy-code-btn');
		// 	btn.classList.add('btn-light');
		// 	// console.log(btn);

		// 	var input = document.getElementById('input');
		// 	input.setAttribute('style', 'position:fixed;top:-100px;') // console.log(input);

		// 		// console.log(input.value);

		// 	btn.onclick = function(e) {
		// 		e.preventDefault();
		// 		input.select()
		// 		document.execCommand('copy');

		// 		// console.log('click');
		// 		window.alert('code is copied');

		// 		// var code = document.getElementById(`${id}`).querySelector('.hljs');
		// 		// console.log(code);
		// 		// code.classList.add('flash');
		// 	};
	};

	public static function escapeHTML(html:String) {
		// trace(html);
		return html
			.replace('&', '&amp;')
			.replace('"', '&quot;')
			.replace('<', '&lt;')
			.replace('>', '&gt;');
	}

	static public function main() {
		document.addEventListener('DOMContentLoaded', (event) -> {
			var app = new MonkeeUtil();
		});
	}
}
