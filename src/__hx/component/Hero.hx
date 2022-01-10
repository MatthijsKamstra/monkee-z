package component;

import js.html.HTMLCollection;
import js.html.Image;
import js.html.Element;
import js.html.DivElement;
import js.Browser.*;
import js.Browser.window;

using JQ;
using StringTools;

class Hero {
	var DEBUG:Bool;
	var arr = [];

	public function new(?isDebug:Bool = false) {
		DEBUG = isDebug;
		init();
	}

	function init() {
		var container:DivElement = cast document.getElementById('exhibition-hero');

		// make sure there is a HERO to work with
		if (container == null)
			return;
		if (DEBUG)
			console.log('${App.NAME} init :: Hero');

		// trace(container.style.backgroundImage);
		var ereg = ~/^url|[\(""\)]/g;
		var url = ereg.replace(container.style.backgroundImage, "");

		if (DEBUG)
			console.log(url);

		var bottom = container.offset().top + container.clientHeight;
		var viewH = container.innerHeight();

		// trace(bottom, viewH);

		var newW, newH, imgW, imgH, scale = 0.0;

		// size image
		var img = new Image();
		img.src = url;
		img.onload = function() {
			imgW = img.width;
			imgH = img.height;

			if (this.DEBUG)
				console.log('imgW: ' + imgW + ', imgH: ' + imgH);

			if (imgW > imgH) {
				if (DEBUG)
					console.log('imgW > imgH');
				newW = container.width();
				newH = imgH / imgW * newW;
				scale = newH / imgH;
			} else {
				if (DEBUG)
					console.log('imgW < imgH');
				newH = container.height();
				newW = imgW / imgH * newH;
				scale = newW / imgW;
			}
			if (newH < viewH) {
				if (DEBUG)
					console.log('newH < viewH');
				newH = container.height();
				newW = imgW / imgH * newH;
				scale = newH / imgH;
			}
			if (DEBUG)
				console.log('w: ' + newW + ', h: ' + newH + ', scale: ' + scale);

			// container.css('background-size', newW + 'px ' + newH + 'px');
			container.style.backgroundSize = newW + 'px ' + newH + 'px';
		}

		// call to action
		var exclude:HTMLCollection = document.getElementsByClassName('container-sub-nav'); // just need to know if the cta is scrolling
		var isCtaScroll = true;
		if (exclude.length > 0)
			isCtaScroll = false;

		var cta = document.getElementsByClassName('cta-wrapper').first();
		if (DEBUG)
			console.log(cta);

		window.onscroll = () -> {
			var scrollCurrent = document.documentElement.scrollTop;
			if (scrollCurrent >= bottom) {
				// if (DEBUG)
				// 	console.log('past bottom (${scrollCurrent}|${bottom})');
				return;
			}

			container.style.backgroundSize = (newW + scrollCurrent) + 'px ' + (newH + scrollCurrent) + 'px';

			if (isCtaScroll)
				cta.style.marginTop = (-200 - (scrollCurrent * 0.3)) + 'px';

			// el.css('background-size', (newW + scrollCurrent) + 'px ' + (newH + scrollCurrent) + 'px');
			// cta.css('margin-top', (-200 - (scrollCurrent * 0.3)) + 'px')
		}
	}
}
