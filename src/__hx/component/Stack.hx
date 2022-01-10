package component;

import js.html.HTMLCollection;
import js.html.Event;
import js.html.Element;
import js.html.DivElement;
import js.Browser.*;
import js.Browser.window;

using JQ;
using StringTools;

class Stack {
	var DEBUG:Bool;
	var counter = 0;
	var arr:HTMLCollection;
	var bottomElTop = .0;
	var bottomElBottom = .0;
	var bottomElLeft = .0;

	public function new(?isDebug:Bool = false) {
		DEBUG = isDebug;
		init();
	}

	function init() {
		var container = document.getElementById('stack');
		// make sure there is a stack to work with
		if (container == null)
			return;
		if (DEBUG)
			console.log('${App.NAME} init :: Stack');

		// get wrappers
		var div = document.getElementById('container-photos');
		arr = div.getElementsByClassName('photo-item');

		// Syntax.code('// data that needs to be recalculated');
		bottomElTop = container.offsetTop;
		bottomElBottom = container.offsetTop + container.offsetHeight;
		bottomElLeft = container.offsetLeft;
		// console.log(bottomElTop, bottomElLeft);

		// setup photoItem elemens
		for (i in 0...arr.length) {
			var photoItem:DivElement = cast arr[i];
			// change index? style='z-index: ${i-(arr.length-1)}'
			photoItem.dataset.index = '${i}';
			// click image and go to next image
			photoItem.onclick = function() {
				nextSlideHandler(photoItem);
			}
		}

		// setup button
		var btn = container.getElementsByClassName('stack__btn')[0]; // asume there is only one btn in this container
		btn.onclick = function(e:Event) {
			e.preventDefault();
			nextSlideHandler();
		}

		// help with debugging
		if (DEBUG) {
			var div:DivElement = document.createDivElement();
			// check if its set before, use that one instead
			if (document.getElementById('stack-debug-viewport') != null) {
				div = cast document.getElementById('stack-debug-viewport');
			}
			div.className = 'debug-viewport';
			div.id = 'stack-debug-viewport';
			div.style.top = '${bottomElBottom + 20}px';
			div.style.left = '10px';
			div.style.width = '${document.body.clientWidth - 20 - 2}px';
			div.style.height = '1px';
			document.body.appendChild(div);
		}
	}

	// what to do with next slide
	function nextSlideHandler(?photoItem:Element) {
		// trace('nextSlideHandler ${photoItem}');
		// console.log(photoItem);

		// use button, no photoItem, so use counter
		if (photoItem == null)
			photoItem = arr[(arr.length - 1) - counter];

		// check first image
		if (photoItem == arr[arr.length - 1]) {
			if (DEBUG)
				console.log('first?');
		}

		// check last image
		if (photoItem == arr[0]) {
			if (DEBUG) {
				console.log('last?');
				console.log('should move on');
			}

			counter = 0; // reset counter

			// scroll to bottom container
			window.scrollTo(untyped {
				top: bottomElBottom + 20,
				// left: bottomElLeft,
				behavior: 'smooth'
			});

			// reset all images
			for (i in 0...arr.length) {
				var photoItem:DivElement = cast arr[i];
				photoItem.classList.remove('activated');
			}

			return;
		}
		if (DEBUG)
			console.log(photoItem.dataset.index);

		photoItem.classList.add('activated');
		counter++;
	}
}
