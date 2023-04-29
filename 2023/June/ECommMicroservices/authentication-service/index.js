//npm install express jsonwebtoken redis bcrypt dotenv
const express = require('express');
const jwt = require('jsonwebtoken');
const redis = require('redis');
const bcrypt = require('bcrypt');
const dotenv = require('dotenv');
const authenticate = require('authenticate.js');
dotenv.config();


const app = express();
app.use(express.json());

const redisClient = redis.createClient({
    host: process.env.REDIS_HOST,
    port: process.env.REDIS_PORT
});

redisClient.on('error', (err) => {
    console.log('Error connecting to Redis:', err);
});
const hashPassword = async (password) => {
    const saltRounds = 10;
    return await bcrypt.hash(password, saltRounds);
};


const users = [
    // Example user object
    {
        id: 1,
        username: 'user',
        password: '$2b$10$BHXJkMefxnbwMZKMPB1dwO5l7jn5Jg0pV7r5PqUO40maIRJx6Ew1C' // bcrypt hash for 'password'
    }
];

app.get('/protected-route', authenticate, (req, res) => {
    // Xử lý logic cho route được bảo vệ
    res.status(200).send('Protected route');
});
app.post('/register', async (req, res) => {
    const { username, password } = req.body;

    // Kiểm tra xem tên người dùng đã tồn tại hay chưa
    const existingUser = users.find((u) => u.username === username);
    if (existingUser) {
        return res.status(400).send('Username already exists');
    }

    // Mã hóa mật khẩu và lưu người dùng mới
    const hashedPassword = await hashPassword(password);
    const newUser = {
        id: users.length + 1,
        username,
        password: hashedPassword
    };
    users.push(newUser);

    // Tạo JWT token và lưu vào Redis
    const token = jwt.sign({ id: newUser.id, username: newUser.username }, process.env.JWT_SECRET);
    redisClient.set(`session:${newUser.id}`, token);

    // Trả về thông tin người dùng và token
    const { password: _, ...userWithoutPassword } = newUser;
    res.status(201).send({ user: userWithoutPassword, token });
});

app.post('/login', async (req, res) => {
    const { username, password } = req.body;

    const user = users.find((u) => u.username === username);
    if (!user) {
        return res.status(400).send('Invalid username or password');
    }

    const validPassword = await bcrypt.compare(password, user.password);
    if (!validPassword) {
        return res.status(400).send('Invalid username or password');
    }

    const token = jwt.sign({ id: user.id, username: user.username }, process.env.JWT_SECRET);
    redisClient.set(`session:${user.id}`, token);

    res.status(200).send({ token });
});

app.post('/logout', (req, res) => {
    const token = req.header('Authorization').replace('Bearer ', '');
    if (!token) {
        return res.status(401).send('No token provided');
    }

    try {
        const decoded = jwt.verify(token, process.env.JWT_SECRET);
        redisClient.del(`session:${decoded.id}`);
        res.status(200).send('Logged out');
    } catch (err) {
        res.status(400).send('Invalid token');
    }
});

const port = process.env.PORT || 3000;
app.listen(port, () => {
    console.log(`Authentication Service listening on port ${port}`);
});
