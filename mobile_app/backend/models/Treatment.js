const mongoose = require('mongoose');

const TreatmentSchema = mongoose.Schema({

    site : {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Site'
    },

    dateofPlanting: Date,
    
    features : {
	treatmentName: String,
	cropType: String,
        numberRows: Number,
        numberSeeds: Number,
	irrigationSchedule : {
            times: Number,
            period: {
		type: String,
		enum: ['hours', 'days']
            }
	},
	bedDim: [Number]	
    }

});

module.exports = mongoose.model("Treatment", TreatmentSchema);
