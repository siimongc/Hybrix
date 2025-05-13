const express = require('express');
const router = express.Router();
const axios = require('axios');

router.post('/create', async (req, res) => {
  const { 
    id_type, 
    id_user, 
    plate,
    year, 
    brand, 
    model, 
    displacement, 
    weight, 
    power, 
    torque} = req.body;
  if (!id_type || !id_user || !plate || !year || !brand || !model ||  !displacement || !weight|| !power || !torque) {
    return res.status(400).json({ error: 'Faltan datos del vehículo.' });
  }
  try{
    const response = await axios.post('https://ase-backend-hybrix.azurewebsites.net/motorcycles/', req.body);

    res.status(response.status).json(response.data);
  }catch (error){
    console.error('Error al enviar datos:', error.message);
    res.status(500).json({ error: 'Error al enviar datos al otro servidor.' });
  }
});

module.exports = router;