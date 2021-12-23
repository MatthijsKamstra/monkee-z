package;

import js.Browser.*;
import js.html.Element;
import js.html.ImageElement;
import js.html.LinkElement;
import js.html.URLSearchParams;
import js.html.XMLHttpRequest;

using StringTools;

/**
 * simple way to replace missing images
 * add querystring '?monkeewrench' to url (example: http://localhost:8888/?monkeewrench)
 */
@:expose
@:keep
class MonkeeWrenchLite {
	/**
	 * 0.0.7	remove listener after first trigger
	 * 0.0.6	minify
	 * 0.0.5	cleaning up
	 * 0.0.4 	href == null?
	 * 0.0.3 	lite/async
	 * 0.0.2 	absolute images paths
	 * 0.0.1 	initial
	 */
	static inline var VERSION = '0.0.7';

	static inline final DEBUG = #if debug true #else false #end;

	final DEBUG_IMAGES = [
		'https://matthijskamstra.github.io/monkee-z/assets/img/debug/146-500x500.jpg',
		'https://matthijskamstra.github.io/monkee-z/assets/img/debug/500x500.jpg'
	];

	public function new() {
		// console.info(App.callIn('Wrench-Lite ${utils.Emoji.monkeeWrench}', VERSION));
		document.addEventListener("DOMContentLoaded", function(event) {
			console.groupCollapsed('${utils.Emoji.monkeeWrench} Monkee-Wrench-Lite - v${VERSION}');
			console.log('Monkee Wrench Lite is a JavaScript tool to replace missing (background)images, and show broken links');
			console.log('Use by focussing the browser and press "m"');
			console.log('Or use ${window.location.href}?monkeewrench');
			console.log('WIP documentation https://matthijskamstra.github.io/monkee-z/wrench/');
			console.groupEnd();
			init();
		});
	}

	/**
	 * Set up key listener, and check if we can start checking page
	 */
	function init() {
		window.onkeydown = (e) -> getkey(e);

		var urlParams = new URLSearchParams(window.location.search);
		var myParam = urlParams.get('monkeewrench');

		if (myParam != null)
			validateElementsOnPage();
	}

	/**
	 * Listen to `m`
	 * @param e
	 */
	function getkey(e) {
		// console.log(e);
		if (e.key == 'm') {
			// console.info('${utils.Emoji.monkeeWrench} Start checking document');
			validateElementsOnPage();
			window.onkeydown = null; // remove listener
		}
	}

	function validateElementsOnPage() {
		// <video autoplay="" muted="" loop="" playsinline="" poster="/content/homepage/BPFD_home_still.jpeg" width="100%">
		// <source type="video/mp4" src="/content/videos/BPFD_home_animation.mp4">

		// <div class="bg__image" style="background-image: url(/content/homepage/Home_table_Stocksy_txpa94ad9e7aIv200_Small_2907611.jpg)"></div>

		// <img class="d-block w-100" src="/content/homepage/Home_carroussel_Fotograaf-Lize-Kraan.jpg" alt="image in carousel">

		// check all images
		var elementsImg = document.getElementsByTagName("img");
		for (i in 0...elementsImg.length) {
			var el:ImageElement = cast elementsImg[i];
			// var url = el.src;
			isUrlValid(el.src, setImage, [el]);
		}

		// check all elements for background images
		var elementsWithBG = document.getElementsByTagName("*");
		for (i in 0...elementsWithBG.length) {
			var el:Element = cast elementsWithBG[i];
			var url = el.style.backgroundImage.replace('\'', '').replace('\"', '').replace('url(', "").replace(')', '');

			// if (el.style.backgroundImage != "") {
			// 	// el.dataset.monkeeWrenchCheck = 'true';
			// }

			isUrlValid(url, setBgImage, [el]);
		}

		// check all links
		var elementsLinks = document.getElementsByTagName("a");
		for (i in 0...elementsLinks.length) {
			var el:LinkElement = cast elementsLinks[i];
			// el.dataset.monkeeWrenchCheck = 'true';
			// var url = el.href;
			var href = el.getAttribute('href');
			if (href == '' || href == '#' || href == null) {
				// el.dataset.monkeeWrenchEmptyLink = 'true';
				el.innerHTML = '${utils.Emoji.monkeeWrench} ${el.innerHTML}';
			} else if (href.startsWith('/') || href.indexOf(window.location.host) != -1) {
				isUrlValid(el.href, setXEmoji, [el]);
			}
		}

		// console.info('${utils.Emoji.monkeeWrench} Done checking document');
	}

	/**
	 * [Description]
	 * @param url
	 * @param cb
	 * @param arr
	 */
	function isUrlValid(url:String, cb, arr:Array<Dynamic>) {
		var request = new js.html.XMLHttpRequest();
		request.open('GET', url, true);
		request.onload = function() {
			if (request.status >= 400) {
				Reflect.callMethod(this, cb, arr);
			}
		};
		request.send();
	}

	function setXEmoji(el:Element) {
		el.innerHTML = '${utils.Emoji.x} ${el.innerHTML}';
	}

	function setBgImage(el:Element) {
		el.style.backgroundImage = 'url(${DEBUG_IMAGES[1]})';
	}

	function setImage(el:ImageElement) {
		var w:Int = el.width;
		var h:Int = el.height;

		el.src = DEBUG_IMAGES[0];

		if (el.getAttribute('width') != null && el.getAttribute('height') != null) {
			el.style.width = '${w}px';
			el.style.display = 'block';
			el.style.width = '500px';
			el.style.height = '250px';
			el.style.objectFit = 'cover';

			// calculate new image height
			el.style.height = '${Math.round(el.width * (h / w))}px';
		}
	}

	static public function main() {
		var app = new MonkeeWrenchLite();
	}
}
