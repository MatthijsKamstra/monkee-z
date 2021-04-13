# monkee-z

It;s not alpha, not bravo, but zulu ... the last library you should use (and my personal playground)

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

## Monkee react

```html
<div data-wrapper="form">
  <input data-in="" type="text" />
  <span data-out=""></span>
</div>
```

#### sidenote

I was looking for a simplistic react code that would "repeat" what was said in an input field.

And thought I would try to build one myself.

Spend not long on it (it works) and the I read an article on stimulus. That does exactly what I wanted.

And it has a version 2... so BETTER then mine.

So just a POC that is totally unrelavant at this moment

**stimulus** https://stimulus.hotwire.dev/
