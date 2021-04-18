// Setup the component
var app = new MonkeeChain('#app', {
    data: {
        json: {
            name: '',
            size: {
                minified: "",
                original: "",
                uglifyjs: "",
            }
        }
    },
    template: function (props) {
        return `
            <strong>File ${props.json.name}:</strong>
            <ul>
                <li>Original file size: ${props.json.size.original}</li>
                <li>UglifyJs file size: ${props.json.size.uglifyjs}</li>
                <li>Extra minified file size: ${props.json.size.minified}</li>
            </ul>
            `;
    }
});

// Fetch API data
fetch('../data/json/monkee_load.json').
    then(function (response) {
        return response.json();
    }).then(function (data) {
        // console.log(data);
        app.data.json = data;
        app.render();
    });
