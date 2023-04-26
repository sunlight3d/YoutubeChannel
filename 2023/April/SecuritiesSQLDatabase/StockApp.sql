USE master;
--CREATE DATABASE StockApp;
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'StockApp')
    CREATE DATABASE StockApp;
GO
USE StockApp;
CREATE TABLE users (
    user_id INT PRIMARY KEY IDENTITY(1,1), -- ID người dùng
    username NVARCHAR(100) UNIQUE NOT NULL, -- Tên đăng nhập
    hashed_password NVARCHAR(200) NOT NULL,--mật khẩu được mã hóa
    email NVARCHAR(255) UNIQUE NOT NULL, -- Email
    phone NVARCHAR(20) NOT NULL, -- Số điện thoại
    full_name NVARCHAR(255), -- Họ và tên
    date_of_birth DATE, -- Ngày sinh
    country NVARCHAR(200) -- Quốc gia
);
--một người dùng có thể đăng nhập vài thiết bị
CREATE TABLE user_devices (
    id INT PRIMARY KEY IDENTITY, -- ID tự tăng, định danh duy nhất cho mỗi thiết bị của người dùng
    user_id INT NOT NULL, -- ID của người dùng liên kết với thiết bị
    device_id NVARCHAR(255) NOT NULL, -- ID của thiết bị (VD: UUID, IMEI, v.v.)    
    FOREIGN KEY (user_id) REFERENCES users(user_id) -- Liên kết khóa ngoại đến bảng users
);
-- Stocks table (Bảng cổ phiếu)
CREATE TABLE stocks (
    stock_id INT PRIMARY KEY IDENTITY(1,1), -- ID cổ phiếu
    symbol NVARCHAR(10) UNIQUE NOT NULL, -- Mã cổ phiếu
    company_name NVARCHAR(255) NOT NULL, -- Tên công ty
    market_cap DECIMAL(18, 2), -- Vốn hóa thị trường
    sector NVARCHAR(200), -- Ngành
    industry NVARCHAR(200), -- Lĩnh vực
    sector_en NVARCHAR(200),
    industry_en NVARCHAR(200),
    stock_type NVARCHAR(50),
    --Common Stock (Cổ phiếu thường),Preferred Stock (Cổ phiếu ưu đãi),ETF (Quỹ Đầu Tư Chứng Khoán)
    rank INT DEFAULT 0, -- Thứ hạng trong danh sách top stocks
    rank_source NVARCHAR(200),
    reason NVARCHAR(255) -- Nguyên nhân khiến cổ phiếu được đưa vào danh sách top stocks
);
--Cần dữ liệu theo thời gian thực:
CREATE TABLE quotes (
    quote_id INT PRIMARY KEY IDENTITY(1,1), -- ID của bản ghi
    stock_id INT FOREIGN KEY REFERENCES stocks(stock_id), -- ID của cổ phiếu
    price DECIMAL(18, 2) NOT NULL, -- Giá cổ phiếu
    change DECIMAL(18, 2) NOT NULL, -- Biến động giá cổ phiếu so với ngày trước đó
    percent_change DECIMAL(18, 2) NOT NULL, -- Tỷ lệ biến động giá cổ phiếu so với ngày trước đó
    volume INT NOT NULL, -- Khối lượng giao dịch trong ngày
    time_stamp DATETIME NOT NULL -- Thời điểm cập nhật giá cổ phiếu
);
GO
CREATE TABLE stocks (
    stock_id INT PRIMARY KEY IDENTITY(1,1), -- ID cổ phiếu
    symbol NVARCHAR(10) UNIQUE NOT NULL, -- Mã cổ phiếu
    company_name NVARCHAR(255) NOT NULL, -- Tên công ty
    market_cap DECIMAL(18, 2), -- Vốn hóa thị trường
    sector NVARCHAR(200), -- Ngành
    industry NVARCHAR(200), -- Lĩnh vực
    sector_en NVARCHAR(200),
    industry_en NVARCHAR(200),
    stock_type NVARCHAR(50),
    --Common Stock (Cổ phiếu thường),Preferred Stock (Cổ phiếu ưu đãi),ETF (Quỹ Đầu Tư Chứng Khoán)
    rank INT DEFAULT 0, -- Thứ hạng trong danh sách top stocks
    rank_source NVARCHAR(200),
    reason NVARCHAR(255) -- Nguyên nhân khiến cổ phiếu được đưa vào danh sách top stocks
);
--Các chỉ số(index => indices)
CREATE TABLE market_indices (
    index_id INT PRIMARY KEY IDENTITY,
    name NVARCHAR(255) NOT NULL,
    symbol NVARCHAR(50) UNIQUE NOT NULL
);
--market_indices - stocks => quan hệ nhiều nhiều (n - n)
--index_constituents: là danh sách các công ty đã được chọn để 
--tính toán chỉ số của một chỉ số thị trường chứng khoán nhất định. 
--association table
CREATE TABLE index_constituents (
    index_id INT FOREIGN KEY REFERENCES market_indices(index_id),
    stock_id INT
);
GO

ALTER TABLE index_constituents
ADD CONSTRAINT FK_IndexConstituents_Stocks
FOREIGN KEY (stock_id)
REFERENCES stocks (stock_id);

