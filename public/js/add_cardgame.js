// Get the objects we need to modify
let addcardgameForm = document.getElementById("add-cardgame-form-ajax");

// Modify the objects we need
addcardgameForm.addEventListener("submit", function (e) {
    
    // Prevent the form from submitting
    e.preventDefault();

    // Get form fields we need to get data from
    let inputtitle = document.getElementById("input-title");
    let inputstock_qty = document.getElementById("input-stock_qty");
    let inputprice_per_pack = document.getElementById("input-price_per_pack");
    let inputdev_id = document.getElementById("input-dev_id");

    // Get the values from the form fields
    let titleValue = inputtitle.value;
    let stock_qtyValue = inputstock_qty.value;
    let price_per_packValue = inputprice_per_pack.value;
    let dev_idValue = inputdev_id.value;

    // Put our data we want to send in a javascript object
    let data = {
        title: titleValue,
        stock_qty: stock_qtyValue,
        price_per_pack: price_per_packValue,
        dev_id: dev_idValue
    }
    
    // Setup our AJAX request
    var xhttp = new XMLHttpRequest();
    xhttp.open("POST", '/add-cardgame-ajax', true);
    xhttp.setRequestHeader("Content-type", "application/json");

    // Tell our AJAX request how to resolve
    xhttp.onreadystatechange = () => {
        if (xhttp.readyState == 4 && xhttp.status == 200) {

            // Add the new data to the table
            addRowToTable(xhttp.response);

            // Clear the input fields for another transaction
            inputtitle.value = '';
            inputstock_qty.value = '';
            inputprice_per_pack.value = '';
            inputdev_id.value = '';
        }
        else if (xhttp.readyState == 4 && xhttp.status != 200) {
            console.log("There was an error with the input.")
        }
    }

    // Send the request and wait for the response
    xhttp.send(JSON.stringify(data));

})


// Creates a single row from an Object representing a single record from 
// CardGames
addRowToTable = (data) => {

    // Get a reference to the current table on the page and clear it out.
    let currentTable = document.getElementById("CardGames-table");

    // Get the location where we should insert the new row (end of table)
    let newRowIndex = currentTable.rows.length;

    // Get a reference to the new row from the database query (last object)
    let parsedData = JSON.parse(data);
    let newRow = parsedData[parsedData.length - 1]

    // Create a row and 4 cells
    let row = document.createElement("TR");
    let cardgame_idCell = document.createElement("TD");
    let titleCell = document.createElement("TD");
    let stock_qtyCell = document.createElement("TD");
    let price_per_packCell = document.createElement("TD");
    let dev_idCell = document.createElement("TD");
    let deleteCell = document.createElement("TD");
    

    // Fill the cells with correct data
    cardgame_idCell.innerText = newRow.cardgame_id;
    titleCell.innerText = newRow.title;
    stock_qtyCell.innerText = newRow.stock_qty;
    price_per_packCell.innerText = newRow.price_per_pack;
    dev_idCell.innerText = newRow.dev_id;
    deleteCell = document.createElement("button");
    deleteCell.innerHTML = "Delete";
    deleteCell.onclick = function(){
        deletecardgame(newRow.cardgame_id);
    };

    // Add the cells to the row 
    row.appendChild(cardgame_idCell);
    row.appendChild(titleCell);
    row.appendChild(stock_qtyCell);
    row.appendChild(price_per_packCell);
    row.appendChild(dev_idCell);
    row.appendChild(deleteCell);
  // Add a row attribute so the deleteRow function can find a newly added row
  row.setAttribute('data-value', newRow.cardgame_id);

    // Add the row to the table
    currentTable.appendChild(row);
}