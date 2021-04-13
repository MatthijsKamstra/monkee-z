# 🐵 Monkee Load

simple way to load templates with vanille js.

```
+ docs
	+ components
		- nav.html
		- main.html
		- footer.html
```

for example `nav.html` is: `<nav>navigation</nav>`

```html
<div data-load="components/nav.html"></div>
<div data-load="components/main.html"></div>
<div data-load="components/footer.html"></div>
```

it will load the file `components/nav.html` and when its done, it will replace the div with the content

So `<div data-load="components/nav.html"></div>` will become `<nav>navigation</nav>`.

# Haxe project

This is an example Haxe project scaffolded by Visual Studio Code.

Without further changes the structure is following:

- `src/Main.hx`: Entry point Haxe source file
- `build.hxml`: Haxe command line file used to build the project
- `README.md`: This file
