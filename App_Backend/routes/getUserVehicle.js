const express = require('express');
const router = express.Router();
const axios = require('axios');

const MOTORCYCLES_ENDPOINT = 'https://ase-backend-hybrix.azurewebsites.net/motorcycles/';
const TARGET_USER_ID = 17; 

router.get('/getUserVehicle', async (req, res) => {
    try {
        const response = await axios.get(MOTORCYCLES_ENDPOINT, {
            headers: {
                'Authorization': req.headers.authorization, 
            },
        });

        if (response.status === 200 && Array.isArray(response.data)) {
            const userMotorcycles = response.data.filter(motorcycle => motorcycle.id_user === TARGET_USER_ID);
            res.status(200).json(userMotorcycles);
        } else {
            console.error('Error al obtener motocicletas:', response.status, response.data);
            res.status(response.status).json({ error: 'Error al obtener las motocicletas.' });
        }

    } catch (error) {
        console.error('Error al comunicarse con el servidor de motocicletas:', error.message);
        res.status(500).json({ error: 'Error al obtener las motocicletas.' });
    }
});

module.exports = router;