CREATE TABLE derivatives (
    derivative_id INT PRIMARY KEY IDENTITY, -- ID của chứng khoán phái sinh
    name NVARCHAR(255) NOT NULL, -- Tên của chứng khoán phái sinh
    underlying_asset_id INT, -- ID của tài sản cơ bản mà chứng khoán phái sinh được dựa trên
    contract_size INT, -- Kích thước hợp đồng (số lượng tài sản cơ bản trong một hợp đồng phái sinh)
    --Contract size khác nhau cho từng sản phẩm tài chính, 
    --ví dụ như trong thị trường forex, contract size được tính theo số lượng lot, 
    --trong khi đó ở thị trường hàng hóa, contract size được tính theo khối lượng hoặc số lượng sản phẩm tài chính.
    expiration_date DATE, -- Ngày hết hạn của hợp đồng phái sinh
    strike_price DECIMAL(18, 4), 
    -- Giá thực hiện (giá mà người mua chứng khoán phái sinh có quyền mua/bán tài sản cơ bản)
    -- Strike price thường được đặt ở một mức giá gần bằng với giá thị trường của tài sản cơ bản 
    -- để tăng khả năng tùy chọn sẽ được sử dụng.
    last_price DECIMAL(18, 2) NOT NULL,--Giá cuối cùng mà sản phẩm phái sinh đã được giao dịch trong phiên giao dịch gần nhất.
    change DECIMAL(18, 2) NOT NULL,--Biến động giá so với giá cuối cùng của phiên trước đó.
    percent_change DECIMAL(18, 2) NOT NULL,
    open_price DECIMAL(18, 2) NOT NULL,--Giá mở cửa (open price): Giá mà sản phẩm phái sinh đã được giao dịch lần đầu tiên trong phiên giao dịch hiện tại.
    high_price DECIMAL(18, 2) NOT NULL,
    --Giá cao nhất và giá thấp nhất: Giá cao nhất và giá thấp nhất mà sản phẩm phái sinh đã được giao dịch trong phiên giao dịch hiện tại.
    low_price DECIMAL(18, 2) NOT NULL,
    volume INT NOT NULL,--Khối lượng (volume): Tổng số lượng sản phẩm phái sinh đã được giao dịch trong phiên giao dịch hiện tại.
    open_interest INT NOT NULL,
    time_stamp DATETIME NOT NULL
);
ALTER TABLE derivatives
ADD CONSTRAINT FK_Derivatives_Stocks
FOREIGN KEY (underlying_asset_id)
REFERENCES stocks (stock_id);

-- covered warrants được bảo đảm bởi một bên thứ ba, 
-- thường là một ngân hàng hoặc một công ty chuyên cung cấp dịch vụ này
CREATE TABLE covered_warrants (
    warrant_id INT PRIMARY KEY IDENTITY, -- ID của chứng quyền có bảo đảm
    name NVARCHAR(255) NOT NULL, -- Tên của chứng quyền có bảo đảm
    underlying_asset_id INT FOREIGN KEY REFERENCES stocks(stock_id), -- ID của tài sản cơ bản liên quan (tham chiếu đến bảng cổ phiếu)
    issue_date DATE, -- Ngày phát hành chứng quyền có bảo đảm
    expiration_date DATE, -- Ngày hết hạn của chứng quyền có bảo đảm
    strike_price DECIMAL(18, 4), -- Giá thực hiện (giá mà người mua của chứng quyền có bảo đảm có quyền mua/bán tài sản cơ bản)
    warrant_type NVARCHAR(50) -- Loại chứng quyền có bảo đảm (ví dụ: mua (Call) hoặc bán (Put))
);

ALTER TABLE covered_warrants
ADD CONSTRAINT FK_CovedWarrants_Stocks
FOREIGN KEY (underlying_asset_id)
REFERENCES stocks (stock_id);

