const express = require('express');
const router = express.Router();
const bodyParser = require('body-parser');
router.use(bodyParser.urlencoded({ extended: false }));
router.use(bodyParser.json());
const { User, validate } = require('../user/User');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');
const config = require('../config');
const VerifyToken = require('./VerifyToken');

router.post('/register', async function(req, res) {  //create new user and return a token
    const { error } = validate(req.body);
    if (error) return res.status(400).send(error.details[0].message);

    //find an existing user
    let user = await User.findOne({ email: req.body.email });
    if (user) return res.status(400).send("User already registered.");

    user = new User(req.body);
    user.isAdmin = false;
    user.password = await bcrypt.hash(user.password, 10);
    await user.save();

    const token = user.generateAuthToken();
    res.header("x-auth-token", token).send({
	_id: user._id,
	name: user.name,
	email: user.email
    });
});


router.post('/login', async function(req, res) {
    
    User.findOne({ name: req.body.name }, async function (err, user) {
	if (err) return res.status(500).send('Error on the server.');
	if (!user) return res.status(404).send('No user found.');
	
	const passwordIsValid = await bcrypt.compareSync(req.body.password, user.password);
	if (!passwordIsValid) return res.status(401).send({ auth: false, token: null });
	
	const token = user.generateAuthToken();
	res.status(200).send({ auth: true, token: token });
    });
    
});

router.get('/me', VerifyToken, async (req, res) => {   //take token from the request body and return the user who has this token
    User.findById(req.userId, { password: 0 }, async function (err, user) {
	if (err) return res.status(500).send("There was a problem finding the user.");
	if (!user) return res.status(404).send("No user found.");
	
	res.status(200).send(user);
    });
    
});

router.get('/logout', function(req, res) {
    res.status(200).send({ auth: false, token: null });
});

module.exports = router;
