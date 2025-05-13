// routes/statsData.js

const express = require('express');
const axios = require('axios');
const router = express.Router();

const fastApiUrl = 'https://ase-backend-hybrix.azurewebsites.net';

/**
 * GET /hibrix/statsData/:id_test
 * Reenvía el token al FastAPI, obtiene el array de lecturas,
 * toma el último elemento y devuelve todos sus campos.
 */
router.get('/statsData/:id_test', async (req, res) => {
  const { id_test } = req.params;

  try {
    // 1) Reenviar Authorization al FastAPI
    const headers = {};
    if (req.headers.authorization) {
      headers['Authorization'] = req.headers.authorization;
    }

    // 2) Llamada a FastAPI
    const response = await axios.get(
      `${fastApiUrl}/tests/${id_test}`,
      { headers }
    );
    const data = response.data;

    // 3) Extraer el array correcto (puede venir en data[id_test] o data.additionalProp1)
    const testArray = Array.isArray(data[id_test])
      ? data[id_test]
      : Array.isArray(data.additionalProp1)
      ? data.additionalProp1
      : [];

    if (testArray.length === 0) {
      console.log(`No data found for test ${id_test}`);
      return res.status(404).json({ message: 'No data found for this test ID' });
    }

    // 4) Seleccionar el último registro
    const last = testArray[testArray.length - 1];

    // 5) Devolver **todos** los campos tal cual vienen
    return res.status(200).json(last);

  } catch (error) {
    console.error('Error al obtener los datos en tiempo real:', error.message);
    if (error.response) {
      // Reenviar error tal cual lo devuelve FastAPI
      return res
        .status(error.response.status)
        .json({ error: error.response.data });
    }
    // Error inesperado
    return res.status(500).json({ error: 'Error interno del servidor' });
  }
});

module.exports = router;
