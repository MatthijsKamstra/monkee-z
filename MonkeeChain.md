# Monkee Chain

basic setup

```html
<div id="app"></div>;

<script>
var id = document.getElementById("app");
var app = new MonkeeChain(id, {
  template: "<h1>Hello, foo!</h1>",
});
<script>
```

```js
var app1 = new MonkeeChain(document.getElementById("foo"), {});
var app2 = new MonkeeChain("#bar", {});
var app4 = new MonkeeChain(".monkee", {});
var app6 = new MonkeeChain("doesnotexist", {});
var app6 = new MonkeeChain("#doesnotexist", {});
var app5 = new MonkeeChain(".doesnotexist", {});
```

## nothing happens

perhaps forgot to call render again?

```js
var app = new MonkeeChain("#monkee", {...});
// re-render app
app.render();
```