CREATE TABLE etfs (
    etf_id INT PRIMARY KEY IDENTITY, -- ID của Quỹ Đầu Tư Chứng Khoán (ETF)
    name NVARCHAR(255) NOT NULL, -- Tên của Quỹ Đầu Tư Chứng Khoán (ETF)
    symbol NVARCHAR(50) UNIQUE NOT NULL, -- Ký hiệu của Quỹ Đầu Tư Chứng Khoán (ETF) trên thị trường
    management_company NVARCHAR(255), -- Tên công ty quản lý Quỹ Đầu Tư Chứng Khoán (ETF)
    inception_date DATE -- Ngày thành lập Quỹ Đầu Tư Chứng Khoán (ETF)
);
--Quan hệ giữa etf và etf_quotes là quan hệ 1-n (một quỹ đầu tư có thể có nhiều bản ghi quotes trong cùng một ngày).
CREATE TABLE etf_quotes (
    quote_id INT PRIMARY KEY IDENTITY(1,1), -- ID của bản ghi
    etf_id INT FOREIGN KEY REFERENCES etfs(etf_id), -- ID của Quỹ Đầu Tư Chứng Khoán (ETF)
    price DECIMAL(18, 2) NOT NULL, -- Giá của Quỹ Đầu Tư Chứng Khoán (ETF)
    change DECIMAL(18, 2) NOT NULL, -- Biến động giá của Quỹ Đầu Tư Chứng Khoán (ETF) so với ngày trước đó
    percent_change DECIMAL(18, 2) NOT NULL, -- Tỷ lệ biến động giá của Quỹ Đầu Tư Chứng Khoán (ETF) so với ngày trước đó
    total_volume INT NOT NULL, -- Tổng khối lượng giao dịch trong ngày
    time_stamp DATETIME NOT NULL -- Thời điểm cập nhật giá của Quỹ Đầu Tư Chứng Khoán (ETF)
);
CREATE TABLE etf_holdings (
    -- ID của Quỹ Đầu Tư Chứng Khoán (ETF) liên quan đến mã cổ phiếu được giữ (tham chiếu đến bảng etfs).
    etf_id INT FOREIGN KEY REFERENCES etfs(etf_id), 
    -- ID của cổ phiếu mà Quỹ Đầu Tư Chứng Khoán (ETF) đang giữ (tham chiếu đến bảng stocks).
    stock_id INT FOREIGN KEY REFERENCES stocks(stock_id), 
    shares_held DECIMAL(18, 4), 
    -- Số lượng cổ phiếu của mã cổ phiếu đó mà Quỹ Đầu Tư Chứng Khoán (ETF) đang nắm giữ.
    weight DECIMAL(18, 4) 
    -- Trọng số của cổ phiếu đó trong tổng danh mục đầu tư của Quỹ Đầu Tư Chứng Khoán (ETF), thể hiện tỷ lệ phần trăm của cổ phiếu đó so với tổng giá trị danh mục.
);
-- Watchlists table (Bảng danh sách theo dõi)
-- N users theo dõi N stocks
CREATE TABLE watchlists (
    user_id INT FOREIGN KEY REFERENCES users(user_id), -- ID người dùng
    stock_id INT FOREIGN KEY REFERENCES stocks(stock_id) -- ID cổ phiếu
);
-- Orders table (Bảng đơn hàng / đặt lệnh)
/*
Market order: Lệnh mua/bán thực hiện ngay lập tức với giá thị trường hiện tại. 
Trong trường hợp không có sẵn đủ số lượng cổ phiếu mà bạn yêu cầu, 
thì lệnh sẽ được thực hiện với số lượng tối đa có thể đáp ứng được trên thị trường.

Limit order: Lệnh mua/bán với giá giới hạn. Bạn chỉ muốn mua/bán chứng khoán với giá mà bạn muốn, 
thay vì giá thị trường hiện tại. Lệnh mua sẽ được thực hiện với giá thấp hơn hoặc bằng giá giới hạn, 
còn lệnh bán sẽ được thực hiện với giá cao hơn hoặc bằng giá giới hạn.

Stop order: Lệnh mua/bán chỉ được thực hiện khi giá chứng khoán đạt đến mức giá xác định trước đó. 
Lệnh mua sẽ được thực hiện khi giá chứng khoán vượt qua giá stop, 
còn lệnh bán sẽ được thực hiện khi giá chứng khoán giảm dưới mức giá stop. 
Lệnh stop order thường được sử dụng để giảm thiểu rủi ro khi giao dịch, 
đặc biệt là trong các thị trường dao động mạnh.
*/
CREATE TABLE orders (
    order_id INT PRIMARY KEY IDENTITY(1,1), -- ID đơn hàng / lệnh
    user_id INT FOREIGN KEY REFERENCES users(user_id), -- ID người dùng
    stock_id INT FOREIGN KEY REFERENCES stocks(stock_id), -- ID cổ phiếu
    order_type NVARCHAR(20), -- Loại đơn hàng (ví dụ: market, limit, stop)
    direction NVARCHAR(20), -- Hướng (ví dụ: buy, sell)
    quantity INT, -- Số lượng
    price DECIMAL(18, 4), -- Giá
    status NVARCHAR(20), -- Trạng thái (ví dụ: pending, executed, canceled)
    order_date DATETIME -- Ngày đặt hàng
);
-- Portfolios table (Bảng danh mục đầu tư)
CREATE TABLE portfolios (
    user_id INT FOREIGN KEY REFERENCES users(user_id), -- ID người dùng
    stock_id INT, -- ID cổ phiếu
    quantity INT, -- Số lượng
    purchase_price DECIMAL(18, 4), -- Giá mua
    purchase_date DATETIME -- Ngày mua
);

ALTER TABLE portfolios
ADD CONSTRAINT FK_Portfolios_Stocks
FOREIGN KEY (stock_id)
REFERENCES stocks (stock_id);

