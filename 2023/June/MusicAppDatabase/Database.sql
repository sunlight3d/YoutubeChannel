-- users (người dùng)
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

DELIMITER //
CREATE TRIGGER hash_password_before_insert
BEFORE INSERT ON users
FOR EACH ROW
BEGIN
    SET NEW.encrypted_password = SHA2(NEW.encrypted_password, 256);
END;
//
DELIMITER ;

DELIMITER //
CREATE FUNCTION is_login_successful (input_email VARCHAR(100), input_password VARCHAR(255))
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE login_successful BOOLEAN;
    SELECT COUNT(*) > 0 INTO login_successful
    FROM users
    WHERE email = input_email AND encrypted_password = SHA2(input_password, 256);
    
    RETURN login_successful;
END;
//
DELIMITER ;

-- This is a dummy procedure since sending email requires external tools.
-- You should implement this in your application code, not in MySQL.

DELIMITER //
CREATE PROCEDURE send_login_email (email VARCHAR(100), password VARCHAR(255))
BEGIN
    IF is_login_successful(email, password) THEN
        SELECT 'Login successful. Email sent.' AS message;
    ELSE
        SELECT 'Login unsuccessful. Email not sent.' AS message;
    END IF;
END;
//
DELIMITER ;



-- genres (thể loại)
CREATE TABLE genres (
    genre_id INT PRIMARY KEY AUTO_INCREMENT, -- id thể loại
    genre_name VARCHAR(100) NOT NULL -- tên thể loại
);

-- artists (nghệ sĩ)
CREATE TABLE artists (
    artist_id INT PRIMARY KEY AUTO_INCREMENT, -- id nghệ sĩ
    artist_name VARCHAR(100) NOT NULL -- tên nghệ sĩ
);

-- albums (album)
CREATE TABLE albums (
    album_id INT PRIMARY KEY AUTO_INCREMENT, -- id album
    album_name VARCHAR(100) NOT NULL, -- tên album
    artist_id INT NOT NULL, -- id nghệ sĩ
    release_date DATE NOT NULL, -- ngày phát hành
    FOREIGN KEY (artist_id) REFERENCES artists(artist_id) -- khóa ngoại với bảng artists
);

-- tracks (bài hát)
CREATE TABLE tracks (
    track_id INT PRIMARY KEY AUTO_INCREMENT, -- id bài hát
    track_name VARCHAR(100) NOT NULL, -- tên bài hát
    artist_id INT NOT NULL, -- id nghệ sĩ
    album_id INT, -- id album
    genre_id INT NOT NULL, -- id thể loại
    duration INT NOT NULL, -- thời lượng (giây)
    popularity INT NOT NULL, -- độ phổ biến
    lyrics TEXT, -- lời bài hát
    audio_url VARCHAR(MAX) NOT NULL, -- url file nhạc
    FOREIGN KEY (artist_id) REFERENCES artists(artist_id), -- khóa ngoại với bảng artists
    FOREIGN KEY (album_id) REFERENCES albums(album_id), -- khóa ngoại với bảng albums
    FOREIGN KEY (genre_id) REFERENCES genres(genre_id) -- khóa ngoại với bảng genres
);

-- playlists (danh sách phát)
CREATE TABLE playlists (
    playlist_id INT PRIMARY KEY AUTO_INCREMENT, -- id danh sách phát
    user_id INT NOT NULL, -- id người dùng
    playlist_name VARCHAR(100) NOT NULL, -- tên danh sách phát
    creation_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- ngày tạo
    FOREIGN KEY (user_id) REFERENCES users(user_id) -- khóa ngoại với bảng users
);

-- playlist_track (danh sách phát - bài hát)
CREATE TABLE playlist_track (
    playlist_id INT NOT NULL, -- id danh sách phát    
    track_id INT NOT NULL, -- id bài hát
    PRIMARY KEY (playlist_id, track_id), -- khóa chính
    FOREIGN KEY (playlist_id) REFERENCES playlists(playlist_id), -- khóa ngoại với bảng playlists
    FOREIGN KEY (track_id) REFERENCES tracks(track_id) -- khóa ngoại với bảng tracks
);

