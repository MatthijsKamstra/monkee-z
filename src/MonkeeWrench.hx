package;

import js.html.DivElement;
import haxe.Constraints.Function;
import utils.Emoji;
import js.html.LinkElement;
import js.html.Element;
import js.html.VideoElement;
import js.html.ImageElement;
import js.html.URLSearchParams;
import js.html.XMLHttpRequest;
import js.Browser.*;

using StringTools;

/**
 * simple way to replace missing images
 * add querystring '?monkeewrench' to url (example: http://localhost:8888/?monkeewrench)
 */
@:expose
@:keep
class MonkeeWrench {
	/**
	 * 0.0.5 	visual fix for "content security policy" not loading image via gradient
	 * 0.0.4 	stop when href has javascript/mailto/tel, remove lite from description
	 * 0.0.3 	sync with lite, snackbar added, href == null
	 * 0.0.2 	absolute images paths
	 * 0.0.1 	initial
	 */
	static inline var VERSION = '0.0.5';

	static inline final DEBUG = #if debug true #else false #end;

	final DEBUG_IMAGES = [
		'https://matthijskamstra.github.io/monkee-z/assets/img/debug/146-500x500.jpg',
		'https://matthijskamstra.github.io/monkee-z/assets/img/debug/500x500.jpg',
		'https://matthijskamstra.github.io/monkee-z/assets/img/debug/1031-500x500.jpg'
	];

	final ROOT = window.location.host;

	var snackbar:DivElement;

