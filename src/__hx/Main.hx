import util.Debug;
import js.html.Element;
import js.html.MutationRecord;
import js.html.MutationObserver;
import js.Browser.*;
import js.Browser.window;
import component.*;

using JQ;
using StringTools;
using Lambda;

class Main {
	var DEBUG = false;
	var DEBUG_HERO = false;
	var DEBUG_STACK = false;
	var DEBUG_REVEAL = false;

	var documentHeight = .0;

	public function new() {
		document.addEventListener("DOMContentLoaded", function(event) {
			console.log('${App.NAME} Dom ready :: build: ${App.getBuildDate()}');

			window.onresize = () -> {
				console.log('${App.NAME} window.onresize :: build: ${App.getBuildDate()}');
				init();
			}

			// set the current height of the body
			documentHeight = document.body.height();

			// setup all
			init();

			// listen to changes
			documentChange();
		});
	}

	// ____________________________________ init ____________________________________

	function init() {
		new Hero(DEBUG_HERO);
		new Stack(DEBUG_STACK);
		new Reveal(DEBUG_REVEAL);

		// [mck] use when the page has a horizontal scrollbar
		// Debug.checkElementsWidth();
		// Debug.checkExternals();
	}

	// ____________________________________ not everything needs to be recalculated (hero flickers for example) ____________________________________

	function reposition() {
		new Stack(DEBUG_STACK);
		new Reveal(DEBUG_REVEAL);
	}

	// ____________________________________ changes to the document, check height  ____________________________________

	function documentChange() {
		// Select the node that will be observed for mutations
		var targetNode = document.documentElement;

		// Options for the observer (which mutations to observe)
		var config = {attributes: true, childList: true, subtree: true};

		// Callback function to execute when mutations are observed
		var callback = function(mutationsList:Array<MutationRecord>, observer) {
			if (document.body.height() != documentHeight) {
				// console.log('height changed : ${documentHeight} / ${document.body.height()}');
				documentHeight = document.body.height();
				reposition();
			}
			/*
				for (i in 0...mutationsList.length) {
					var mutation = mutationsList[i];
					trace(mutation);
					if (mutation.type == 'childList') {
						console.log('A child node has been added or removed.');
					} else if (mutation.type == 'attributes') {
						console.log('The ' + mutation.attributeName + ' attribute was modified.');
					}
				}
			 */
		};

		// Create an observer instance linked to the callback function
		var observer = new MutationObserver(callback);

		// Start observing the target node for configured mutations
		observer.observe(targetNode, config);

		// Later, you can stop observing
		// observer.disconnect();
	}

	static public function main() {
		var app = new Main();
	}
}