/*
Thông báo:
order_executed: Thông báo khi một đơn hàng mua hoặc bán chứng khoán đã được thực hiện thành công hoặc thất bại.
price_alert: Thông báo khi giá của một cổ phiếu đạt đến một ngưỡng giá mà người dùng đã thiết lập trước đó.
news_event: Thông báo về các sự kiện, tin tức mới liên quan đến các cổ phiếu trong danh mục đầu tư của người dùng.
*/
CREATE TABLE notifications (
    notification_id INT PRIMARY KEY IDENTITY(1,1), -- ID thông báo
    user_id INT FOREIGN KEY REFERENCES users(user_id), -- ID người dùng
    notification_type NVARCHAR(50), -- Loại thông báo (ví dụ: order_executed, price_alert, news_event)
    content TEXT NOT NULL, -- Nội dung thông báo
    is_read BIT DEFAULT 0, -- Đánh dấu đã đọc hay chưa đọc (1: đã đọc, 0: chưa đọc)
    created_at DATETIME -- Thời điểm tạo thông báo
);
CREATE TABLE educational_resources (
    resource_id INT PRIMARY KEY IDENTITY(1,1), -- ID tài liệu
    title NVARCHAR(255) NOT NULL, -- Tiêu đề
    content TEXT NOT NULL, -- Nội dung
    category NVARCHAR(100), -- Danh mục (ví dụ: đầu tư, chiến lược giao dịch, quản lý rủi ro)
    date_published DATETIME -- Ngày xuất bản
);
-- Linked bank accounts table (Bảng tài khoản ngân hàng liên kết)
/*
Routing number (mã số định tuyến) là một mã số được sử dụng để xác định một ngân hàng tại Hoa Kỳ. 
Mã số này gồm 9 chữ số và thường được sử dụng để thực hiện các giao dịch liên ngân hàng, 
chẳng hạn như chuyển khoản ngân hàng hoặc thanh toán bằng séc. Mỗi ngân hàng sẽ có một mã số định tuyến riêng, 
giúp cho việc xác định và phân loại các giao dịch được thực hiện giữa các ngân hàng trở nên dễ dàng hơn.
*/
CREATE TABLE linked_bank_accounts (
    account_id INT PRIMARY KEY IDENTITY(1,1), -- ID tài khoản
    user_id INT FOREIGN KEY REFERENCES users(user_id), -- ID người dùng
    bank_name NVARCHAR(255) NOT NULL, -- Tên ngân hàng
    account_number NVARCHAR(50) NOT NULL, -- Số tài khoản
    routing_number NVARCHAR(50), -- Số định tuyến
    account_type NVARCHAR(50) -- Loại tài khoản (ví dụ: checking, savings)
);
GO
/*
Khi một order được tạo ra, các bảng sau sẽ bị thay đổi:
Bảng orders: Sẽ thêm một bản ghi mới đại diện cho đơn hàng mới được tạo ra.

Bảng portfolios: Nếu đơn hàng là loại mua (buy), số lượng cổ phiếu tương ứng sẽ được thêm vào 
danh mục đầu tư của người dùng; 
nếu đơn hàng là loại bán (sell), số lượng cổ phiếu tương ứng sẽ bị trừ đi từ danh mục đầu tư của người dùng.

Bảng notifications: Một thông báo mới có thể được tạo ra để thông báo cho người dùng về việc 
đơn hàng đã được thực hiện thành công hoặc thất bại.

Bảng transactions: Nếu đơn hàng là loại mua (buy), 
một giao dịch mới sẽ được thêm vào bảng này để đại diện cho số tiền 
được rút ra từ tài khoản ngân hàng của người dùng và chuyển đến sàn giao dịch; 
nếu đơn hàng là loại bán (sell), 
một giao dịch mới sẽ được thêm vào bảng này để đại diện cho số tiền được 
chuyển từ sàn giao dịch đến tài khoản ngân hàng của người dùng.
*/
CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY IDENTITY(1,1), -- ID giao dịch
    user_id INT FOREIGN KEY REFERENCES users(user_id), -- ID người dùng
    linked_account_id INT FOREIGN KEY REFERENCES linked_bank_accounts(account_id), -- ID tài khoản liên kết
    transaction_type NVARCHAR(50), -- Loại giao dịch (ví dụ: deposit, withdrawal)
    amount DECIMAL(18, 2), -- Số tiền
    transaction_date DATETIME -- Ngày giao dịch
);

SELECT * FROM users;

SELECT HASHBYTES('SHA2_256', '123456');

DELETE FROM users WHERE user_id=1;
GO
--DROP TABLE users; --cân nhắc kỹ với bảng có data

--INSERT INTO users (username, hashed_password, email, phone, full_name, date_of_birth, country)
--VALUES ('nguyenhuy', HASHBYTES('SHA2_256', '123456'),'nguyenhuy@example.com', '012345678', N'Nguyễn Văn Huy','1990-12-31', N'Việt Nam');

--create procedures
/*
username NVARCHAR(100) UNIQUE NOT NULL, -- Tên đăng nhập
    hashed_password NVARCHAR(200) NOT NULL,--mật khẩu được mã hóa
    email NVARCHAR(255) UNIQUE NOT NULL, -- Email
    phone NVARCHAR(20) NOT NULL, -- Số điện thoại
    full_name NVARCHAR(255), -- Họ và tên
    date_of_birth DATE, -- Ngày sinh
    country NVARCHAR(200) -- Quốc gia
*/
/*
DROP PROCEDURE dbo.RegisterUser; 
GO
*/
CREATE PROCEDURE dbo.RegisterUser
    @username NVARCHAR(200),
    @password NVARCHAR(100),
    @email NVARCHAR(255),
    @phone NVARCHAR(20),
    @full_name NVARCHAR(255),
    @date_of_birth DATE,
    @country NVARCHAR(200)
AS
BEGIN
    INSERT INTO users (username, hashed_password, email, phone, full_name, date_of_birth, country)
    VALUES (@username, HASHBYTES('SHA2_256', @password), @email, @phone, @full_name, @date_of_birth, @country);