	public function new() {
		// console.info(App.callIn('Wrench ${utils.Emoji.monkeeWrench}', VERSION));

		// console.log(ROOT);

		document.addEventListener("DOMContentLoaded", function(event) {
			console.groupCollapsed('${utils.Emoji.monkeeWrench} Monkee-Wrench - v${VERSION}');
			console.log('Monkee Wrench is a JavaScript tool to replace missing (background)images, and show broken links');
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

		buildSnackbar();

		if (myParam != null) {
			buildIcon();
			validateElementsOnPage();
			window.onkeydown = null; // remove listener
		}
	}

	/**
	 * Listen to `m`
	 * @param e
	 */
	function getkey(e) {
		// console.log(e);
		if (e.key == 'm') {
			buildIcon();
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

		snackbarInfo('Checking images');

		for (i in 0...elementsImg.length) {
			snackbarInfo('Check image ' + i);

			var el:ImageElement = cast elementsImg[i];
			var url = el.src;
			var w = el.width;
			var h = el.height;
			if (!UrlExists(url)) {
				// image doesn't exists

				snackbarInfo('Replacing image: ' + url);

				// https://picsum.photos/500/500
				el.dataset.monkeeWrenchImageReplace = 'true';
				el.src = DEBUG_IMAGES[0];
				addImageLabel(el);

				if (el.getAttribute('width') != null && el.getAttribute('height') != null) {
					el.style.width = '${w}px';
					el.style.display = 'block';
					el.style.width = '500px';
					el.style.height = '250px';
					el.style.objectFit = 'cover';

					// calculate new image height

					// el.height = Math.round(h * (h / w));
					el.style.height = '${Math.round(el.width * (h / w))}px';
				}
			}
		}

		// check all elements for background images
		var elementsWithBG = document.getElementsByTagName("*");
		snackbarInfo('Checking background-images');
		for (i in 0...elementsWithBG.length) {
			var element:Element = cast elementsWithBG[i];
			var url = element.style.backgroundImage.replace('\'', '').replace('\"', '').replace('url(', "").replace(')', '');
			if (element.style.backgroundImage != "") {
				snackbarInfo('Check background-image ' + i);
				element.dataset.monkeeWrenchCheck = 'true';
				// element.style.background = "#f953c6";
			}
			// if (element.style.backgroundImage != "") {
			// 	console.log(element.style.backgroundImage);
			// 	console.log(url);
			// 	console.log('-------------' + UrlExists(url));
			// }
			// try {
			if (!UrlExists(url)) {
				// console.log('xxx');
				snackbarInfo('Replacing background-image: ' + url);

				element.dataset.monkeeWrenchCheck = 'true';
				element.dataset.monkeeWrenchBgImageReplace = 'true';
				element.style.background = "#f953c6";
				element.style.backgroundImage = "linear-gradient(to right, #b91d73, #f953c6)";
				element.style.backgroundImage = 'url(${DEBUG_IMAGES[1]})';
				addBGImageLabel(element);
			}
			// } catch (e) {
			// 	trace(e);
			// }
		}

		// check all video `<video>`
		var elementsVideo = document.getElementsByTagName("video");
		snackbarInfo('Checking video');
		for (i in 0...elementsVideo.length) {
			var element:VideoElement = cast elementsVideo[i];
			element.dataset.monkeeWrenchCheck = 'true';
			var url = element.poster;
			// console.log(url);
			if (!UrlExists(url)) {
				snackbarInfo('Replacing video: ' + url);
				// https://picsum.photos/500/500
				element.dataset.monkeeWrenchPosterImageReplace = 'true';
				element.poster = DEBUG_IMAGES[2];
			}
		}
		// check all links `<a>`
		var elementsLinks = document.getElementsByTagName("a");
		snackbarInfo('Checking links');
		for (i in 0...elementsLinks.length) {
			var el:LinkElement = cast elementsLinks[i];
			el.dataset.monkeeWrenchCheck = 'true';
			var url = el.href;
			var href = el.getAttribute('href');
			var id = el.id;
			if (el.getAttribute('name') != null)
				continue;
			// console.log(url);
			if (href == '' || href == '#' || href == null) {
				snackbarInfo('Checking empty links');
				el.dataset.monkeWrenchEmptyLink = 'true';
				el.innerHTML = '${utils.Emoji.monkeeWrench} ${el.innerHTML}';
			}
			if (href == null || href.indexOf('javascript') != -1 || href.indexOf('mailto:') != -1 || href.indexOf('tel:') != -1) {
				// trace('ignore this href: ' + href);
				continue;
			}
			if (href.startsWith('/') || href.indexOf(ROOT) != -1) {
				if (!UrlExists(url)) {
					snackbarInfo('Checking dead links ' + url);
					// https://picsum.photos/500/500
					el.dataset.monkeeWrenchDeadlink = 'true';
					el.innerHTML = '${utils.Emoji.x} ${el.innerHTML}';
				}
			}
		}

		// var video = document.querySelectorAll('video')[0];
		// if (video != null) {
		// 	// console.log(video);
		// 	var source = video.querySelectorAll('source')[0];
		// 	// console.log(source);
		// 	source.src = 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4';
		// }

		isSnackbarVisible(false);
	}

	// ____________________________________ snackbar ____________________________________

	function buildSnackbar() {
		snackbar = cast document.createElement('div');
		snackbar.innerHTML = "some text";
		snackbar.id = 'snackbar';
		snackbar.setAttribute('style',
			'visibility: hidden;min-width: 250px;transform: translate(-50%,0);background-color: #333;color: #fff;text-align: center;border-radius: 2px;padding: 16px; position: fixed;z-index: 1;left: 50%;bottom: 30px;');
		document.body.appendChild(snackbar);
	}

	function snackbarInfo(msg:String) {
		isSnackbarVisible(true);
		snackbar.innerHTML = msg;
	}

	function isSnackbarVisible(isVisible:Bool = true) {
		if (isVisible) {
			snackbar.style.visibility = 'visible';
		} else {
			snackbar.style.visibility = 'hidden';
		}

		// snackbar.classList.add("show");

		// // After 3 seconds, remove the show class from DIV
		// window.setTimeout(function() {
		// 	snackbar.classList.remove('show');
		// }, 3000);
	}

	// ____________________________________ builds ____________________________________

	function buildIcon() {
		var btn = document.createElement('div');
		btn.innerHTML = '${utils.Emoji.monkeeWrench}';
		btn.className = 'btn btn-outline-dark';
		btn.title = 'Monkee Wrench is used';
		btn.setAttribute('style', 'position: fixed;bottom: 10px;left: 10px;');
		btn.onclick = () -> validateElementsOnPage();
		document.body.appendChild(btn);
	}

	function addImageLabel(el:Element) {
		var div = document.createDivElement();
		div.innerHTML = '${Emoji.monkeeWrench} img';
		div.style.position = 'absolute';
		// div.style.top = '0px';
		// div.style.left = '0px';
		div.style.bottom = '0px';
		div.style.right = '50%';
		div.style.backgroundColor = 'yellow';
		div.style.fontSize = '8px';
		div.style.padding = '0px';
		div.style.paddingLeft = '5px';
		div.style.paddingRight = '5px';
		div.style.textTransform = 'uppercase';
		div.style.transform = 'translate(50%)';
		div.style.borderRadius = '1px';
		div.style.opacity = '0.5';
		el.parentElement.appendChild(div);
		// el.style.position = 'relative';
	}

	function addBGImageLabel(el:Element) {
		var div = document.createDivElement();
		div.innerHTML = '${Emoji.monkeeWrench} bg-img';
		div.style.position = 'absolute';
		// div.style.top = '0px';
		// div.style.left = '0px';
		div.style.bottom = '0px';
		div.style.right = '50%';
		div.style.backgroundColor = 'yellow';
		div.style.fontSize = '8px';
		div.style.padding = '0px';
		div.style.paddingLeft = '5px';
		div.style.paddingRight = '5px';
		div.style.textTransform = 'uppercase';
		div.style.transform = 'translate(50%)';
		div.style.borderRadius = '1px';
		div.style.opacity = '0.5';
		el.appendChild(div);
		el.style.position = 'relative';
	}

	/**
	 * Synchronous XMLHttpRequest on the main thread is deprecated because of its detrimental effects to the end user???s experience. For more help http://xhr.spec.whatwg.org/
	 * @param url
	 */
	function UrlExists(url) {
		var http = new XMLHttpRequest();
		http.open('HEAD', url, false);
		http.send();
		// console.log(http.status);
		return http.status != 404;
	}

	/**
	 * [Description]
	 * @param url
	 * @param cb
	 * @param arr
	 */
	function isUrlValid(url, cb:js.lib.Function) {
		var request = new js.html.XMLHttpRequest();
		request.open('GET', url, true);

		request.onload = function() {
			if (request.status >= 200 && request.status < 400) {
				// Success!
				var json = request.responseText;
				trace("json: " + json);

				cb.apply(this, []);
			} else {
				// We reached our target server, but it returned an error
				trace("oeps: status: " + request.status + " // json: " + request.responseText);
			}
		};

		request.onerror = function() {
			// There was a connection error of some sort
			trace("error");
		};

		request.send();
	}

	static public function main() {
		var app = new MonkeeWrench();
	}
}
