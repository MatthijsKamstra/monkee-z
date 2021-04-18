// Setup the component
var app = new MonkeeChain('#app', {
    data: {
        js: ''
    },
    template: function (data) {
        return `<pre><code class="js">${data.js}</code></pre>`;
    }
});

// Fetch API data
fetch('fetch.js')
    .then(function (response) {
        return response.text();
    }).then(function (data) {
        // console.log(data);
        app.data.js = data
            .replaceAll('"', '&quot;')
            .replaceAll('<', '&lt;')
            .replaceAll('>', '&gt;')
            ;
        app.render();
        hljs.highlightAll();
    });