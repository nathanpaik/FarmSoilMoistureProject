const express = require('express');
const router = express.Router();
const Site = require('../models/Site');


router.get('/', async (req, res) => {
    try {
        const sites = await Site.find();
        res.json(sites);
    } catch (err) {
        res.json({ message: err });
    }

});

router.get('/dropdown', async (req,res) => {

    try {
        const sites = await Site.find().select('name');
        res.json(sites);
    }  catch (err) {
        res.json({ message: err });
    }

});


router.get('/:id', async (req, res) => {
    try {
        const site = await Site.findById({_id: req.params.id});
        res.json(site);
    } catch (error) {
        res.json({ message: err });
    }

});


router.post('/', async (req, res) => {
    const site = new Site({
        name: req.body.name,
        city: req.body.city,
        state: req.body.state,
        location: req.body.location
    });
    try {
        const savedSite = await site.save()
        res.json(savedSite);
    } catch (err) {
        res.json({ message: err });
    }

});

module.exports = router;
