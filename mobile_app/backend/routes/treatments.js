const express = require('express');
const router = express.Router();
const Treatment = require('../models/Treatment.js');


router.get('/', async (req, res) => {
    try {
        const treatments = await Treatment.find();
        res.json(treatments);
    } catch (err) {
        res.json({ message: err });
    }

});

router.get('/:id', async (req, res) => {
    try {
        const treatment = await Treatment.findById({_id: req.params.id}).populate('site');
        res.json(treatment);
    } catch (err) {
        res.json({ message: err });
    }

});

router.get('/dropdown/:siteId', async (req,res) => { //for getting treatments at a specific site, use for dropdown.
    try {
        const treatments = await Treatment.find({site: req.params.siteId}).select('features.treatmentName');
        res.json(treatments);

    } catch (err) {
        res.json({ message: err });
    }


});

router.post('/', async (req, res) => {
    const treatment = new Treatment({
        site: req.body.site,
	dateofPlanting: req.body.dateofPlanting,
        features : req.body.features
    });
    try {
        const savedTreatment = await treatment.save()
        res.json(savedTreatment);
    } catch (err) {
        res.json({ message: err });
    }

});

router.delete('/:id', async (req, res) => {
    try {
        const deletedTreatment = await Treatment.deleteOne({_id: req.params.id});
        res.json(deletedTreatment);
    } catch (err) {
        res.json({ message: err });
    }

});

router.put('/:id', function (req, res) {
    Treatment.findByIdAndUpdate(req.params.id, req.body, {new: true}, function (err, treatment) {
        if (err) return res.status(500).send("There was a problem updating the treatment.");
        res.status(200).send(treatment);
    });
});


module.exports = router;
