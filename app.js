/*
    SETUP
*/
// Express
var express = require('express');   // We are using the express library for the web server
var app     = express();            // We need to instantiate an express object to interact with the server in our code
// app.js - SETUP section

app.use(express.json())
app.use(express.urlencoded({extended: true}))
PORT        = 5634;                 // Set a port number at the top so it's easy to change in the future

// app.js

const { engine } = require('express-handlebars');
var exphbs = require('express-handlebars');     // Import express-handlebars
app.engine('.hbs',engine({extname: ".hbs"}));  // Create an instance of the handlebars engine to process templates
app.set('view engine', '.hbs');                 // Tell express to use the handlebars engine whenever it encounters a *.hbs file.

// Database
var db = require('./database/db-connector')

// app.js - ROUTES section

app.get('/', function(req, res)
    {  
        let query1 = "SELECT * FROM CardGames;";               // Define our 1st query

        let query2 = "SELECT * FROM Developers;";                // 2nd query

        db.pool.query(query1, function(error, rows, fields){    // Execute the query

            let cardgames = rows;

            db.pool.query(query2, (error, rows, field) => {
                let dev_id = rows;
                return res.render('index', {data: cardgames, dev_id: dev_id});
            });             // Render the index.hbs file, and also send the renderer
        });                                                      // an object where 'data' is equal to the 'rows' we
    });                                                         // received back from the query

app.post('/add-cardgame', function(req, res) 
{
    // Capture the incoming data and parse it back to a JS object
    let data = req.body;

    // Capture NULL values
    let stock_qty = parseInt(data[`input-stock_qty`]);
    if (isNaN(stock_qty))
    {
        stock_qty = '0'
    }

    let price_per_pack = parseFloat(data[`input-price_per_pack`]);
    if (isNaN(price_per_pack))
    {
        console.log(error);
        res.sendStatus(400);
    }

    let dev_id = parseInt(data[`input-dev_id`]);
    if (isNaN(dev_id))
    {
        console.log(error);
        res.sendStatus(400);
    }

    // Create the query and run it on the database
    query1 = `INSERT INTO CardGames(title, stock_qty, price_per_pack, dev_id) VALUES('${data[`input-title`]}', ${stock_qty}, ${price_per_pack}, ${dev_id})`;
    db.pool.query(query1, function(error, rows, fields){

        // Check to see if there was an error
        if (error) {

            // Log the error to the terminal so we know what went wrong, and send the visitor an HTTP response 400 indicating it was a bad request.
            console.log(error)
            res.sendStatus(400);
        }
        else
        {
            res.redirect('/');
        }
    })
});
app.delete('/delete-cardgame-ajax/', function(req,res,next){
    let data = req.body;
    let cardgame_id = parseInt(data.cardgame_id);
    let deleteCardGames_Genres = `DELETE FROM CardGames_Genres WHERE cardgame_id = ?`;
    let deleteCardGames= `DELETE FROM CardGames WHERE cardgame_id = ?`;
  
  
          // Run the 1st query
          db.pool.query(deleteCardGames_Genres, [cardgame_id], function(error, rows, fields){
              if (error) {
  
              // Log the error to the terminal so we know what went wrong, and send the visitor an HTTP response 400 indicating it was a bad request.
              console.log(error);
              res.sendStatus(400);
              }
  
              else
              {
                  // Run the second query
                  db.pool.query(deleteCardGames, [cardgame_id], function(error, rows, fields) {
  
                      if (error) {
                          console.log(error);
                          res.sendStatus(400);
                      } else {
                          res.sendStatus(204);
                      }
                  })
              }
  })});


/*
    LISTENER
*/
app.listen(PORT, function(){            // This is the basic syntax for what is called the 'listener' which receives incoming requests on the specified PORT.
    console.log('Express started on http://localhost:' + PORT + '; press Ctrl-C to terminate.')
});
