const express = require('express');
const router = express.Router();
const axios = require('axios');

const user_id = 17;
const API_BASE_URL = 'https://ase-backend-hybrix.azurewebsites.net/';

router.put('/:user_id', async (req, res) => {
  //const userId = req.params.user_id;
  const userId = user_id;
  const apiUrl = `${API_BASE_URL}/users/17`;

  const {id_role, name, lastname, phone, email} = req.body; 
  if (!id_role || !name || !lastname || !phone || !email ){
    return res.status(400).json({ error: 'Faltan datos' });
  } 
  
  try {
    const response = await axios.put(apiUrl, req.body);
    res.status(response.status).json(response.data);
  } catch (error) {
    console.error('Error al enviar datos:', error.message);
    res.status(500).json({ error: 'Error al enviar datos al otro servidor.' });
  }
});

module.exports = router;