END;
GO
--Thêm các bản ghi vào bảng users sử dụng procedures
EXEC RegisterUser 'tranphuong', 'password_2', N'tranphuong@example.com', N'0987654321', N'Trần Thị Phương', '1992-02-15', N'Việt Nam';
EXEC RegisterUser 'leminh', 'password_3', N'leminh@example.com', N'0123412345', N'Lê Văn Minh', '1985-05-30', N'Việt Nam';
EXEC RegisterUser 'phamtuan', 'password_4', N'phamtuan@example.com', N'0987123456', N'Phạm Đức Tuấn', '1995-07-18', N'Việt Nam';
EXEC RegisterUser 'hoangle', 'password_5', N'hoangle@example.com', N'0123987654', N'Hoàng Thị Lệ', '1993-03-29', N'Việt Nam';
EXEC RegisterUser 'nguyentung', 'password_6', N'nguyentung@example.com', N'0987345678', N'Nguyễn Văn Tùng', '1988-09-12', N'Việt Nam';
EXEC RegisterUser 'vuthilinh', 'password_7', N'vuthilinh@example.com', N'0123654321', N'Vũ Thị Linh', '1991-11-06', N'Việt Nam';
EXEC RegisterUser 'doquang', 'password_8', N'doquang@example.com', N'0987212345', N'Đỗ Văn Quang', '1997-06-24', N'Việt Nam';
EXEC RegisterUser 'phamthanh', 'password_9', N'phamthanh@example.com', N'0123898765', N'Phạm Thị Thanh', '1994-12-31', N'Việt Nam';
EXEC RegisterUser 'nguyenbao', 'password_10', N'nguyenbao@example.com', N'0987456789', N'Nguyễn Thị Bảo', '1996-08-05', N'Việt Nam';
GO

--SELECT * FROM users;
--kiểm tra login
/*
DROP PROCEDURE dbo.CheckLogin; 
GO
*/
CREATE PROCEDURE dbo.CheckLogin
    @Email NVARCHAR(50),
    @password NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @HashedPassword VARBINARY(32)
    SET @HashedPassword = HASHBYTES('SHA2_256', @Password);    
    BEGIN
        SELECT * FROM users WHERE Email IN
        (SELECT email FROM users WHERE email = @Email AND hashed_password = @HashedPassword);
    END    
END;
GO

EXEC dbo.CheckLogin N'phamtuan@example.com', 'password_4';
SELECT * FROM stocks;
--dữ liệu Fake, chỉ dùng cho mục đích học SQL Server
INSERT INTO stocks (symbol, company_name, market_cap, sector, industry, stock_type, sector_en, industry_en)
VALUES 
('VNM', N'Vinamilk', 200000000000, N'Thực phẩm', N'Sữa và sản phẩm sữa', 'Common Stock', 'Food', 'Dairy Products'),
('VIC', N'Vingroup', 180000000000, N'Bất động sản', N'Phát triển bất động sản', 'Common Stock', 'Real Estate', 'Real Estate Development'),
('VHM', N'Vinhomes', 170000000000, N'Bất động sản', N'Phát triển bất động sản', 'Common Stock', 'Real Estate', 'Real Estate Development'),
('BID', N'BIDV', 150000000000, N'Ngân hàng', N'Ngân hàng thương mại', 'Common Stock', 'Banking', 'Commercial Banks'),
('CTG', N'VietinBank', 140000000000, N'Ngân hàng', N'Ngân hàng thương mại', 'Common Stock', 'Banking', 'Commercial Banks'),
('MSN', N'Masan Group', 130000000000, N'Thực phẩm', N'Chế biến thực phẩm', 'Common Stock', 'Food', 'Food Processing'),
('MWG', N'Mobile World', 120000000000, N'Bán lẻ', N'Bán lẻ điện tử', 'Common Stock', 'Retail', 'Electronics Retailing'),
('FPT', N'FPT Corporation', 110000000000, N'Công nghệ', N'Phần mềm và dịch vụ', 'Common Stock', 'Technology', 'Software and Services'),
('GAS', N'PetroVietnam Gas', 100000000000, N'Năng lượng', N'Khí và dịch vụ liên quan', 'Common Stock', 'Energy', 'Gas and Related Services'),
('VPB', N'VPBank', 90000000000, N'Ngân hàng', N'Ngân hàng thương mại', 'Common Stock', 'Banking', 'Commercial Banks'),
('REE', N'REE Corporation', 80000000000, N'Cơ khí', N'Sản xuất thiết bị điện', 'Common Stock', 'Mechanical Engineering', 'Electrical Equipment Manufacturing'),
('HDB', N'HDBank', 70000000000, N'Ngân hàng', N'Ngân hàng thương mại', 'Common Stock', 'Banking', 'Commercial Banks'),
('SSI', N'SSI Securities', 60000000000, N'Chứng khoán', N'Dịch vụ chứng khoán', 'Common Stock', 'Securities', 'Securities Services'),
('VRE', N'Vincom Retail', 45000000000, N'Bất động sản', N'Phát triển bất động sản', 'Common Stock', 'Real Estate', 'Real Estate Development'),
('EIB', N'Eximbank', 50000000000, N'Ngân hàng', N'Ngân hàng thương mại', 'Banking', 'Commercial Banking', 'Common Stock'),
('VJC', N'Vietjet Air', 40000000000, N'Hàng không', N'Hãng hàng không', 'Airline', 'Airline Services', 'Common Stock'),
('VCB', N'Vietcombank', 160000000000, N'Ngân hàng', N'Ngân hàng thương mại', 'Banking', 'Commercial Banking', 'Common Stock'),
('STB', N'Sacombank', 35000000000, N'Ngân hàng', N'Ngân hàng thương mại', 'Banking', 'Commercial Banking', 'Common Stock'),
('VIB', N'Vietnam International Bank', 30000000000, N'Ngân hàng', N'Ngân hàng thương mại', 'Banking', 'Commercial Banking', 'Common Stock'),
('FMETF1', N'FinMart ETF 1', 25000000000, N'Quỹ đầu tư', N'Quỹ đầu tư chứng khoán', 'ETF', 'Investment Fund', 'ETF'),
('FMETF3', N'FinMart ETF 3', 15000000000, N'Quỹ đầu tư', N'Quỹ đầu tư chứng khoán', 'ETF', 'Investment Fund', 'ETF'),
('SMCP1', N'SmartCorp Preferred 1', 1000000000, N'Công nghệ', N'Phần mềm và dịch vụ', 'Preferred Stock', 'Preferred Stock', 'Preferred Stock'),
('SMCP2', N'SmartCorp Preferred 2', 800000000, N'Công nghệ', N'Phần mềm và dịch vụ', 'Preferred Stock', 'Preferred Stock', 'Preferred Stock'),
('SMCP3', N'SmartCorp Preferred 3', 600000000, N'Công nghệ', N'Phần mềm và dịch vụ', 'Preferred Stock', 'Preferred Stock', 'Preferred Stock'),
('GSCP1', N'GreenSolar Preferred 1', 400000000, N'Năng lượng', N'Năng lượng tái tạo', 'Preferred Stock', 'Preferred Stock', 'Preferred Stock'),
('GSCP2', N'GreenSolar Preferred 2', 200000000, N'Năng lượng', N'Năng lượng tái tạo', 'Preferred Stock', 'Preferred Stock', 'Preferred Stock'),
('GSCP3', N'GreenSolar Preferred 3', 100000000, N'Năng lượng', N'Năng lượng tái tạo', 'Preferred Stock', 'Preferred Stock', 'Preferred Stock'),
('GSCP4', N'GreenSolar Preferred 4', 50000000, N'Năng lượng', N'Năng lượng tái tạo', 'Preferred Stock', 'Preferred Stock', 'Preferred Stock');
GO

