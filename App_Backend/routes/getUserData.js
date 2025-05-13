// routes/getUserData.js
const express = require('express');
const router = express.Router();
const axios = require('axios');
const forwardToken = require('../middlewares/forwardToken');

router.get('/:user_id', forwardToken, async (req, res) => {
    const userId = req.params.user_id;
    const apiUrl = `https://ase-backend-hybrix.azurewebsites.net/users/${userId}`;

    try {
        const response = await axios.get(apiUrl, {
            headers: {
                Authorization: req.fastapiToken
            }
        });
        res.status(200).json(response.data);
    } catch (error) {
        console.error('Error al obtener el usuario:', error.response?.data || error.message);
        res.status(error.response?.status || 500).json({ message: 'Error al obtener el usuario' });
    }
});

module.exports = router;
