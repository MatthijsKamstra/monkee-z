(function ($hx_exports, $global) { "use strict";
class MonkeeGui {
	constructor(x,y,parent) {
		this.css = ".monkee-gui-wrapper {\n  font-size: 13px;\n  font-family: \"Segoe UI\", Tahoma, Geneva, Verdana, sans-serif;\n  border: 1px solid silver;\n  border-radius: 2px;\n  padding: 2px;\n  color: #444; }\n  .monkee-gui-wrapper .range-group {\n    padding-bottom: 4px; }\n    .monkee-gui-wrapper .range-group label {\n      display: block;\n      width: 100%;\n      color: #444; }\n    .monkee-gui-wrapper .range-group input {\n      display: inline-block;\n      width: 90% !important; }\n    .monkee-gui-wrapper .range-group span {\n      display: inline-block;\n      width: 9%;\n      text-align: center; }\n    .monkee-gui-wrapper .range-group.disabled {\n      opacity: 0.2; }\n    .monkee-gui-wrapper .range-group input[type=\"range\"]:disabled {\n      /* Disabled Element */\n      cursor: default; }\n    .monkee-gui-wrapper .range-group input[type=\"range\"]:disabled::-webkit-slider-runnable-track {\n      /* Disabled slider-runnable-track */\n      cursor: default; }\n    .monkee-gui-wrapper .range-group input[type=\"range\"]:disabled::-moz-range-track {\n      /* Disabled slider-range-track */\n      cursor: default; }\n    .monkee-gui-wrapper .range-group input[type=\"range\"]:disabled::-webkit-slider-thumb {\n      /* Disabled slider-thumb */\n      cursor: default; }\n    .monkee-gui-wrapper .range-group input[type=\"range\"]:disabled::-moz-range-thumb {\n      /* Disabled slider-thumb */\n      cursor: default; }\n  .monkee-gui-wrapper input[type=\"text\"] {\n    width: 100%;\n    padding: 4px;\n    box-sizing: border-box;\n    border: 1px solid #dee2e6;\n    border-radius: 2px; }\n  .monkee-gui-wrapper input[type=\"text\"]:focus {\n    border: 1px solid #c1c9d0; }\n  .monkee-gui-wrapper input[type=\"button\"] {\n    color: #fff;\n    background-color: #303742;\n    border: none;\n    padding: 4px;\n    text-decoration: none;\n    margin-bottom: 2px;\n    cursor: pointer;\n    width: 100%;\n    border-radius: 2px; }\n    .monkee-gui-wrapper input[type=\"button\"]:hover {\n      background-color: #455060; }\n  .monkee-gui-wrapper textarea {\n    width: 100%;\n    padding: 4px;\n    box-sizing: border-box;\n    border: 1px solid #dee2e6;\n    border-radius: 2px;\n    background-color: #f8f8f8; }\n  .monkee-gui-wrapper select {\n    width: 100%;\n    padding: 4px;\n    border: none;\n    border-radius: 4px;\n    background-color: #f1f1f1; }\n  .monkee-gui-wrapper img.monkee-gui-img {\n    padding: 0.25rem;\n    background-color: #fff;\n    border: 1px solid #dee2e6;\n    border-radius: 2px;\n    max-width: 100%;\n    height: auto;\n    margin-bottom: 2px; }\n  .monkee-gui-wrapper input[type=\"range\"] {\n    border-radius: 5px;\n    appearance: none;\n    width: 100%;\n    height: 6px;\n    background: #d3d3d3;\n    outline: none;\n    opacity: 0.7;\n    transition: opacity 0.2s; }\n    .monkee-gui-wrapper input[type=\"range\"]:hover {\n      opacity: 1; }\n    .monkee-gui-wrapper input[type=\"range\"]::-webkit-slider-thumb {\n      -webkit-appearance: none;\n      /* Override default look */\n      appearance: none;\n      width: 12px;\n      height: 12px;\n      border-radius: 50%;\n      background: #303742;\n      border-color: #303742;\n      cursor: pointer;\n      /* Cursor on hover */ }\n    .monkee-gui-wrapper input[type=\"range\"]::-moz-range-thumb {\n      width: 12px;\n      height: 12px;\n      border-radius: 50%;\n      background: #303742;\n      border-color: #303742;\n      cursor: pointer;\n      /* Cursor on hover */ }\n  .monkee-gui-wrapper .accordion {\n    margin-bottom: 2px; }\n    .monkee-gui-wrapper .accordion > input[type=\"checkbox\"] {\n      position: absolute;\n      left: -100vw; }\n    .monkee-gui-wrapper .accordion label {\n      display: block;\n      color: #444;\n      cursor: pointer;\n      font-weight: normal;\n      padding: 4px;\n      background: #e8ebef;\n      transition: all 0.5s;\n      border-radius: 2px;\n      line-height: 1.5rem; }\n      .monkee-gui-wrapper .accordion label:hover, .monkee-gui-wrapper .accordion label:focus {\n        background: #adb6c4; }\n      .monkee-gui-wrapper .accordion label:before {\n        content: \"+\";\n        font-size: 0.58em;\n        font-family: monospace;\n        font-weight: bold;\n        display: inline-block;\n        vertical-align: middle;\n        margin-right: 10px;\n        margin-left: 5px; }\n    .monkee-gui-wrapper .accordion > input[type=\"checkbox\"]:checked ~ label:before {\n      content: \"-\"; }\n    .monkee-gui-wrapper .accordion .content {\n      height: 0;\n      overflow-y: hidden;\n      border: 1px solid #e8ebef;\n      border-radius: 0 0 2px 2px;\n      border-top: 0; }\n      .monkee-gui-wrapper .accordion .content p {\n        padding: 0;\n        margin: 0; }\n    .monkee-gui-wrapper .accordion > input[type=\"checkbox\"]:checked ~ .content {\n      height: auto;\n      overflow: visible;\n      padding: 6px; }\n";
		this.isFolder = false;
		this._x = x;
		this._y = y;
		this._parent = parent;
		this.createWrapper();
	}
	createWrapper() {
		let style = window.document.createElement("style");
		style.innerHTML = this.css;
		window.document.body.append(style);
		this._wrapper = window.document.createElement("div");
		this._wrapper.className = "monkee-gui-wrapper";
		this._parent.appendChild(this._wrapper);
	}
	range(title,min,max,value,step,callback) {
		let range = new gui_Range(title,min,max,value,step,callback);
		range.add(this._wrapper);
		return range;
	}
	inputRange(title,min,max,value,step,callback) {
		return this.range(title,min,max,value,step,callback);
	}
	number(title,min,max,value,step,callback) {
		let el = new gui_Number(title,min,max,value,step,callback);
		el.add(this._wrapper);
		return el;
	}
	inputNumber(title,min,max,value,step,callback) {
		return this.number(title,min,max,value,step,callback);
	}
	rangeNumber(title,min,max,value,step,callback) {
		let el = new gui_RangeNumber(title,min,max,value,step,callback);
		el.add(this._wrapper);
		return el;
	}
	inputRangeNumber(title,min,max,value,step,callback) {
		return this.rangeNumber(title,min,max,value,step,callback);
	}
	button(title,callback) {
		let el = new gui_Button(title,callback);
		el.add(this._wrapper);
		return el;
	}
	inputButton(title,callback) {
		return this.button(title,callback);
	}
	textArea(title,value,callback) {
		let el = new gui_TextArea(title,value,callback);
		el.add(this._wrapper);
		return el;
	}
	text(title,value,callback) {
		let el = new gui_Text(title,value,callback);
		el.add(this._wrapper);
		return el;
	}
	inputtext(title,value,callback) {
		return this.text(title,value,callback);
	}
	image(title,url) {
		let el = new gui_Image(title,url);
		el.add(this._wrapper);
		return el;
	}
	radio(title,value,callback) {
		let el = new gui_Radio(title,1,callback);
		el.add(this._wrapper);
		return el;
	}
	checkbox(title,value,callback) {
		let el = new gui_Checkbox(title,value,callback);
		el.add(this._wrapper);
		return el;
	}
	folder(title,isClosed) {
		if(isClosed == null) {
			isClosed = false;
		}
		let el = new gui_Folder(title,isClosed);
		el.add(this._wrapper);
		let gui = new MonkeeGui(0,0,el.content);
		gui.set_isFolder(true);
		return gui;
	}
	get_isFolder() {
		return this.isFolder;
	}
	set_isFolder(value) {
		this._wrapper.className = "";
		return this.isFolder = value;
	}
	static create(x,y,parent) {
		let monkeeGui = new MonkeeGui(x,y,parent);
		return monkeeGui;
	}
}
$hx_exports["MonkeeGui"] = MonkeeGui;
Object.assign(MonkeeGui.prototype, {
	__properties__: {set_isFolder: "set_isFolder",get_isFolder: "get_isFolder"}
});
class Reflect {
	static setProperty(o,field,value) {
		let tmp;
		let tmp1;
		if(o.__properties__) {
			tmp = o.__properties__["set_" + field];
			tmp1 = tmp;
		} else {
			tmp1 = false;
		}
		if(tmp1) {
			o[tmp](value);
		} else {
			o[field] = value;
		}
	}
}
class gui_Button {
	constructor(title,callback) {
		this.title = title;
		this.callback = callback;
	}
	add(parent) {
		let div = window.document.createElement("div");
		div.className = "form-group";
		parent.appendChild(div);
		let input = window.document.createElement("input");
		input.type = "button";
		input.className = "monkee-btn monkee-btn-" + gui_Button.ID;
		input.id = "" + this.title;
		input.name = "" + this.title;
		input.value = "" + this.title;
		input.onclick = this.callback;
		div.appendChild(input);
		gui_Button.ID++;
	}
}
class gui_InputBase {
	constructor() {
		if(gui_InputBase._hx_skip_constructor) {
			return;
		}
		this._hx_constructor();
	}
	_hx_constructor() {
		this.isAutoUpdate = false;
	}
	createLabel(title,innerStr) {
		if(innerStr == null) {
			innerStr = title;
		}
		let label = window.document.createElement("label");
		label.htmlFor = "" + title;
		label.className = "monkee-gui-form-label";
		label.innerText = "" + innerStr;
		return label;
	}
	get_value() {
		return this.value;
	}
	set_value(v) {
		return this.value = v;
	}
}
Object.assign(gui_InputBase.prototype, {
	__properties__: {set_value: "set_value",get_value: "get_value"}
});
class gui_Checkbox extends gui_InputBase {
	constructor(title,isChecked,callback) {
		gui_InputBase._hx_skip_constructor = true;
		super();
		gui_InputBase._hx_skip_constructor = false;
		this._hx_constructor(title,isChecked,callback);
	}
	_hx_constructor(title,isChecked,callback) {
		this.isChecked = false;
		super._hx_constructor();
		this.title = title;
		this.isChecked = isChecked;
		this.callback = callback;
	}
	add(parent) {
		let div = window.document.createElement("div");
		div.className = "form-group";
		parent.appendChild(div);
		let input = window.document.createElement("input");
		input.type = "checkbox";
		input.id = "" + this.title;
		input.name = "" + this.title;
		let tmp = this.get_value();
		input.value = "" + tmp;
		let _gthis = this;
		input.oninput = function() {
			_gthis.callback.apply(_gthis.callback,[input]);
		};
		div.appendChild(input);
		div.appendChild(this.createLabel(this.title));
	}
}
class gui_Folder extends gui_InputBase {
	constructor(title,isClosed) {
		if(isClosed == null) {
			isClosed = false;
		}
		super();
		this.title = title;
		this.isClosed = isClosed;
		gui_Folder.ID++;
	}
	add(parent) {
		let div = window.document.createElement("div");
		div.className = "form-group";
		parent.appendChild(div);
		let section = window.document.createElement("section");
		section.className = "accordion";
		div.appendChild(section);
		let input = window.document.createElement("input");
		input.id = "handle_" + gui_Folder.ID;
		input.type = "checkbox";
		input.name = "collapse";
		input.checked = !this.isClosed;
		section.appendChild(input);
		let label = window.document.createElement("label");
		label.htmlFor = "handle_" + gui_Folder.ID;
		label.innerText = "" + this.title;
		section.appendChild(label);
		this.content = window.document.createElement("div");
		this.content.className = "content";
		section.appendChild(this.content);
	}
}
class gui_Image {
	constructor(title,url) {
		this.title = title;
		this.url = url;
	}
	add(parent) {
		let div = window.document.createElement("div");
		div.className = "form-group";
		parent.appendChild(div);
		let img = window.document.createElement("img");
		img.src = "" + this.url;
		img.name = "" + this.title;
		img.alt = "" + this.title;
		img.className = "monkee-gui-img";
		div.appendChild(img);
		div.appendChild(img);
	}
}
class gui_Number extends gui_InputBase {
	constructor(title,min,max,value,step,callback) {
		super();
		this.title = title;
		this.min = min;
		this.max = max;
		this.set_value(value);
		this.step = step;
		this.callback = callback;
	}
	add(parent) {
		let div = window.document.createElement("div");
		div.className = "form-group";
		parent.appendChild(div);
		div.appendChild(this.createLabel(this.title,"" + this.title + " (between " + (this.min | 0) + " and " + (this.max | 0) + "):"));
		let input = window.document.createElement("input");
		input.type = "number";
		input.id = "" + this.title;
		input.name = "" + this.title;
		input.min = "" + this.min;
		input.max = "" + this.max;
		let tmp = this.get_value();
		input.value = "" + tmp;
		input.step = "" + this.step;
		let _gthis = this;
		input.oninput = function() {
			_gthis.callback.apply(_gthis.callback,[input]);
		};
		div.appendChild(input);
	}
}
class gui_Radio extends gui_InputBase {
	constructor(title,value,callback) {
		super();
		this.title = title;
		this.set_value(value);
		this.callback = callback;
		$global.console.warn("WIP, don't use (yet)");
	}
	add(parent) {
		let div = window.document.createElement("div");
		div.className = "form-group";
		parent.appendChild(div);
		let input = window.document.createElement("input");
		input.type = "radio";
		input.id = "" + this.title;
		input.name = "" + this.title;
		let tmp = this.get_value();
		input.value = "" + tmp;
		let _gthis = this;
		input.oninput = function() {
			_gthis.callback.apply(_gthis.callback,[input]);
		};
		div.appendChild(input);
		div.appendChild(this.createLabel(this.title));
	}
}
class gui_Range extends gui_InputBase {
	constructor(title,min,max,value,step,callback) {
		super();
		this.title = title;
		this.min = min;
		this.max = max;
		this.set_value(value);
		this.step = step;
		this.callback = callback;
	}
	add(parent) {
		this.wrapper = window.document.createElement("div");
		this.wrapper.className = "form-group range-group";
		parent.appendChild(this.wrapper);
		this.wrapper.appendChild(this.createLabel(this.title,"" + this.title + " (between " + (this.min | 0) + " and " + (this.max | 0) + "):"));
		this.txt = window.document.createElement("span");
		this.txt.id = "" + this.title + "_value";
		let tmp = this.get_value();
		this.txt.innerText = "" + tmp;
		this.input = window.document.createElement("input");
		this.input.type = "range";
		this.input.id = "" + this.title;
		this.input.name = "" + this.title;
		this.input.min = "" + this.min;
		this.input.max = "" + this.max;
		let tmp1 = this.get_value();
		this.input.value = "" + tmp1;
		this.input.step = "" + this.step;
		let _gthis = this;
		this.input.oninput = function() {
			_gthis.txt.innerHTML = this.value;
			_gthis.callback.apply(_gthis.callback,[_gthis.input]);
		};
		this.wrapper.appendChild(this.input);
		this.wrapper.appendChild(this.txt);
	}
}
class gui_RangeNumber extends gui_InputBase {
	constructor(title,min,max,value,step,callback) {
		super();
		this.title = title;
		this.min = min;
		this.max = max;
		this.set_value(value);
		this.step = step;
		this.callback = callback;
		this.init();
	}
	init() {
	}
	add(parent) {
		let div = window.document.createElement("div");
		div.className = "form-group";
		parent.appendChild(div);
		div.appendChild(this.createLabel(this.title,"" + this.title + " (between " + (this.min | 0) + " and " + (this.max | 0) + "):"));
		let input = window.document.createElement("input");
		let inputNr = window.document.createElement("input");
		inputNr.type = "number";
		inputNr.id = "" + this.title;
		inputNr.name = "" + this.title;
		inputNr.min = "" + this.min;
		inputNr.max = "" + this.max;
		let tmp = this.get_value();
		inputNr.value = "" + tmp;
		inputNr.step = "" + this.step;
		let _gthis = this;
		inputNr.oninput = function() {
			input.value = this.value;
			_gthis.callback.apply(_gthis.callback,[inputNr]);
		};
		input.type = "range";
		input.id = "" + this.title;
		input.name = "" + this.title;
		input.min = "" + this.min;
		input.max = "" + this.max;
		let tmp1 = this.get_value();
		input.value = "" + tmp1;
		input.step = "" + this.step;
		input.oninput = function() {
			inputNr.value = this.value;
			_gthis.callback.apply(_gthis.callback,[input]);
		};
		div.appendChild(input);
		div.appendChild(inputNr);
	}
}
class gui_Text extends gui_InputBase {
	constructor(title,value,callback) {
		super();
		this.title = title;
		this._value = value;
		this.callback = callback;
	}
	add(parent) {
		let div = window.document.createElement("div");
		div.className = "form-group";
		parent.appendChild(div);
		div.appendChild(this.createLabel(this.title));
		this.input = window.document.createElement("input");
		this.input.type = "text";
		this.input.id = "" + this.title;
		this.input.name = "" + this.title;
		this.input.value = "" + this._value;
		this.input.placeholder = "" + this.title;
		let _gthis = this;
		this.input.oninput = function() {
			if(_gthis.isAutoUpdate) {
				Reflect.setProperty(_gthis.scope,_gthis.stringValue,_gthis.input.value);
			}
			if(_gthis.updateHandler != null) {
				_gthis.updateHandler.apply(_gthis.updateHandler,[_gthis.input]);
			}
			if(_gthis.callback != null) {
				_gthis.callback.apply(_gthis.callback,[_gthis.input]);
			}
		};
		div.appendChild(this.input);
	}
}
class gui_TextArea {
	constructor(title,value,callback) {
		this.title = title;
		this.set_value(value);
		this.callback = callback;
	}
	add(parent) {
		let div = window.document.createElement("div");
		div.className = "form-group";
		parent.appendChild(div);
		let label = window.document.createElement("label");
		label.htmlFor = "" + this.title;
		label.className = "__form-label";
		label.innerText = "" + this.title;
		div.appendChild(label);
		this.textAreaEl = window.document.createElement("textarea");
		this.textAreaEl.id = "" + this.title;
		this.textAreaEl.name = "" + this.title;
		let tmp = this.get_value();
		this.textAreaEl.value = "" + tmp;
		div.appendChild(this.textAreaEl);
	}
	get_value() {
		return this.value;
	}
	set_value(str) {
		if(this.textAreaEl != null) {
			this.textAreaEl.value = str;
		}
		return this.value = str;
	}
}
Object.assign(gui_TextArea.prototype, {
	__properties__: {set_value: "set_value",get_value: "get_value"}
});
class haxe_iterators_ArrayIterator {
	constructor(array) {
		this.current = 0;
		this.array = array;
	}
	hasNext() {
		return this.current < this.array.length;
	}
	next() {
		return this.array[this.current++];
	}
}
{
}
gui_Button.ID = 0;
gui_InputBase._hx_skip_constructor = false;
gui_Folder.ID = 0;
})(typeof exports != "undefined" ? exports : typeof window != "undefined" ? window : typeof self != "undefined" ? self : this, typeof window != "undefined" ? window : typeof global != "undefined" ? global : typeof self != "undefined" ? self : this);
