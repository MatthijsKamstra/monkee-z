function embedcode(id, filename) {

    // setup up highlight.js
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
    // var script = document.createElement('script');
    // script.innerHTML = 'hljs.highlightAll();';
    // document.body.appendChild(script);

    // Setup the component
    var app = new MonkeeChain(`#${id}`, {
        data: {
            js: '',
            code: 'test'
        },
        template: function (data) {
            return `
            <textarea id="input" hidden>${data.code}</textarea>
            <pre style="border-radius:4px;"><code class="js">${data.js}</code></pre>
            <button class="btn" id="copy-code-btn">📋</button>
            `;
        }
    });

    setButton(); // first try

    // Fetch API data
    fetch(`${filename}`)
        .then(function (response) {
            return response.text();
        }).then(function (data) {
            // console.log(data);
            app.data.code = data;
            app.data.js = data
                .replaceAll('"', '&quot;')
                .replaceAll('<', '&lt;')
                .replaceAll('>', '&gt;')
                .replaceAll('&', '&amp;')
                ;
            app.render();
            setTimeout(function () {
                hljs.highlightAll();
                setButton(); // second try
            }, 500);

        });

    function setButton() {
        var btn = document.getElementById('copy-code-btn');
        btn.classList.add('btn-dark');
        console.log(btn);

        var input = document.getElementById('input');
        btn.onclick = function (e) {
            e.preventDefault();
            console.log('click');
            input.select()
            document.execCommand('copy');
        };
    };

}
