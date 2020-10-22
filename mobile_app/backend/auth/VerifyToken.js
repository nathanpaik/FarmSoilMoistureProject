const jwt = require('jsonwebtoken');
const config = require('../config');

async function verifyToken(req, res, next) {
    const token = await req.headers['x-access-token'];
    console.log(token);
    if (!token) return res.status(401).send({ auth: false, message: 'No token provided.' });
    
    jwt.verify(token, config.secret, function(err, decoded) {
	if (err)
	    return res.status(500).send({ auth: false, message: 'Failed to authenticate token.' });
	
	// if everything good, save to request for use in other routes
	req.userId = decoded.id;
	req.isAdmin = decoded.isAdmin;
	next();
    });
}

module.exports = verifyToken;
