package;

using StringTools;

class BuildToolSimple {
	public static function run() {
		// when Haxe is done with compiling
		haxe.macro.Context.onAfterGenerate(() -> {
			#if !debug
			inline function kilobyte(size:Float, precision:Int = 1000)
				return Std.int(size / 1024 * precision) / precision + "Kb";
			inline function percentage(before:Float, after:Float, precision:Int = 1)
				return Std.int(after / before * 100 * precision) / precision;

			var outPath = haxe.macro.Compiler.getOutput();
			trace('Javascript file: "${outPath}"'); // docs/js/monkee_load.js
			var sizeBefore = sys.io.File.getContent(outPath).length;
			trace("JavaScript size original: " + kilobyte(sizeBefore));

			var outPath2 = outPath.replace('.js', '.min.js');
			@:privateAccess UglifyJS.compileFile(outPath, outPath2);

			var outContent2 = sys.io.File.getContent(outPath2);
			var sizeAfter2 = outContent2.length;
			trace("JavaScript size minified (UglifyJS): "
				+ kilobyte(sizeAfter2)
				+ " ("
				+ percentage(sizeAfter2, sizeBefore)
				+ "% smaller)");

			var outContent3 = sys.io.File.getContent(outPath2);

			// manually minify output even more
			outContent3 = outContent3
				.replace('e=function(){return js_Boot.__string_rec(this,"")},', "e=_=>{},")
				.replace('"undefined"!=typeof window?window:"undefined"!=typeof global?global:"undefined"!=typeof self?self:this', "window");

			// outContent = "$$0='prototype';$$1=Math.random;$$2=Object.assign;" + outContent;

			var outPath3 = outPath.replace('.js', '.min.min.js');
			// overwrite output
			sys.io.File.saveContent(outPath3, outContent3);
			var sizeAfter3 = outContent3.length;
			trace("JavaScript size minified: " + kilobyte(sizeAfter3) + " (" + percentage(sizeAfter3, sizeBefore) + "% smaller)");

			// generate json, small test
			var json = {};
			Reflect.setField(json, 'name', outPath.split('js/')[1]);
			Reflect.setField(json, 'updated', Date.now());
			Reflect.setField(json, 'size', {});
			Reflect.setField(json, 'url', {});
			Reflect.setField(Reflect.field(json, 'size'), 'original', '${kilobyte(sizeBefore)}');
			Reflect.setField(Reflect.field(json, 'size'), 'uglifyjs', '${kilobyte(sizeAfter2)}');
			Reflect.setField(Reflect.field(json, 'size'), 'minified', '${kilobyte(sizeAfter3)}');
			// https://matthijskamstra.github.io/monkee-z/js/monkee_load.min.min.js
			// {outPath}"'); // docs/js/monkee_load.js
			var path = outPath.replace('docs/', 'https://matthijskamstra.github.io/monkee-z/').replace('.js', '');
			Reflect.setField(Reflect.field(json, 'url'), 'original', '${path}.js');
			Reflect.setField(Reflect.field(json, 'url'), 'uglifyjs', '${path}.min.js');
			Reflect.setField(Reflect.field(json, 'url'), 'minified', '${path}.min.min.js');

			var outPath5 = outPath.replace('.js', '.json').replace('/js/', '/data/json/');
			sys.io.File.saveContent(outPath5, haxe.Json.stringify(json));
			#end
		});
	}
}
