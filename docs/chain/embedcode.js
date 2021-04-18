function embedcode(id, filename) {

    // <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/highlight.js/10.7.2/styles/default.min.css">
    //     <link rel="stylesheet"
    //         href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/10.7.2/styles/monokai-sublime.min.css">
    //         <script src="//cdnjs.cloudflare.com/ajax/libs/highlight.js/10.7.2/highlight.min.js"></script>
    //         <script>hljs.highlightAll();</script>


    var link = document.createElement('link');
    link.rel = 'stylesheet';
    link.href = '//cdnjs.cloudflare.com/ajax/libs/highlight.js/10.7.2/styles/default.min.css';
    document.body.appendChild(link);
    var link = document.createElement('link');
    link.rel = 'stylesheet';
    link.href = 'https://cdnjs.cloudflare.com/ajax/libs/highlight.js/10.7.2/styles/monokai-sublime.min.css';
    document.body.appendChild(link);
    var script = document.createElement('script');
    script.src = '//cdnjs.cloudflare.com/ajax/libs/highlight.js/10.7.2/highlight.min.js';
    document.body.appendChild(script);
    var script = document.createElement('script');
    script.innerHTML = 'hljs.highlightAll();';
    document.body.appendChild(script);



    // var div = document.createElement('div');
    // div.id = `${id}`;
    // document.body.appendChild(div);

    // Setup the component
    var app = new MonkeeChain(`#${id}`, {
        data: {
            js: ''
        },
        template: function (data) {
            return `<pre><code class="js">${data.js}</code></pre>`;
        }
    });

    // Fetch API data
    fetch(`${filename}`)
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

}
