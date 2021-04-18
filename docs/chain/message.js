// some default values
let firstName = 'Matthijs';
let lastName = 'Kamstra';
new MonkeeChain('#app', {
    data: {
        message: "🐵"
    },
    template: function (props) {
        return `<p>${firstName} ${lastName}: ${props.message}</p>`;
    }
});