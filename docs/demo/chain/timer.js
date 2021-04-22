// Setup the component
var app = new MonkeeChain('#app', {
    data: {
        time: new Date().toLocaleTimeString()
    },
    template: function (props) {
        return '<strong>The time is:</strong> ' + props.time;
    }
});

// Update the clock once a second
window.setInterval(function () {
    app.data.time = new Date().toLocaleTimeString();
    // re-render app
    app.render();
}, 1000);