--SELECT * FROM quotes;
INSERT INTO quotes (stock_id, price, change, percent_change, volume, time_stamp)
VALUES
(1, 100.50, 1.50, 1.5, 10000, '2022-04-10 10:00:00'),
(2, 200.25, -0.75, -0.37, 15000, '2022-04-10 10:00:00'),
(3, 300.75, 0.75, 0.25, 8000, '2022-04-10 10:00:00'),
(4, 150.20, -0.50, -0.33, 12000, '2022-04-10 10:00:00'),
(5, 75.50, 1.25, 1.67, 9000, '2022-04-10 10:00:00'),
(1, 99.75, -0.50, -0.50, 13000, '2022-04-10 11:00:00'),
(2, 200.50, 1.25, 0.62, 9000, '2022-04-10 11:00:00'),
(3, 301.50, 0.75, 0.25, 11000, '2022-04-10 11:00:00'),
(4, 150.50, 1.25, 0.84, 8000, '2022-04-10 11:00:00'),
(5, 74.75, -0.75, -0.99, 6000, '2022-04-10 11:00:00');
GO

--SELECT * FROM market_indices;
--dữ liệu Fake, chỉ dùng cho mục đích học SQL Server
INSERT INTO market_indices (name, symbol)
VALUES
('FinMart Composite Index', 'FMCI'),
('FinMart Technology Index', 'FMTI'),
('FinMart Financials Index', 'FMFI'),
('FinMart Healthcare Index', 'FMHI'),
('FinMart Industrials Index', 'FMII'),
('FinMart Consumer Goods Index', 'FMCGI'),
('FinMart Consumer Services Index', 'FMCSI'),
('FinMart Oil & Gas Index', 'FMOGI'),
('FinMart Basic Materials Index', 'FMBMI'),
('FinMart Utilities Index', 'FMUI'),

('InvestMart 100 Index', 'IM100'),
('InvestMart MidCap Index', 'IMMC'),
('InvestMart SmallCap Index', 'IMSC'),
('InvestMart Growth Index', 'IMG'),
('InvestMart Value Index', 'IMV'),
('InvestMart Technology Index', 'IMTI'),
('InvestMart Financials Index', 'IMFI'),
('InvestMart Healthcare Index', 'IMHI'),
('InvestMart Industrials Index', 'IMII'),
('InvestMart Consumer Goods Index', 'IMCGI'),

('TradeMart Top 50 Index', 'TM50'),
('TradeMart Top 100 Index', 'TM100'),
('TradeMart Top 200 Index', 'TM200'),
('TradeMart Technology Index', 'TMTI'),
('TradeMart Financials Index', 'TMFI'),
('TradeMart Healthcare Index', 'TMHI'),
('TradeMart Industrials Index', 'TMII'),
('TradeMart Consumer Goods Index', 'TMCGI'),
('TradeMart Consumer Services Index', 'TMCSI'),
('TradeMart Utilities Index', 'TMUI');
GO

