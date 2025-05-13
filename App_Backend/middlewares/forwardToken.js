module.exports = (req, res, next) => {
    let token = req.headers['authorization'];
    if (!token) {
        return res.status(403).json({ message: 'Token requerido' });
    }

    // Normaliza: asegúrate de que tenga el prefijo Bearer
    if (!token.startsWith('Bearer ')) {
        token = `Bearer ${token}`;
    }

    req.fastapiToken = token;
    next();
};
