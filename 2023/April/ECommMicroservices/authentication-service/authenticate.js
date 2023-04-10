const authenticate = (req, res, next) => {
    const token = req.header('Authorization')?.replace('Bearer ', '');
    if (!token) {
        return res.status(401).send('No token provided');
    }

    try {
        const decoded = jwt.verify(token, process.env.JWT_SECRET);
        req.user = decoded;

        redisClient.get(`session:${decoded.id}`, (err, storedToken) => {
            if (err || !storedToken || storedToken !== token) {
                return res.status(401).send('Invalid token');
            }
            next();
        });
    } catch (err) {
        res.status(400).send('Invalid token');
    }
};
module.exports = authenticate