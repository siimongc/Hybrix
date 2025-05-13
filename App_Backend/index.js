// index.js

require('dotenv').config();
const express = require('express');
const cors = require('cors');
const session = require('express-session');

const forwardToken    = require('./middlewares/forwardToken');
const createVehicles  = require('./routes/createVehicles');
const getVehicles     = require('./routes/getVehicles');
const maintenanceData = require('./routes/maintenanceData');
const statsData       = require('./routes/statsData');
const authRoutes      = require('./routes/authRoutes');
const getAllUsers     = require('./routes/getUsers');
const getUserVehicle  = require('./routes/getUserVehicle');
const getUserData     = require('./routes/getUserData');
const updateUserData  = require('./routes/updateUserData');
const simulationRoutes= require('./routes/simulationRoutes');

const app = express();
const PORT = process.env.PORT || 3000;

// --- Middlewares globales ---
app.use(cors({
  origin: true,
  credentials: true,
  allowedHeaders: ['Content-Type', 'Authorization'],
  exposedHeaders: ['Authorization'],
}));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(session({
    secret: process.env.SESSION_SECRET || 'ashJk234',
    resave: false,
    saveUninitialized: true,
    cookie: { secure: false } // Usa true en producción con HTTPS
}));

// --- Rutas públicas ---
app.get('/', (req, res) => {
  res.status(200).send('¡Servidor backend corriendo!');
});
app.use('/', authRoutes);

// --- Rutas protegidas (reenvían token) ---
app.use('/hibrix/vehicle', forwardToken, createVehicles);
app.use('/hibrix/vehicle', forwardToken, getVehicles);
app.use('/hibrix/users',   forwardToken, getAllUsers);
app.use('/hibrix/users',   forwardToken, getUserVehicle);
app.use('/hibrix/users',   forwardToken, getUserData);
app.use('/hibrix/users',   forwardToken, updateUserData);
app.use('/hibrix',         forwardToken, maintenanceData);
app.use('/hibrix',         forwardToken, statsData);

// --- Rutas de simulación ---
app.use('/api', forwardToken, simulationRoutes);

// --- Levantar servidor ---
app.listen(PORT, () => {
  console.log(`Servidor escuchando en http://localhost:${PORT}`);
});
