// Setup the component
var app = new MonkeeChain("#app", {
    data: {
        md: "",
        arr: [],
    },
    template: function (props) {
        return `
            <pre>${props.md}</pre>
            <div>${table(props.arr)}</div>
            `;
    },
});


function table(arr) {
    var html = '<table class="table table-striped table-sm">';
    for (let i = 0; i < arr.length; i++) {
        const row = arr[i];
        html += `<tr>`;
        for (let j = 0; j < row.length; j++) {
            const col = row[j];
            html += `<td>${col}<td>`;
        }
        html += `</tr>`;
    }
    html += "<table>";
    return html;
}

// Fetch API data
fetch("../../assets/md/monkee_load.md")
    .then(function (response) {
        return response.text();
    })
    .then(function (data) {
        // console.log(data);
        var arr = [];
        var linesArr = data.split("\n");
        for (let i = 0; i < linesArr.length; i++) {
            if (i == 1) continue;
            const line = linesArr[i];
            // console.log(line);
            var col = line.split(" | ");
            // console.log(col.length);
            if (col.length <= 1) continue;
            var tempColArr = [];
            for (let j = 0; j < col.length; j++) {
                const val = col[j].replaceAll("| ", "").replaceAll(" |", "").replaceAll('', "");
                // console.log(val);
                tempColArr.push(val);
            }
            arr.push(tempColArr);
        }
        console.log(arr);
        app.data.md = data;
        app.data.arr = arr;
        app.render();
    });
