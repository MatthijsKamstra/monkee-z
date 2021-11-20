package;

import js.Syntax;
import haxe.Timer;
import js.html.svg.Element;
import js.Lib;
import js.Browser.*;
import js.html.*;

using StringTools;

// https://ficons.fiction.com/reference.html
class MonkeeFullpage {
	/**
	 * 0.0.1 	initial (wip)
	 */
	static inline var VERSION = '0.0.1';

	var DEBUG = #if debug true #else false #end;

	var colors = [
		'#7fdbff', '#39cccc', '#3d9970', '#2ecc40', '#01ff70', '#ffdc00', '#ff851b', '#ff4136', '#f012be', '#b10dc9', '#85144b', '#ffffff', '#dddddd',
		'#aaaaaa', '#111111', '#001f3f', '#0074d9',
	];

	var linkArray = [];
	var isVertical = true;
	var slideHeight:Int = 0;
	var scrolltracker = document.getElementById('js-scroll-tracker');

	var currentPos = 0.0;
	var previousPos = 0.0;
	var dirPos = 0;
	var timer = null;
	var map = new Map<Int, String>();

	public function new() {
		console.info(App.callIn('Fullpage ${utils.Emoji.monkeeFullpage}', VERSION));

		document.addEventListener('DOMContentLoaded', (event) -> {
			setupStyle();
			init();
			// initToggle();
			// Timer.delay(function() {
			// 	getData();
			// }, 1000);
		});
	}

	function getData() {
		var ul:Element = cast document.querySelector('[monkee-fullpage-slides]');
		ul.classList.add('monkee-fullpage-list');

		// slides
		var lis = ul.getElementsByTagName('li');
		// trace(lis[0].scrollHeight);
		slideHeight = Math.floor(lis[0].scrollHeight);

		map = [];
		// set up break points slides
		for (i in 0...lis.length) {
			// slide
			var li:LIElement = cast lis[i];
			// trace(li);
			// trace(li.scrollHeight);
			var t:Int = Math.floor((i * slideHeight) + (slideHeight * 0.5));
			map.set(t, li.id);
		}

		console.warn(map);
	}

	function init() {
		var ul:Element = cast document.querySelector('[monkee-fullpage-slides]');
		ul.classList.add('monkee-fullpage-list');
		ul.onscroll = onScrollHandler;

		// slides
		var lis = ul.getElementsByTagName('li');
		for (i in 0...lis.length) {
			// slide
			var li = lis[i];

			if (i == 0) {
				// only listen to the first element (the rest has the same size)
				var resizeObserver = Syntax.construct('ResizeObserver', () -> {
					// console.log("The element was resized");
					getData();
				});
				resizeObserver.observe(li);
			}

			// Syntax.construct('foo', 'app');
			// styling
			li.classList.add('monkee-fullpage-slide');
			if (DEBUG)
				li.setAttribute('style', 'background-color: ${colors[i]}');
		}

		var links = document.getElementsByTagName('a');
		var first = false;
		for (i in 0...links.length) {
			var link:LinkElement = cast links[i];
			// trace(link.getAttribute('href').charAt(0));
			if (link.getAttribute('href').charAt(0) == '#' && link.getAttribute('href').length > 1) {
				if (first == false) {
					link.classList.add('active');
				}
				// trace("link: " + link.getAttribute('href'));
				// console.log('<li id="${link.getAttribute('href').replace('#', '')}">${link.getAttribute('href')}</li>');
				linkArray.push(link);

				link.onclick = onclickHandler;
				first = true;
			}
		}
	}

	function onScrollStop() {
		console.group('stopped scrolling');
		// if (currentPos >= (slideHeight * 0.5)) {
		// 	trace('next');
		// }

		var gotoKey:Int = 0;
		var id:String = '';

		for (key in map.keys()) {
			// your code
			if (currentPos >= key) {
				console.log('dirPos: ${dirPos} ');
				console.log('currentPos: ${currentPos} ');
				console.log('key: ${key} // ${map[key]}');
				var prevKey = (key - slideHeight);
				var nextKey = (key + slideHeight);
				if (prevKey < 0)
					prevKey = Math.floor(slideHeight * 0.5);
				console.log('prevKey: ${prevKey} // ${map[prevKey]]}');
				console.log('nextKey: ${nextKey} // ${map[nextKey]}');
				console.log('>> scroll to');
				if (dirPos > 0) {
					console.log('next-id: ${map[nextKey]}');
					gotoKey = nextKey;
					id = map[nextKey];
				} else {
					console.log('next-id: ${map[prevKey]]}');
					gotoKey = prevKey;
					id = map[prevKey];
				}
				console.log('-------');
				// break;
			}
		}
		console.groupEnd();

		// var ul:Element = cast document.querySelector('[monkee-fullpage-slides]');
		// ul.scrollTo(map.get(gotoKey));
		// ul.scrollTo();

		// trace(map.get(gotoKey));
		document.getElementById(id).scrollIntoView();
	}

	function onScrollHandler(e:MouseScrollEvent) {
		// scrolltracker.innerHTML = '${untyped e.currentTarget.scrollTop}';
		if (timer != null) {
			window.clearTimeout(timer);
		}
		timer = window.setTimeout(function() {
			// do something
			onScrollStop();
		}, 150);

		currentPos = untyped e.currentTarget.scrollTop;

		if (currentPos > previousPos) {
			dirPos = 1;
		} else {
			dirPos = -1;
		}

		// trace(dirPos);

		previousPos = currentPos;
		// trace(untyped e.currentTarget.scrollTop);
		// document.getElementById('showScroll').innerHTML = window.pageYOffset + 'px';
	}

	/**
		// horizontal
		.monkee-fullpage-list {
			display: block ruby;
		}
		// vertical
		.monkee-fullpage-list {
			display: block;
		}
		*
	 */
	function initToggle() {
		var btn = document.getElementById('btn-toggle-dir');
		btn.onclick = (e) -> {
			var ul:Element = cast document.querySelector('[monkee-fullpage]');
			// trace("e: " + e);
			if (isVertical) {
				isVertical = false;
				Lib.nativeThis.innerHTML = '<i class="fa fa-arrows-v" aria-hidden="true"></i>';
				ul.classList.add('monkee-fullpage-list-horizontal');
			} else {
				isVertical = true;
				Lib.nativeThis.innerHTML = '<i class="fa fa-arrows-h" aria-hidden="true"></i>';
				ul.classList.remove('monkee-fullpage-list-horizontal');
			}
		}
	}

	function onclickHandler(e:Event):Void {
		// e.preventDefault();
		for (i in 0...linkArray.length) {
			var link:LinkElement = cast linkArray[i];
			link.classList.remove('active');
		}
		untyped e.currentTarget.classList.add('active');
		// trace(e);
	}

	function setupStyle() {
		var style = document.createElement('style');
		style.innerHTML = '

.monkee-fullpage-list {
  display: inline-block;
  margin: 0;
  padding: 0;
  width: 100%;
  height: 100%;
  list-style-type: none;
  overflow: auto;
  scroll-behavior: smooth;
}
.monkee-fullpage-list-horizontal {
  display: block ruby;
}
.monkee-fullpage-slide {
  border: 0px solid pink;
  width: 100%;
  height: 100%;
  display: inline-flex;
  align-items: center;
  justify-content: center;
}
  ';

		document.head.appendChild(style);

		// trace('injectStyle');
	}

	static public function main() {
		var app = new MonkeeFullpage();
	}
}
