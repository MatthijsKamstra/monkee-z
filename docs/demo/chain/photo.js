// Setup the component
var app = new MonkeeChain("#app", {
    data: {
        heading: "image list from picsum",
        json: [],
    },
    template: function (props) {
        return `
          <h1>${props.heading}</h1>
          <ul>
              ${props.json
                .map(function (todo) {
                    return `<li>${todo.author}</li>`;
                })
                .join("")}
            </ul>

            <h1>${props.heading}</h1>
            <div class="row">
               ${props.json
                .map(function (obj) {
                    return `<div class="col-4">
                        <a href="${obj.url}" target="_blank">
                            <img src="${obj.download_url}" alt="${obj.author}" class="img-fluid" />
                        </a>
                    </div>
                `;
                })
                .join("")}
            </div>
          `;
    },
});

/**
{
    "id":"0",
    "author":"Alejandro Escamilla",
    "width":5616,
    "height":3744,
    "url":"https://unsplash.com/photos/yC-Yzbqy7PY",
    "download_url":"https://picsum.photos/id/0/5616/3744"
}
*
* get a list of images from https://picsum.photos/
* Fetch API data
*/
fetch("https://picsum.photos/v2/list")
    .then(function (response) {
        return response.json();
    })
    .then(function (data) {
        // console.log(data);
        app.data.json = data;
        app.render();
    });