--SELECT * FROM market_indices ORDER BY name DESC;
--SELECT * FROM index_constituents;
INSERT INTO index_constituents (index_id, stock_id)
VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(2, 7),
(2, 8),
(2, 9),
(2, 10),
(2, 11),
(2, 12),
(3, 13),
(3, 14),
(3, 15),
(3, 16),
(3, 17),
(3, 18),
(4, 19),
(4, 20),
(4, 21),
(4, 22),
(4, 23),
(4, 24),
(5, 25),
(5, 26),
(5, 27),
(5, 28);
GO
SELECT * FROM stocks;
SELECT * FROM index_constituents;
SELECT * FROM market_indices;
GO;
--USE StockApp;
--Đây chỉ là fake data, phục vụ việc học SQL Server
--DROP VIEW v_stock_index; GO
CREATE VIEW v_stock_index AS
SELECT 
    s.stock_id,
    s.symbol,
    s.company_name,
    s.market_cap,
    s.sector_en,
    s.sector,
    s.industry_en,
    s.industry,
    s.stock_type,
    i.index_id,
    m.symbol AS index_symbol,
    m.name AS index_name    
FROM stocks AS s
INNER JOIN index_constituents AS i
ON s.stock_id = i.stock_id
INNER JOIN market_indices AS m
ON m.index_id = i.index_id;
GO;
--Đây chỉ là fake data, phục vụ việc học SQL Server
SELECT 
    v.index_symbol,
    v.index_name,
    v.symbol AS stock_symbol,
    v.company_name 
FROM v_stock_index AS v
--WHERE v.index_symbol = 'FMII'
ORDER BY v.index_symbol;
GO

SELECT 
    v.index_symbol, 
    v.index_name, 
    COUNT(DISTINCT v.company_name) AS total_companies
FROM v_stock_index AS v
GROUP BY v.index_symbol, v.index_name
ORDER BY v.index_symbol;

--Đây chỉ là fake data, phục vụ việc học SQL Server
SELECT count(*) AS total_companies
FROM v_stock_index
WHERE market_cap > 30000000000;

SELECT 
    v.symbol, 
    FORMAT(v.market_cap, '#,##0')
FROM v_stock_index AS v;

--SELECT * FROM derivatives;
INSERT INTO derivatives (name, underlying_asset_id, contract_size, expiration_date,
strike_price, last_price, change, percent_change, open_price, high_price, low_price, volume, open_interest, time_stamp)
VALUES
('S&P 500 Index Options', 1, 50, '2023-06-17', 4000, 41.25, -1.25, -2.94, 42.50, 43.75, 40.00, 12000, 500, '2023-04-12 09:30:00'),
('Crude Oil Futures', 2, 1000, '2023-05-20', 67.50, 70.00, 1.25, 1.82, 68.75, 71.50, 67.25, 25000, 1500, '2023-04-12 09:30:00'),
('Eurodollar Futures', 3, 1000000, '2023-09-15', 98.00, 97.80, -0.02, -0.02, 97.90, 98.05, 97.70, 5000, 10000, '2023-04-12 09:30:00'),
('Gold Futures', 4, 100, '2023-07-28', 1800.00, 1765.00, -5.50, -0.31, 1770.50, 1780.25, 1760.50, 1000, 500, '2023-04-12 09:30:00'),
('Natural Gas Futures', 5, 10000, '2023-08-25', 3.00, 2.95, -0.10, -3.28, 3.05, 3.10, 2.90, 15000, 2000, '2023-04-12 09:30:00'),
('Silver Futures', 4, 5000, '2023-06-30', 28.00, 27.75, -0.05, -0.18, 27.80, 28.25, 27.50, 500, 250, '2023-04-12 09:30:00'),
('Derivative 1', 1, 100, '2023-05-01', 50.00, 55.00, 5.00, 9.09, 50.00, 60.00, 45.00, 10000, 5000, GETDATE()),
('Derivative 2', 2, 200, '2023-06-01', 100.00, 110.00, 10.00, 9.09, 100.00, 120.00, 90.00, 20000, 10000, GETDATE()),
('Derivative 3', 3, 150, '2023-07-01', 75.00, 80.00, 5.00, 6.25, 75.00, 90.00, 60.00, 15000, 7500, GETDATE()),
('Derivative 4', 4, 250, '2023-08-01', 125.00, 130.00, 5.00, 4.00, 125.00, 140.00, 110.00, 25000, 12500, GETDATE()),
('Derivative 5', 5, 175, '2023-09-01', 87.50, 90.00, 2.50, 2.86, 87.50, 100.00, 75.00, 17500, 8750, GETDATE()),
('Derivative 6', 6, 125, '2023-10-01', 62.50, 70.00, 7.50, 12.00, 62.50, 80.00, 45.00, 12500, 6250, GETDATE()),
('Derivative 7', 7, 300, '2023-11-01', 150.00, 160.00, 10.00, 6.67, 150.00, 170.00, 130.00, 30000, 15000, GETDATE()),
('Derivative 8', 8, 225, '2023-12-01', 112.50, 115.00, 2.50, 2.22, 112.50, 130.00, 95.00, 22500, 11250, GETDATE()),
('Derivative 9', 9, 175, '2024-01-01', 87.50, 85.00, -2.50, -2.86, 87.50, 100.00, 75.00, 17500, 8750, GETDATE());
GO

