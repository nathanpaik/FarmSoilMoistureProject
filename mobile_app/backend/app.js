const express = require('express');
const app = express();
const mongoose = require('mongoose');
const bodyParser = require('body-parser'); // to parse requests as JSON.
require('dotenv/config');
const verifyToken = require("./auth/VerifyToken.js");

app.use(bodyParser.json()); // use bodyParser for any request


//Import Routes

const sitesRoute = require('./routes/sites'); //import route function
const treatmentsRoute = require('./routes/treatments');
const AuthController = require('./auth/AuthController');
const UserController = require('./user/UserController');


//Use middleware
app.use('/users', verifyToken, function (req,res,next) {
    if(req.isAdmin) {
	next();
    } else {
	 res.statusCode = 401;
         // MyRealmName can be changed to anything, will be prompted to the user
         res.setHeader('WWW-Authenticate', 'Basic realm="MyRealmName"');
         // this will displayed in the browser when authorization is cancelled
	 res.end('Unauthorized');
    };
}, UserController);
app.use('/api/auth', AuthController);
app.use('/sites', verifyToken, sitesRoute); 
app.use('/treatments', verifyToken, treatmentsRoute);


//Routes

app.get('/', (req,res) => {
    res.send('Home');
});

mongoose.connect(
    process.env.DB_CONNECTION,
    { useNewUrlParser: true, useUnifiedTopology: true, useFindAndModify: false, useCreateIndex: true },
    () => console.log("connected to DB!")
);

app.listen(3000, function () {
    console.log("Listening on port 3000");
});
