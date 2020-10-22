const mongoose = require('mongoose');

const pointSchema = new mongoose.Schema({
    type: {
	type: String,
	default: "Point"
    },
    coordinates: {
	type: [Number],
	required: true
    }
});

const SiteSchema = new mongoose.Schema({

    name: String,
    city: String,
    state: String,
    location: pointSchema
});

module.exports = mongoose.model('Site', SiteSchema);