SELECT 
    d.underlying_asset_id, 
    d.name    
FROM derivatives AS d
ORDER BY underlying_asset_id;
GO

DROP VIEW v_stocks_derivatives; 
GO

CREATE VIEW v_stocks_derivatives 
AS
SELECT 
    s.*,
    d.*
FROM stocks s
INNER JOIN derivatives d ON d.underlying_asset_id = s.stock_id;
GO

SELECT * FROM v_stocks_derivatives;

SELECT 
    v.stock_id,
    v.symbol,
    v.company_name,
    v.derivative_id,
    v.name AS derivative_name    
FROM v_stocks_derivatives v
ORDER BY stock_id;

SELECT 
    symbol, 
    company_name, 
    COUNT(derivative_id) AS num_derivatives
FROM v_stocks_derivatives
GROUP BY symbol, company_name;

INSERT INTO covered_warrants (name, underlying_asset_id, issue_date, expiration_date, strike_price, warrant_type)
VALUES
('CW A1 Call', 1, '2021-01-01', '2022-12-31', 50.00, 'Call'),
('CW A1 Put', 1, '2021-01-01', '2022-12-31', 50.00, 'Put'),
('CW A2 Call', 2, '2021-01-15', '2022-11-30', 100.00, 'Call'),
('CW A2 Put', 2, '2021-01-15', '2022-11-30', 100.00, 'Put'),
('CW A3 Call', 3, '2021-02-01', '2022-10-31', 150.00, 'Call'),
('CW A3 Put', 3, '2021-02-01', '2022-10-31', 150.00, 'Put'),
('CW A4 Call', 4, '2021-02-15', '2022-09-30', 200.00, 'Call'),
('CW A4 Put', 4, '2021-02-15', '2022-09-30', 200.00, 'Put'),
('CW A5 Call', 5, '2021-03-01', '2022-08-31', 50.00, 'Call'),
('CW A5 Put', 5, '2021-03-01', '2022-08-31', 50.00, 'Put'),
('CW A6 Call', 6, '2021-03-15', '2022-07-31', 100.00, 'Call'),
('CW A6 Put', 6, '2021-03-15', '2022-07-31', 100.00, 'Put'),
('CW A7 Call', 7, '2021-04-01', '2022-06-30', 150.00, 'Call'),
('CW A7 Put', 7, '2021-04-01', '2022-06-30', 150.00, 'Put'),
('CW A8 Call', 8, '2021-04-15', '2022-05-31', 200.00, 'Call'),
('CW A8 Put', 8, '2021-04-15', '2022-05-31', 200.00, 'Put'),
('CW A9 Call', 9, '2021-05-01', '2022-04-30', 50.00, 'Call'),
('CW A9 Put', 9, '2021-05-01', '2022-04-30', 50.00, 'Put'),
('CW A10 Call', 10, '2021-05-15', '2022-03-31', 100.00, 'Call'),
('CW A10 Put', 10, '2021-05-15', '2022-03-31', 100.00, 'Put'),
('CW B1 Call', 11, '2021-06-01', '2022-02-28', 150.00, 'Call'),
('CW B2 Call', 12, '2021-06-15', '2022-01-31', 200.00, 'Call'),
('CW B2 Put', 12, '2021-06-15', '2022-01-31', 200.00, 'Put'),
('CW B3 Call', 13, '2021-07-01', '2021-12-31', 50.00, 'Call'),
('CW B3 Put', 13, '2021-07-01', '2021-12-31', 50.00, 'Put'),
('CW B4 Call', 14, '2021-07-15', '2021-11-30', 100.00, 'Call'),
('CW B4 Put', 14, '2021-07-15', '2021-11-30', 100.00, 'Put'),
('CW B5 Call', 15, '2021-08-01', '2021-10-31', 150.00, 'Call'),
('CW B5 Put', 15, '2021-08-01', '2021-10-31', 150.00, 'Put'),
('CW B6 Call', 16, '2021-08-15', '2021-09-30', 200.00, 'Call');
GO

SELECT * FROM covered_warrants;

SELECT 'Sell' AS order_type, COUNT(*) AS num_orders
FROM covered_warrants
WHERE warrant_type = 'Call'
UNION ALL
SELECT 'Buy' AS order_type, COUNT(*) AS num_orders
FROM covered_warrants
WHERE warrant_type = 'Put';

--Đây chỉ là fake data, phục vụ việc học SQL Server
--TRUNCATE TABLE etfs;
--SELECT * FROM etfs;

--SELECT * FROM stocks;
TRUNCATE TABLE stocks;

SELECT name, OBJECT_NAME(parent_object_id) AS table_name
FROM sys.foreign_keys
WHERE referenced_object_id = OBJECT_ID('stocks')

ALTER TABLE quotes
DROP CONSTRAINT FK__quotes__stock_id__44FF419A;

/*

ALTER TABLE orders
DROP CONSTRAINT FK__orders__stock_id__5DCAEF64;

ALTER TABLE portfolios
DROP CONSTRAINT FK__portfolio__stock__619B8048;
*/
TRUNCATE TABLE stocks;
SELECT * FROM stocks WHERE stock_type='etf' AND sector_en='food';

SELECT * FROM stocks WHERE company_name LIKE '%group%' AND market_cap > 900000000;