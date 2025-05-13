// routes/authRoutes.js
const express = require('express');
const router = express.Router();
const axios = require('axios');

const AUTH_ENDPOINT = 'https://ase-backend-hybrix.azurewebsites.net/auth/login';

router.post('/login', async (req, res) => {
    const { username, password } = req.body;

    if (!username || !password) {
        return res.status(400).json({ error: 'Se requieren usuario y contraseña' });
    }

    const payload = new URLSearchParams();
    payload.append('grant_type', 'password');
    payload.append('username', username);
    payload.append('password', password);

    try {
        const response = await axios.post(AUTH_ENDPOINT, payload, {
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
        });

        // Devolvemos el token que FastAPI generó
        res.json({ 
            message: 'Login exitoso', 
            access_token: response.data.access_token,
            token_type: response.data.token_type 
        });

    } catch (error) {
        console.error('Error al autenticar:', error.response ? error.response.data : error.message);
        res.status(error.response ? error.response.status : 500).json({
            error: 'Error al iniciar sesión',
            details: error.response ? error.response.data : error.message,
        });
    }
});

module.exports = router;
