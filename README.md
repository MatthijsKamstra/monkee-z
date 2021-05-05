# 🐵 monkee-z

It;s not alpha, not bravo, but zulu ... the last library you should use (and my personal playground)

performance is weak: again don't use this

![](icon.png)

```html
<!-- Monkee code -->

<!-- Monkee Load -->
<script src="https://matthijskamstra.github.io/monkee-z/js/monkee_load.min.min.js"></script>

<!-- Monkee Chain -->
<script src="https://matthijskamstra.github.io/monkee-z/js/monkee_chain.min.min.js"></script>

<!-- Monkee React -->
<script src="https://matthijskamstra.github.io/monkee-z/js/monkee_react.min.min.js"></script>

<!-- Monkee Util -->
<script src="https://matthijskamstra.github.io/monkee-z/js/monkee_util.js"></script>
```

## util

```html
<!-- Show code -->
<script>
  MonkeeUtil.embedCode("#code-app", "demo/index.js");
</script>
```

## 🐵 monkee-load

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

```html
<!-- Monkee code -->
<!-- uncompressed -->
<script src="https://matthijskamstra.github.io/monkee-z/js/monkee_load.js"></script>
<!-- compressed -->
<script src="https://matthijskamstra.github.io/monkee-z/js/monkee_load.min.js"></script>
<!-- compressed to the max -->
<script src="https://matthijskamstra.github.io/monkee-z/js/monkee_load.min.min.js"></script>
```

## 🐵 monkee-load-inner

Same as monkee-load this will load a file, but use the `innerHTML` to parse the data

for example content from `data.txt` is `foobar`

```html
<p data-load-inner="data/data.txt" class="text-secondary"></p>
```

So `<p data-load-inner="data/data.txt" class="text-secondary"></p>` will become `<p data-load-inner="data/data.txt" class="text-secondary">foobar</p>`.

Als possible to use more then one target

```html
<div data-load-inner="data/data.txt" data-target="out" class="text-secondary">
  <p data-name="out" class="text-primary">.text-primary</p>
  <p data-name="out" class="text-secondary">.text-secondary</p>
  <p data-name="out" class="text-success">.text-success</p>
  <p data-name="out" class="text-danger">.text-danger</p>
  <p data-name="out" class="text-warning">.text-warning</p>
  <p data-name="out" class="text-info">.text-info</p>
  <p data-name="out" class="text-light bg-dark">.text-light</p>
  <p data-name="out" class="text-dark">.text-dark</p>
  <p data-name="out" class="text-muted">.text-muted</p>
  <p data-name="out" class="text-white bg-dark">.text-white</p>
</div>
```

it will replace all the content form that `<p>`

### JSON

create a json like this

```json
{
  "firstname": "Matthijs",
  "lastname": "Kamstra",
  "email": "matthijskamstra@fake.nl"
}
```

`input` value will be populated by the json

```html
<div class="container mt-5">
  <h1>Inner data json</h1>
  <form data-load-inner="data/data.json">
    <input
      data-name="firstname"
      type="text"
      class="form-control"
      placeholder="test"
    />
    <input
      data-name="lastname"
      type="text"
      class="form-control"
      placeholder="test"
    />
    <input
      data-name="email"
      type="email"
      class="form-control"
      placeholder="name@example.com"
    />
  </form>
</div>
```

```json
{
  "chapter": [
    { "title": "title 0", "body": "body 0" },
    { "title": "title 1", "body": "body 1" },
    { "title": "title 2", "body": "body 2" },
    { "title": "title 3", "body": "body 3" },
    { "title": "title 4", "body": "body 4" },
    { "title": "title 5", "body": "body 5" }
  ]
}
```

just show the json in a pre element

```html
<div class="container mt-5">
  <h1>Inner data json</h1>
  <pre data-load-inner="data/content.json" class="text-secondary"></pre>
</div>
```

get specific data from the json

```html
<div class="container mt-5">
  <h1>Inner data json</h1>
  <div data-load-inner="data/content.json" class="">
    <pre data-name="chapter[2]"></pre>
  </div>
</div>
```

## 🐵 monkee-react

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

## source

- https://github.com/ciscoheat/buddy
- https://reefjs.com/routing/snorkel/
- https://getbootstrap.com/docs/4.5/getting-started/introduction/
- https://highlightjs.org/usage/
- https://picsum.photos/
- https://lorim

## reactive

- https://gist.github.com/FLamparski/1122e08edeef19ff0913
- https://www.monterail.com/blog/2016/how-to-build-a-reactive-engine-in-javascript-part-1-observable-objects
- https://medium.com/hackernoon/how-i-converted-my-react-app-to-vanillajs-and-whether-or-not-it-was-a-terrible-idea-4b14b1b2faff
- https://medium.com/hackernoon/how-i-converted-my-react-app-to-vanillajs-and-whether-or-not-it-was-a-terrible-idea-4b14b1b2faff
- https://medium.com/@varaprasadh.a/build-reactive-ui-with-plain-javascript-180085998756
