package;

import js.Syntax;
import haxe.Json;
import js.lib.Function;
import js.html.SupportedType;
import js.html.DOMParser;
import js.lib.Error;
import js.html.Element;
import js.html.InputElement;
import haxe.extern.EitherType;
import js.Browser.*;

using StringTools;

import externs.MonkeeChain;

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

	public static function setLink(href:String) {
		var one = document.querySelector('[href="${href}"]');
		// trace(one);
		if (one == null) {
			// trace('XXXXXXXX');
			var link = document.createLinkElement();
			link.rel = 'stylesheet';
			link.href = '${href}';
			document.body.appendChild(link);
		}
	}

	public static function setScript(src:String) {
		var one = document.querySelector('[src="${src}"]');
		// trace(one);
		if (one == null) {
			var script = document.createScriptElement();
			script.src = src;
			document.body.appendChild(script);
		}
	}

	/**
	 * [Description]
	 * @param id
	 * @param filename
	 */
	public static function embedCode(id:String, filename:String) {
		console.info(App.callIn('MonkeeUtil :: embedCode'));
		// trace(id, filename);

		// setup up highlight.js
		setLink('//cdnjs.cloudflare.com/ajax/libs/highlight.js/10.7.2/styles/default.min.css');
		setLink('https://cdnjs.cloudflare.com/ajax/libs/highlight.js/10.7.2/styles/monokai-sublime.min.css');
		setScript('//cdnjs.cloudflare.com/ajax/libs/highlight.js/10.7.2/highlight.min.js');

		// Setup the component
		var app = new MonkeeChain('${id}', {
			data: {
				js: "",
				code: "test"
			},
			template: function(data) {
				return '
		        <div class="copy-code-wrapper-${id}" style="position:relative;">
		        <textarea id="copy-code-input-${id}" style="position:fixed;top:-100px;">${data.code}</textarea>
		        <pre style="border-radius:4px;"><code class="js">${data.js}</code></pre>
		        <button class="btn" id="copy-code-btn-${id}" style="position: absolute; top: 15px; right: 15px;">📋</button>
		        </div>
		        ';
			}
		});

		function setButton() {
			var wrapper:Element = document.getElementById('copy-code-wrapper-${id}');
			var btn = document.getElementById('copy-code-btn-${id}');
			btn.classList.add('btn-light');
			// console.log(btn);

			var input:InputElement = cast document.getElementById('copy-code-input-${id}');
			input.setAttribute('style', 'position:fixed;top:-100px;'); // console.log(input);

			// console.log(input.value);

			btn.onclick = function(e) {
				e.preventDefault();
				untyped input.select();
				document.execCommand('copy');

				// console.log('click');
				window.alert('Code is copied');

				// var code = document.getElementById(`${id}`).querySelector('.hljs');
				// console.log(code);
				// code.classList.add('flash');
			};
		};

		setButton(); // first try

		// Fetch API data
		window.fetch('${filename}')
			.then(function(response) {
				return response.text();
			})
			.then(function(data) {
				// console.log(data);
				app.data.code = data;
				app.data.js = escapeHTML(data);
				// .replace('&', '&amp;')
				// .replace('"', '&quot;')
				// .replace('<', '&lt;')
				// .replace('>', '&gt;');
				app.render();
				window.setTimeout(function() {
					untyped hljs.highlightAll();
					setButton(); // second try
				}, 500);
			});
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
