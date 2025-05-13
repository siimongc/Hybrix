const express = require('express');
const axios = require('axios');
const router = express.Router();

const fastApiUrl = 'https://ase-backend-hybrix.azurewebsites.net';

router.get('/maintenanceData/:id_test', async (req, res) => {
    const { id_test } = req.params;

    try {
        const response = await axios.get(`${fastApiUrl}/tests/${id_test}`);
        const data = response.data;

        if (typeof data === 'object' && Object.keys(data).length > 0) {
            const testData = data[id_test];

            if (Array.isArray(testData) && testData.length > 0) {
                const lastReading = testData[testData.length - 1];

                const filterDataFormaintenance = {
                    date : lastReading.date,
                };

                console.log('Datos adicionales enviados:', filterDataFormaintenance);
                return res.status(200).json(filterDataFormaintenance);
            } else {
                return res.status(404).json({ message: 'No additional data found for this test ID' });
            }
        } else {
            return res.status(404).json({ message: 'No data found for this test ID' });
        }
    } catch (error) {
        console.log('Error al obtener los datos adicionales:', error.message);
        return res.status(500).json({ error: 'Error interno del servidor' });
    }
});

module.exports = router;