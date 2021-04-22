// some default values
let firstName = 'Matthijs';
let lastName = 'Kamstra';

// Setup the component
var app = new MonkeeChain('#app', {
    data: {
        message: '🐵'
    },
    template: function (props) {
        return `<p>${firstName} ${lastName}: ${props.message}</p>`;
    }
});

// update data
app.data.message = '🙈';
// re-render app
app.render();
