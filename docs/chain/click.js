var app = new MonkeeChain('#app', {
    data: {
        counter: 10
    },
    template: function (props) {
        return `
        <div id="x">
            <input type="text" class="" value="${props.counter}" data-todo-edit="">
            <button onclick="add(1)">+</button>
            <button onclick="add(-1)">-</button>
        </div > `;
    }
});

function add(dir) {
    app.data.counter += parseInt(dir);
    app.render();
}