-- favorites (bài hát yêu thích)
CREATE TABLE favorites (
    user_id INT NOT NULL, -- id người dùng
    track_id INT NOT NULL, -- id bài hát
    PRIMARY KEY (user_id, track_id), -- khóa chính
    FOREIGN KEY (user_id) REFERENCES users(user_id), -- khóa ngoại với bảng users
    FOREIGN KEY (track_id) REFERENCES tracks(track_id) -- khóa ngoại với bảng tracks
);

-- follows (theo dõi)
CREATE TABLE follows (
    follower_id INT NOT NULL, -- id người theo dõi
    followed_id INT NOT NULL, -- id người được theo dõi
    PRIMARY KEY (follower_id, followed_id), -- khóa chính
    FOREIGN KEY (follower_id) REFERENCES users(user_id), -- khóa ngoại với bảng users
    FOREIGN KEY (followed_id) REFERENCES users(user_id) -- khóa ngoại với bảng users
);

-- radio_stations (đài phát thanh)
CREATE TABLE radio_stations (
    radio_station_id INT PRIMARY KEY AUTO_INCREMENT, -- id đài phát thanh
    station_name VARCHAR(100) NOT NULL -- tên đài phát thanh
);

-- podcasts (podcast)
CREATE TABLE podcasts (
    podcast_id INT PRIMARY KEY AUTO_INCREMENT, -- id podcast
    podcast_name VARCHAR(100) NOT NULL, -- tên podcast
    description TEXT, -- mô tả
    cover_image_url VARCHAR(MAX), -- url ảnh bìa
    publisher_id INT NOT NULL, -- id nhà xuất bản
    FOREIGN KEY (publisher_id) REFERENCES users(user_id) -- khóa ngoại với bảng users
);

-- podcast_episodes (tập podcast)
CREATE TABLE podcast_episodes (
    episode_id INT PRIMARY KEY AUTO_INCREMENT, -- id tập
    podcast_id INT NOT NULL, -- id podcast
    episode_name VARCHAR(100) NOT NULL, -- tên tập
    duration INT NOT NULL, -- thời lượng (giây)
    audio_url VARCHAR(MAX) NOT NULL, -- url file âm thanh
    FOREIGN KEY (podcast_id) REFERENCES podcasts(podcast_id) -- khóa ngoại với bảng podcasts
);

-- user_history (lịch sử nghe nhạc của người dùng)
CREATE TABLE user_history (
    user_id INT NOT NULL, -- id người dùng
    track_id INT NOT NULL, -- id bài hát
    listen_timestamp TIMESTAMP NOT NULL, -- thời điểm nghe
    PRIMARY KEY (user_id, track_id, listen_timestamp), -- khóa chính
    FOREIGN KEY (user_id) REFERENCES users(user_id), -- khóa ngoại với bảng users
    FOREIGN KEY (track_id) REFERENCES tracks(track_id) -- khóa ngoại với bảng tracks
);

-- user_preferences (sở thích của người dùng)
CREATE TABLE user_preferences (
    user_id INT PRIMARY KEY, -- id người dùng
    preferred_genres VARCHAR(MAX), -- thể loại ưa thích
    preferred_artists VARCHAR(MAX), -- nghệ sĩ ưa thích
    preferred_audio_quality ENUM('low', 'medium', 'high') NOT NULL, -- chất lượng âm thanh ưa thích
    FOREIGN KEY (user_id) REFERENCES users(user_id) -- khóa ngoại với bảng users
);

-- user_notifications (thông báo cho người dùng)
CREATE TABLE user_notifications (
    notification_id INT PRIMARY KEY AUTO_INCREMENT, -- id thông báo
    user_id INT NOT NULL, -- id người dùng
    notification_type ENUM('new_release', 'update', 'recommendation') NOT NULL, -- loại thông báo
    notification_content TEXT NOT NULL, -- nội dung thông báo
    read_status BOOLEAN NOT NULL, -- trạng thái đã đọc
    timestamp TIMESTAMP NOT NULL, -- thời điểm thông báo
    FOREIGN KEY (user_id) REFERENCES users(user_id) -- khóa ngoại với bảng users
);

-- user_theme_settings (cài đặt giao diện của người dùng)
CREATE TABLE user_theme_settings (
    user_id INT PRIMARY KEY, -- id người dùng
    dark_mode BOOLEAN NOT NULL, -- chế độ tối
    theme_color VARCHAR(20), -- màu sắc chủ đạo
    FOREIGN KEY (user_id) REFERENCES users(user_id) -- khóa ngoại với bảng users
);
