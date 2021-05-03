var app1 = new MonkeeChain("#app1", {
    data: {
        counter: 11,
    },
    template: function (props) {
        return `
        <form class="form-inline">
            <input type="text" class="form-control" value="${props.counter}" data-todo-edit="">
            <button class="btn btn-primary" data-add='up'>+</button>
            <button class="btn btn-primary" data-add='down'>-</button>
        </form> `;
    },
});

function clickHandler(e) {
    e.preventDefault();
    console.log(e);
    var el = e.target;
    var dir = el.getAttribute("data-add");
    if (dir == "up") {
        app1.data.counter++;
    } else {
        app1.data.counter--;
    }
    app1.render();
}

// Listen for clicks
document.getElementById("xx").addEventListener("click", clickHandler, false);
