# TODO

wrench

- [x] use async instead sync for images checking
- [ ] split up,
  - [ ] image
  - [ ] links
- [ ] more documentation
- [ ] explain icons
- [ ] more copy paste examples
- [x] ingeklapt group log
- [x] geen info aan het begin
- [x] url in menu group log
- [x] drag script in bookmarks
- [ ] adjust bookmarks script
- [x] Content Security Policy: The page’s settings blocked the loading of a resource at https://matthijskamstra.github.io/monkee-z/assets/img/debug/500x500.jpg (“img-src”).

impossible to use on some website... so need to use css to "color" the location if that doesn't work

use a nice gradient

```css
background: #12c2e9; /* fallback for old browsers */
background: -webkit-linear-gradient(
  to right,
  #f64f59,
  #c471ed,
  #12c2e9
); /* Chrome 10-25, Safari 5.1-6 */
background: linear-gradient(
  to right,
  #f64f59,
  #c471ed,
  #12c2e9
); /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */
```

or

```css
background: #f953c6; /* fallback for old browsers */
background: -webkit-linear-gradient(
  to right,
  #b91d73,
  #f953c6
); /* Chrome 10-25, Safari 5.1-6 */
background: linear-gradient(
  to right,
  #b91d73,
  #f953c6
); /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */
```

stuff to watch for

- [ ] xss
- [ ] implement proxy for object watch
- [ ] MonkeeUtil.embedCode fails with `<textarea>` tag in it
- [ ] set debug values via build `var DEBUG=true` with compile vars
- [ ] event system between different parts of Monkee-Z
- [ ] loading system with events

## XSS

- https://www.acunetix.com/websitesecurity/cross-site-scripting/

## fetch

modern solution

- https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API/Using_Fetch

- " is replaced with &quot;
- & is replaced with &amp;
- < is replaced with &lt;
- > is replaced with &gt;
