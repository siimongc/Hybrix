// routes/simulationRoutes.js
const express = require('express');
const axios = require('axios');
const router = express.Router();

const FASTAPI_BASE = process.env.FASTAPI_URL || 'https://ase-backend-hybrix.azurewebsites.net';

// Obtener todas las simulaciones
router.get('/simulations', async (req, res, next) => {
  try {
    const { data } = await axios.get(`${FASTAPI_BASE}/simulation/`);
    res.json(data);
  } catch (err) {
    next(err);
  }
});

// Obtener datos de una simulación por ID
router.get('/simulations/:id/data', async (req, res, next) => {
  const { id } = req.params;
  try {
    const { data } = await axios.get(`${FASTAPI_BASE}/data_simulation/${id}`);
    res.json(data);
  } catch (err) {
    next(err);
  }
});

module.exports = router;
