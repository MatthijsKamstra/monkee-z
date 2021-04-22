// Setup the component
var app = new MonkeeChain('#app', {
    data: {
        csv: "",
        arr: []
    },
    template: function (props) {
        return `
            <pre>${props.csv}:</pre>
            <strong>${title()}:</strong>
            <div>${table(props.arr)}</div>
            `;
    }
});

function title() {
    return 'Title via function';
}

function table(arr) {
    var html = '<table class="table">'
    for (let i = 0; i < arr.length; i++) {
        const row = arr[i];
        html += `<tr>`;
        for (let j = 0; j < row.length; j++) {
            const col = row[j];
            html += `<td>${col}<td>`;
        }
        html += `</tr>`;
    }
    html += '<table>'
    return html;
}

// Fetch API data
fetch('../../assets/data/data.csv').
    then(function (response) {
        return response.text();
    }).then(function (data) {
        // console.log(data);
        var arr = [];
        var linesArr = data.split('\n');
        for (let i = 0; i < linesArr.length; i++) {
            const line = linesArr[i];
            // console.log(line)
            var col = line.split(',');
            var tempColArr = [];
            for (let j = 0; j < col.length; j++) {
                const val = col[j].replaceAll('"', '');
                // console.log(val)
                tempColArr.push(val);
            }
            arr.push(tempColArr);
        }
        // console.log(arr);
        app.data.csv = data;
        app.data.arr = arr;
        app.render();
    });
