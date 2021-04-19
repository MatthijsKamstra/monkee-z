new MonkeeChain('#app', {
  data: {
    heading: 'My Todos',
    todos: ['Swim', 'Climb', 'Jump', 'Play']
  },
  template: function (props) {
    return `
      <h1>${props.heading}</h1>
      <ul>
        ${props.todos.map(function (todo) {
          return `<li>${todo}</li>`;
        }).join('')}
      </ul>`;
  }
});