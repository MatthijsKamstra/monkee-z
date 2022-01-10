package component;

import js.html.Element;
import js.html.DivElement;
import js.Browser.*;
import js.Browser.window;

using JQ;
using StringTools;

class Reveal {
	var DEBUG:Bool;
	var arr = [];
	var last_known_scroll_position = 0.0;
	var ticking = false;

	public function new(?isDebug:Bool = false) {
		DEBUG = isDebug;
		init();
	}

	function init() {
		var all = document.getElementsByClassName('container-reveal');

		// if there are no elements we don't start this script
		// make sure there is a reveal to work with
		if (all.length <= 0)
			return;

		if (DEBUG)
			console.log('${App.NAME} init :: Reveal');

		// first run, DOM is ready
		for (i in 0...all.length) {
			var el:Element = all[i];
			// set data in reveal element
			el.dataset.reveal = 'true';
			el.dataset.count = '${i}';
			el.dataset.revealName = 'reveal-name-' + i + '';
			el.dataset.revealHeight = '' + el.clientHeight + '';
			//	el.dataset.revealStringInfo = 'offsetTop: ${el.offsetTop}, offsetHeight: ${el.offsetHeight}, clientWidth: ${el.clientWidth}, clientHeight: ${el.clientHeight}';
			el.dataset.revealStringInfo = 'offsetTop: ${Std.int(el.offset().top)}, offsetLeft: ${Std.int(el.offset().left)}, offsetHeight: ${el.offsetHeight}, clientWidth: ${el.clientWidth}, clientHeight: ${el.clientHeight}';
			el.id = 'reveal-' + i + '';
			// console.log(el);
			createArray(el);
		}

		document.addEventListener('scroll', function(e) {
			last_known_scroll_position = window.scrollY;
			// use tick to dampen the calls
			if (!ticking) {
				window.requestAnimationFrame(function(e) {
					toggleReveal(last_known_scroll_position);
					ticking = false;
				});
				ticking = true;
			}
		});
	}

	function toggleReveal(scroll_pos:Float):Void {
		// Do something with the scroll position
		for (i in 0...arr.length) {
			var obj = arr[i];

			var viewH = window.innerHeight;
			var paddingTop = (viewH - obj.clientHeight) / 2;
			var triggerPos = obj.offsetTop;

			if (DEBUG) {
				obj.debugScroll.innerHTML = '${Std.int(scroll_pos)}|${obj.offsetTop}';
			}

			// trace(triggerPos, obj);

			if (scroll_pos >= triggerPos - paddingTop && !obj.el.classList.contains('open')) {
				// trace('should only be called once');
				// obj.isOpen = true; // set data to open.. just for debugging
				// Syntax.code("$(obj.el).toggleClass('open');");
				obj.el.classList.add('open');
			}
		}
	}

	function createArray(el:Element) {
		var i = Std.parseInt(el.dataset.count);
		var obj:RevealObj = {
			_id: '$i',
			el: el,
			offsetTop: Std.int(el.offset().top),
			offsetLeft: Std.int(el.offset().left),
			offsetHeight: el.offsetHeight,
			clientWidth: el.clientWidth,
			clientHeight: el.clientHeight,
			isOpen: false
		}
		arr[i] = (obj);

		debugViewPort(obj);
		debugScroll(obj);
	}

	// ____________________________________ debugging ____________________________________

	function debugViewPort(obj:RevealObj) {
		if (DEBUG) {
			var div:DivElement = document.createDivElement();
			// check if its set before, use that one instead
			if (document.getElementById('reveal-debug-viewport-${obj._id}') != null) {
				div = cast document.getElementById('reveal-debug-viewport-${obj._id}');
			}
			div.className = 'debug-viewport';
			div.id = 'reveal-debug-viewport-${obj._id}';
			div.style.top = '${obj.offsetTop}px';
			div.style.left = '10px';
			div.style.width = '${document.body.clientWidth - 20 - 2}px';
			div.style.height = '${obj.offsetHeight - 0}px';
			document.body.appendChild(div);

			obj.debugViewPort = div;
		}
	}

	function debugScroll(obj:RevealObj) {
		if (DEBUG) {
			var div:DivElement = document.createDivElement();
			// check if its set before, use that one instead
			if (document.getElementById('debug-scroll-${obj._id}') != null) {
				div = cast document.getElementById('debug-scroll-${obj._id}');
			}
			div.className = 'debug-scroll';
			div.id = 'debug-scroll-${obj._id}';
			div.innerHTML = '0|${obj.offsetTop}';
			document.body.appendChild(div);

			obj.debugScroll = div;
		}
	}
}

typedef RevealObj = {
	@:optional var _id:String;
	var el:Element;
	var offsetTop:Int;
	var offsetLeft:Int;
	var offsetHeight:Float;
	var clientWidth:Float;
	var clientHeight:Float;
	var isOpen:Bool;
	@:optional var debugViewPort:Element;
	@:optional var debugScroll:Element;
}
