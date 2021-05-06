// Setup the component
var app = new MonkeeChain("#app", {
    data: {
        json: {
            name: "",
            url: {
                minified: "",
                original: "",
                uglifyjs: "",
            },
        },
    },
    template: function (props) {
        return `
        <div class="" style="position:relative;">
            <pre><code> ${props.json.url.original} </code></pre>
            <button class="btn" onclick="copyCodeClickHandler('quick-copy-code-input-${props.json.url.original}')" style="position: absolute; top: 0px; right: 0px;" title="Copy code">📋</button>
            <input type="text" id="quick-copy-code-input-${props.json.url.original}" value="${props.json.url.original}" style="position:fixed;top:-100px;"></input>
        </div>
        `;
    },
});

function copyCodeClickHandler(id) {
    var input = document.getElementById(id);
    input.select();
    document.execCommand('copy');
    window.alert('Quick code copy!');
}

// Fetch API data
fetch("../../assets/json/monkee_chain.json")
    .then(function (response) {
        return response.json();
    })
    .then(function (data) {
        //console.log(data);
        app.data.json = data;
        app.render();
    });
