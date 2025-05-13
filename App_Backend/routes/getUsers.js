const express = require('express');
const router = express.Router();
const axios = require('axios');
const forwardToken = require('../middlewares/forwardToken');

router.get('/getAllUsers', forwardToken, async (req, res) => {
    try {
        const response = await axios.get('https://ase-backend-hybrix.azurewebsites.net/users/', {
            headers: {
                Authorization: req.fastapiToken
            }
        });
        res.status(response.status).json(response.data);
    } catch (error) {
        console.error('Error al obtener datos:', error.message);
        res.status(500).json({ error: 'Error al obtener datos del otro servidor.' });
    }
});

module.exports = router;
