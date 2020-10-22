const config = require("../config.js");
const jwt = require('jsonwebtoken');
const Joi = require('joi');
const mongoose = require('mongoose');

//simple schema
const UserSchema = new mongoose.Schema({
    name: {
	type: String,
	required: true,
	minlength: 3,
	maxlength: 50
    },
    email: {
	type: String,
	required: true,
	minlength: 5,
	maxlength: 255,
	unique: true
    },
    password: {
	type: String,
	required: true,
	minlength: 3,
	maxlength: 255
    },
    //give different access rights if admin or not 
    isAdmin: {
	type: Boolean,
	default: false
    }
});


//custom method to generate authToken 
UserSchema.methods.generateAuthToken = function() { 
    console.log("here");
    const token = jwt.sign({ _id: this._id, isAdmin: this.isAdmin }, config.secret, {
	expiresIn: 86400 // expires in 24 hours
    }); //get the private key from the config file -> environment variable
    console.log(token);
    return token;
}

const User = mongoose.model('User', UserSchema);

//function to validate user 
function validateUser(user) {
    const schema = {
	name: Joi.string().min(3).max(50).required(),
	email: Joi.string().min(5).max(255).required().email(),
	password: Joi.string().min(3).max(255).required(),
	isAdmin: Joi.boolean()
    };
    
    return Joi.validate(user, schema);
}

module.exports = {
    User: User, 
    validate: validateUser
}
