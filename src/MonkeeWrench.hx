package;

import utils.Emoji;
import js.html.Headers;
import haxe.macro.Expr.Catch;
import js.html.LinkElement;
import js.html.Element;
import haxe.Log;
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
	 * 0.0.1 	initial
	 */
	static inline var VERSION = '0.0.1';

	var DEBUG = #if debug true #else false #end;

	public function new() {
		console.info(App.callIn('Wrench ${utils.Emoji.monkeeWrench}', VERSION));

		document.addEventListener("DOMContentLoaded", function(event) {
			console.group('Monkee ${utils.Emoji.monkeeWrench}');
			console.log('focus browser and press "m"');
			console.log('or use ${window.location.href}?monkeewrench');
			console.groupEnd();

			init();
		});
	}

	/**
	 * Synchronous XMLHttpRequest on the main thread is deprecated because of its detrimental effects to the end user’s experience. For more help http://xhr.spec.whatwg.org/
	 * @param url
	 */
	function UrlExists(url) {
		var http = new XMLHttpRequest();
		http.open('HEAD', url, false);
		http.send();
		// console.log(http.status);
		return http.status != 404;
	}

	function getkey(e) {
		// console.log(e);
		if (e.key == 'm') {
			buildIcon();
			replaceMissingAssets();
		}
	}

	function buildIcon() {
		var btn = document.createElement('div');
		btn.innerHTML = '${utils.Emoji.monkeeWrench}';
		btn.className = 'btn btn-outline-dark';
		btn.title = 'Monkee Wrench is used';
		btn.setAttribute('style', 'position: fixed;bottom: 10px;left: 10px;');
		btn.onclick = () -> replaceMissingAssets();
		document.body.appendChild(btn);
	}

	function init() {
		window.onkeydown = (e) -> getkey(e);

		var urlParams = new URLSearchParams(window.location.search);
		var myParam = urlParams.get('monkeewrench');

		if (myParam != null) {
			buildIcon();
			replaceMissingAssets();
		}
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
		el.style.position = 'relative';
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

	function replaceMissingAssets() {
		// <video autoplay="" muted="" loop="" playsinline="" poster="/content/homepage/BPFD_home_still.jpeg" width="100%">
		// <source type="video/mp4" src="/content/videos/BPFD_home_animation.mp4">

		// <div class="bg__image" style="background-image: url(/content/homepage/Home_table_Stocksy_txpa94ad9e7aIv200_Small_2907611.jpg)"></div>

		// <img class="d-block w-100" src="/content/homepage/Home_carroussel_Fotograaf-Lize-Kraan.jpg" alt="image in carousel">

		// check all images
		var elementsImg = document.getElementsByTagName("img");
		for (i in 0...elementsImg.length) {
			var element:ImageElement = cast elementsImg[i];
			var url = element.src;
			// console.log(url);
			// console.log(UrlExists(url));
			if (!UrlExists(url)) {
				// console.log('xxxx');
				// https://picsum.photos/500/500
				element.dataset.monkeeWrenchImageReplace = 'true';
				element.src = '../assets/img/debug/1031-500x500.jpg';
				addImageLabel(element);
			}
		}

		// check all elements for background images
		var elementsWithBG = document.getElementsByTagName("*");
		for (i in 0...elementsWithBG.length) {
			var element:Element = cast elementsWithBG[i];
			var url = element.style.backgroundImage.replace('\'', '').replace('\"', '').replace('url(', "").replace(')', '');
			if (element.style.backgroundImage != "") {
				element.dataset.monkeeWrenchCheck = 'true';
			}
			// if (element.style.backgroundImage != "") {
			// 	console.log(element.style.backgroundImage);
			// 	console.log(url);
			// 	console.log('-------------' + UrlExists(url));
			// }
			try {
				if (!UrlExists(url)) {
					// console.log('xxx');
					element.dataset.monkeeWrenchCheck = 'true';
					element.dataset.monkeeWrenchImageReplace = 'true';
					element.style.backgroundImage = 'url(../assets/img/debug/500x500.jpg)';
					addBGImageLabel(element);
				}
			} catch (e) {
				trace(e);
			}
		}

		// check all video
		var elementsVideo = document.getElementsByTagName("video");
		for (i in 0...elementsVideo.length) {
			var element:VideoElement = cast elementsVideo[i];
			element.dataset.monkeeWrenchCheck = 'true';
			var url = element.poster;
			// console.log(url);
			if (!UrlExists(url)) {
				// https://picsum.photos/500/500
				element.dataset.monkeeWrenchImageReplace = 'true';
				element.poster = '../assets/img/debug/146-500x500.jpg';
			}
		}
		// check all video
		var elementsLinks = document.getElementsByTagName("a");
		for (i in 0...elementsLinks.length) {
			var element:LinkElement = cast elementsLinks[i];
			element.dataset.monkeeWrenchCheck = 'true';
			var url = element.href;
			var href = element.getAttribute('href');
			var id = element.id;
			// console.log(url);
			if (href == '' || href == '#') {
				element.dataset.monkeeWrenchEmptyLink = 'true';
				element.innerHTML = '${utils.Emoji.monkeeWrench} ${element.innerHTML}';
			}
		}

		// var video = document.querySelectorAll('video')[0];
		// if (video != null) {
		// 	// console.log(video);
		// 	var source = video.querySelectorAll('source')[0];
		// 	// console.log(source);
		// 	source.src = 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4';
		// }
	}

	static public function main() {
		var app = new MonkeeWrench();
	}
}
