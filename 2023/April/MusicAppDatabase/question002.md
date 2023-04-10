MySQL, Write some triggers, functions, procedures to do:
-after login successfully, it automatically encrypted password
-send email, password for logging in, it check it is login successful, unsuccessful
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT, -- id người dùng
    first_name VARCHAR(50) NOT NULL, -- tên
    last_name VARCHAR(50) NOT NULL, -- họ
    email VARCHAR(100) NOT NULL UNIQUE, -- email
    encrypted_password VARCHAR(255) NOT NULL, -- mật khẩu được mã hóa
    provider ENUM('local', 'facebook', 'google') NOT NULL, -- nhà cung cấp đăng nhập
    provider_id VARCHAR(100), -- id nhà cung cấp đăng nhập
    access_token TEXT, -- mã truy cập
    refresh_token TEXT, -- mã làm mới
    registration_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP -- ngày đăng ký
);


