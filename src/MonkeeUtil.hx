package;

import utils.Sanitize;
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
	/**
	 * 0.0.6	version and debug
	 * 0.0.5 	mdTable2HTMLTable (WIP)
	 * 0.0.4 	setLink/setScript
	 * 0.0.3 	embedSpecs
	 * 0.0.12	embedCode
	 * 0.0.1 	initial, data-escape on dataload
	 */
	static inline var VERSION = '0.0.6';

	var DEBUG = #if debug true #else false #end;

	public function new() {
		console.info(App.callIn('Util', VERSION));
		init();
	}

	function init() {
		var all = document.querySelectorAll('[data-escape]');

		for (i in 0...all.length) {
			var el:Element = cast all[i];
			var html = el.getAttribute('data-escape');
			// el.innerHTML = (html);
			// el.innerText = MonkeeUtil.escapeHTML(html);
			el.innerHTML = Sanitize.escapeHTML(html);
		}
	}

	// ____________________________________ Monkee-Z ____________________________________

	/**
	 * Json generated info on `build-release`
	 *
	 * @example
	 * 			MonkeeUtil.mdTable2HTMLTable('#app', '../assets/json/monkee_load.md');
	 *
	 * @param id			element to parse Monkee-Z Chain code in
	 * @param filename		the file we want to use
	 */
	public static function mdTable2HTMLTable(id:String, filename:String) {
		console.info(App.callIn('Util :: embedSpecs', MonkeeUtil.VERSION));
		// Setup the component

		function createTable(arr:Array<Dynamic>):String {
			var html = '<table class="table table-striped table-sm">';
			for (i in 0...arr.length) {
				var row:Array<Dynamic> = arr[i];
				html += '<tr>';
				for (j in 0...row.length) {
					var col = row[j];
					html += '<td>${col}<td>';
				}
				html += '</tr>';
			}
			html += "<table>";
			return html;
		}

		var app_markdown = new MonkeeChain('${id}', {
			data: {
				md: "",
				arr: [],
			},
			template: function(props) {
				return '
	        		<div>${createTable(props.arr)}</div>
	        	';
			},
		});

		// Fetch API data
		window.fetch("../assets/md/monkee_load.md").then(function(response) {
			return response.text();
		}).then(function(data) {
			// console.log(data);
			var arr = [];
			var linesArr = data.split("\n");
			for (i in 0...linesArr.length) {
				var _linesArr = linesArr[i];
				trace(_linesArr);
				if (i == 1)
					continue;
				var line = linesArr[i];
				// console.log(line);
				var col = line.split(" | ");
				// console.log(col.length);
				if (col.length <= 1)
					continue;
				var tempColArr = [];
				for (j in 0...col.length) {
					var val = col[j].replace("| ", "").replace(" |", "").replace('', "");
					// console.log(val);
					tempColArr.push(val);
				}
				arr.push(tempColArr);
			}
			console.log(arr);
			app_markdown.data.md = data;
			app_markdown.data.arr = arr;
			app_markdown.render();
		});
	}

	/**
	 * Json generated info on `build-release`
	 *
	 * @example
	 * 			MonkeeUtil.embedSpecs('#app', '../assets/json/monkee_load.json');
	 *
	 * @param id			element to parse Monkee-Z Chain code in
	 * @param filename		the file we want to use
	 */
	public static function embedSpecs(id:String, filename:String) {
		console.info(App.callIn('Util :: embedSpecs', MonkeeUtil.VERSION));

		// Setup the component
		var app = new MonkeeChain('${id}', {
			data: {
				json: {
					name: "",
					updated: "",
					size: {
						minified: "",
						original: "",
						uglifyjs: "",
					},
					url: {
						minified: "",
						original: "",
						uglifyjs: "",
					},
				},
			},
			template: function(props) {
				return '
                    <div class="card">
            			<div class="card-body">
    						<strong>File ${props.json.name}:</strong>
    						<p class="text-muted">Updated: ${props.json.updated}</p>
    						<ul>
    							<li>Download original file: <a href="${props.json.url.original}">${props.json.name.replace('.js', '.js')}</a> (${props.json.size.original})</li>
    							<li>UglifyJs file size: <a href="${props.json.url.uglifyjs}">${props.json.name.replace('.js', '.min.js')}</a> (${props.json.size.uglifyjs})</li>
    							<li>Extra minified file size: <a href="${props.json.url.minified}">${props.json.name.replace('.js', '.min.min.js')}</a> (${props.json.size.minified})</li>
    						</ul>
    		    	    </div>
    			    </div>
                    ';
			}
		});

		// Fetch API data
		window.fetch('${filename}').then(function(response) {
			return response.json();
		}).then(function(data) {
			// console.log(data);
			app.data.json = data;
			app.render();
		});
	}

	/**
	 * Embed js code into page, and a copy button for easy copy/paste
	 *
	 * @example
	 * 			MonkeeUtil.embedCode('#app', 'test.js');
	 *
	 * @param id			element to parse Monkee-Z Chain code in
	 * @param filename		the file we want to use
	 */
	public static function embedCode(id:String, filename:String) {
		console.info(App.callIn('Util :: embedCode', MonkeeUtil.VERSION));
		// trace(id, filename);

		// setup up highlight.js
		setLink('//cdnjs.cloudflare.com/ajax/libs/highlight.js/10.7.2/styles/default.min.css');
		setLink('https://cdnjs.cloudflare.com/ajax/libs/highlight.js/10.7.2/styles/monokai-sublime.min.css');
		setScript('//cdnjs.cloudflare.com/ajax/libs/highlight.js/10.7.2/highlight.min.js');

		// Setup the component
		var app = new MonkeeChain('${id}', {
			data: {
				code: "test",
				codeEscaped: "",
				codeType: "js"
			},
			template: function(data) {
				return '
		        <div class="copy-code-wrapper-${id}" style="position:relative;" data-type="${data.codeType}">
		        <textarea id="copy-code-input-${id}" style="position:fixed;top:-100px;">${data.code}</textarea>
		        <pre style="border-radius:4px;"><code class="${data.codeType}">${data.codeEscaped}</code></pre>
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
				// replace tabs with spaces for easier reading
				var spaced = data.split('\t').join('  ');
				app.data.code = spaced;
				app.data.codeEscaped = utils.Sanitize.escapeHTML(spaced);
				app.data.codeType = filename.split('.')[filename.split('.').length - 1];

				app.render();
				window.setTimeout(function() {
					untyped hljs.highlightAll();
					setButton(); // second try
				}, 500);
			});
	};

	// ____________________________________ utils ____________________________________

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

	static public function main() {
		document.addEventListener('DOMContentLoaded', (event) -> {
			var app = new MonkeeUtil();
		});
	}
}
