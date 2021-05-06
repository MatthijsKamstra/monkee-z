// Setup the component
var app = new MonkeeChain("#app", {
  data: {
    json: {
      name: "",
      updated: "",
      size: {
        minified: "",
        original: "",
        uglifyjs: "",
      },
      url: {
        minified: "",
        original: "",
        uglifyjs: "",
      },
    },
  },
  template: function (props) {
    return `
      <div class="card">
        <div class="card-body">
          <strong>File ${props.json.name}:</strong>
          <p>Updated: ${props.json.updated}</p>
          <ul>
            <li>Original file size: ${props.json.size.original}</li>
            <li>UglifyJs file size: ${props.json.size.uglifyjs}</li>
            <li>Extra minified file size: ${props.json.size.minified}</li>
          </ul>
          <ul>
            <li>Download original file: <a href="${props.json.url.original}">${props.json.url.original}</a> (${props.json.size.original})</li>
            <li>UglifyJs file size: <a href="${props.json.url.uglifyjs}">${props.json.url.uglifyjs}</a> (${props.json.size.uglifyjs})</li>
            <li>Extra minified file size: <a href="${props.json.url.minified}">${props.json.url.minified}</a> (${props.json.size.minified})</li>
          </ul>
        </div>
      </div>`;
  },
});

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
