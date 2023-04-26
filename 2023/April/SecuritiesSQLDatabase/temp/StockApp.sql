
USE master;
GO
DROP DATABASE StockApp;
GO

IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'StockApp')
    CREATE DATABASE StockApp;
GO
USE StockApp;
-- Users table (Bảng người dùng)
CREATE TABLE users (
    user_id INT PRIMARY KEY IDENTITY(1,1), -- ID người dùng
    username NVARCHAR(50) UNIQUE NOT NULL, -- Tên đăng nhập
    hashed_password NVARCHAR(255) COLLATE Latin1_General_BIN NOT NULL,
    email NVARCHAR(255) UNIQUE NOT NULL, -- Email
    phone NVARCHAR(20) NOT NULL, -- Số điện thoại
    full_name NVARCHAR(255), -- Họ và tên
    date_of_birth DATE, -- Ngày sinh
    country NVARCHAR(255) -- Quốc gia
);

--EXEC sp_help 'users';

CREATE TABLE user_devices (
    id INT PRIMARY KEY IDENTITY,
    user_id INT NOT NULL,
    device_id NVARCHAR(255) NOT NULL,
    token NVARCHAR(255) NOT NULL,
    token_expiration DATETIME NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
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
    stock_type NVARCHAR(50)
    --Common Stock (Cổ phiếu thường),Preferred Stock (Cổ phiếu ưu đãi),ETF (Quỹ Đầu Tư Chứng Khoán): 
);


CREATE TABLE top_stocks (
    stock_id INT PRIMARY KEY REFERENCES stocks(stock_id), -- ID của cổ phiếu
    rank INT NOT NULL, -- Thứ hạng trong danh sách top stocks
    reason NVARCHAR(255) -- Nguyên nhân khiến cổ phiếu được đưa vào danh sách top stocks
);

--Bảng quotes chứa thông tin về giá cổ phiếu trong thời gian thực
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

--SELECT * FROM view_quotes_realtime;
--SELECT * FROM stocks;

CREATE TABLE market_indices (
    index_id INT PRIMARY KEY IDENTITY,
    name NVARCHAR(255) NOT NULL,
    symbol NVARCHAR(50) UNIQUE NOT NULL
);

--index_constituents: là danh sách các công ty đã được chọn để 
--tính toán chỉ số của một chỉ số thị trường chứng khoán nhất định. 
CREATE TABLE index_constituents (
    index_id INT FOREIGN KEY REFERENCES market_indices(index_id),
    stock_id INT FOREIGN KEY REFERENCES stocks(stock_id)
);

CREATE TABLE derivatives (
    derivative_id INT PRIMARY KEY IDENTITY, -- ID của chứng khoán phái sinh
    name NVARCHAR(255) NOT NULL, -- Tên của chứng khoán phái sinh
    underlying_asset_id INT FOREIGN KEY REFERENCES stocks(stock_id), -- ID của tài sản cơ bản mà chứng khoán phái sinh được dựa trên
    contract_size INT, -- Kích thước hợp đồng (số lượng tài sản cơ bản trong một hợp đồng phái sinh)
    --Contract size khác nhau cho từng sản phẩm tài chính, 
    --ví dụ như trong thị trường forex, contract size được tính theo số lượng lot, 
    --trong khi đó ở thị trường hàng hóa, contract size được tính theo khối lượng hoặc số lượng sản phẩm tài chính.
    expiration_date DATE, -- Ngày hết hạn của hợp đồng phái sinh
    strike_price DECIMAL(18, 4), -- Giá thực hiện (giá mà người mua chứng khoán phái sinh có quyền mua/bán tài sản cơ bản)
    -- Strike price thường được đặt ở một mức giá gần bằng với giá thị trường của tài sản cơ bản 
    -- để tăng khả năng tùy chọn sẽ được sử dụng.
    last_price DECIMAL(18, 2) NOT NULL,
    change DECIMAL(18, 2) NOT NULL,
    percent_change DECIMAL(18, 2) NOT NULL,
    open_price DECIMAL(18, 2) NOT NULL,
    high_price DECIMAL(18, 2) NOT NULL,
    low_price DECIMAL(18, 2) NOT NULL,
    volume INT NOT NULL,
    open_interest INT NOT NULL,
    time_stamp DATETIME NOT NULL
);
/*
last_price: Giá cuối cùng giao dịch thành công của chứng khoán phái sinh.
change: Biến động giá so với giá cuối cùng của phiên trước đó.
percent_change: Tỷ lệ biến động giá so với giá cuối cùng của phiên trước đó.
open_price: Giá mở cửa của phiên giao dịch hiện tại.
high_price: Giá cao nhất của phiên giao dịch hiện tại.
low_price: Giá thấp nhất của phiên giao dịch hiện tại.
volume: Khối lượng giao dịch trong phiên giao dịch hiện tại.
open_interest: Số hợp đồng phái sinh còn đang mở.
time_stamp: Thời điểm cập nhật giá chứng khoán phái sinh.
*/
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
CREATE TABLE watchlists (
    user_id INT FOREIGN KEY REFERENCES users(user_id), -- ID người dùng
    stock_id INT FOREIGN KEY REFERENCES stocks(stock_id) -- ID cổ phiếu
);
-- Orders table (Bảng đơn hàng)
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
    order_id INT PRIMARY KEY IDENTITY(1,1), -- ID đơn hàng
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
    stock_id INT FOREIGN KEY REFERENCES stocks(stock_id), -- ID cổ phiếu
    quantity INT, -- Số lượng
    purchase_price DECIMAL(18, 4), -- Giá mua
    purchase_date DATETIME -- Ngày mua
);
/*
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

CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY IDENTITY(1,1), -- ID giao dịch
    user_id INT FOREIGN KEY REFERENCES users(user_id), -- ID người dùng
    linked_account_id INT FOREIGN KEY REFERENCES linked_bank_accounts(account_id), -- ID tài khoản liên kết
    transaction_type NVARCHAR(50), -- Loại giao dịch (ví dụ: deposit, withdrawal)
    amount DECIMAL(18, 2), -- Số tiền
    transaction_date DATETIME -- Ngày giao dịch
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

--create procedures

CREATE PROCEDURE RegisterUser
    @username NVARCHAR(50),
    @password NVARCHAR(255),
    @email NVARCHAR(255),
    @phone NVARCHAR(20),
    @full_name NVARCHAR(255),
    @date_of_birth DATE,
    @country NVARCHAR(255)
AS
BEGIN
    INSERT INTO users (username, hashed_password, email, phone, full_name, date_of_birth, country)
    VALUES (@username, HASHBYTES('SHA2_256', @password), @email, @phone, @full_name, @date_of_birth, @country);
END;
GO
--DROP PROCEDURE dbo.CheckLogin;
CREATE PROCEDURE dbo.CheckLogin
    @Email NVARCHAR(50),
    @Password NVARCHAR(50)
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

--EXEC dbo.CheckLogin N'nguyenhuy@example.com', 'password_1';

CREATE TRIGGER order_trigger
ON orders
AFTER INSERT
AS
BEGIN
    DECLARE @stock_quantity INT
    DECLARE @transaction_amount DECIMAL(10,2)
    DECLARE @user_id INT
    DECLARE @order_id INT
    DECLARE @status NVARCHAR(50)
    DECLARE @order_type NVARCHAR(50)

    -- Get the stock quantity and transaction amount based on order type
    SELECT @stock_quantity = CASE WHEN order_type = 'buy' THEN inserted.quantity ELSE -inserted.quantity END,
           @transaction_amount = CASE WHEN order_type = 'buy' THEN inserted.quantity * inserted.price ELSE -inserted.quantity * inserted.price END,
           @user_id = inserted.user_id,
           @order_id = inserted.order_id,
           @status = inserted.status,
           @order_type = inserted.order_type
    FROM inserted

    -- Update the user's portfolio
    UPDATE portfolios
    SET quantity = quantity + @stock_quantity
    WHERE user_id = @user_id AND stock_id IN (SELECT stock_id FROM inserted);

    -- Create a new notification
    INSERT INTO notifications (user_id, notification_type, content)
    VALUES (@user_id, 'order', CONCAT('Order ', @order_id, ' has been ', @status));

    -- Add a new transaction record
    INSERT INTO transactions (user_id, amount, transaction_type)
    VALUES (@user_id, @transaction_amount, @order_type);
END;
GO


-- Tính tổng số lượng cổ phiếu của một người dùng trong danh mục đầu tư
CREATE FUNCTION fn_GetTotalSharesInPortfolio
(
@user_id INT
)
RETURNS INT
AS
BEGIN
    DECLARE @totalShares INT;
    SELECT @totalShares = SUM(quantity)
    FROM portfolios
    WHERE user_id = @user_id;
    RETURN @totalShares;
END;
GO

--DROP VIEW view_quotes_realtime;

CREATE VIEW view_quotes_realtime AS
SELECT DISTINCT
    q.quote_id,
    s.symbol,
    s.company_name,
    m.name as index_name,
    m.symbol as index_symbol,
    s.market_cap,
    s.sector_en,
    s.industry_en,
    s.sector,
    s.industry,
    s.stock_type,
    q.price,
    q.change,
    q.percent_change,
    q.volume,
    q.time_stamp    
FROM quotes q
INNER JOIN stocks s ON q.stock_id = s.stock_id
INNER JOIN index_constituents i ON s.stock_id = i.stock_id
INNER JOIN market_indices m ON i.index_id = m.index_id
WHERE q.time_stamp >= (SELECT MAX(time_stamp) FROM quotes WHERE stock_id = q.stock_id);
GO
--insert data
USE StockApp;
GO
EXEC RegisterUser 'nguyenhuy', 'password_1', N'nguyenhuy@example.com', N'0123456789', N'Nguyễn Văn Huy', '1990-01-01', N'Việt Nam';
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

-- Thêm dữ liệu fake vào bảng quotes
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

INSERT INTO etfs (name, symbol, management_company, inception_date)
VALUES
('VN30 ETF', 'VN30', 'Vinacapital', '2010-06-01'),
('VN100 ETF', 'VN100', 'Dragon Capital', '2012-03-20'),
('VN Small Cap ETF', 'VNSC', 'BaoViet', '2013-08-15'),
('VN Mid Cap ETF', 'VNMC', 'SSI', '2014-12-10'),
('VN Large Cap ETF', 'VNLC', 'Techcombank', '2015-02-28'),
('VN Financials ETF', 'VNFI', 'VPBank', '2016-05-15'),
('VN Real Estate ETF', 'VNRE', 'MBBank', '2017-09-20'),
('VN Consumer Discretionary ETF', 'VNCN', 'VietinBank', '2018-01-01'),
('VN Utilities ETF', 'VNU', 'ACB', '2018-06-30'),
('VN Industrials ETF', 'VNI', 'Sacombank', '2019-03-20'),
('VN Materials ETF', 'VNM', 'Eximbank', '2019-10-15'),
('VN Health Care ETF', 'VNHC', 'Vietcombank', '2020-02-20'),
('VN Technology ETF', 'VNT', 'BIDV', '2020-07-01'),
('VN Telecommunications ETF', 'VNTC', 'Agribank', '2021-01-15'),
('VN Energy ETF', 'VNE', 'Viet Capital', '2021-05-30'),
('VN Consumer Staples ETF', 'VNCS', 'Asia Commercial Bank', '2021-08-15'),
('VN Information Technology ETF', 'VNIT', 'Saigon-Hanoi Bank', '2021-12-01'),
('VN30 2x Leveraged ETF', 'VN30L', 'Vinacapital', '2012-03-01'),
('VN100 2x Leveraged ETF', 'VN100L', 'Dragon Capital', '2013-09-15'),
('VN Small Cap 2x Leveraged ETF', 'VNSCL', 'BaoViet', '2014-02-20'),
('VN Mid Cap 2x Leveraged ETF', 'VNMC2', 'SSI', '2015-05-01'),
('VN Large Cap 2x Leveraged ETF', 'VNLC2', 'Techcombank', '2016-06-15'),
('VN Financials 2x Leveraged ETF', 'VNFI2', 'VPBank', '2017-11-01'),
('VN Real Estate 2x Leveraged ETF', 'VNRE2', 'MBBank', '2018-03-20'),
('VN Consumer Discretionary 2x Leveraged ETF', 'VNCN2', 'VietinBank', '2019-07-01'),
('VN Utilities 2x Leveraged ETF', 'VNU2', 'ACB', '2020-01-15'),
('VN Industrials 2x Leveraged ETF', 'VNI2', 'Sacombank', '2020-05-01'),
('VN Materials 2x Leveraged ETF', 'VNM2', 'Eximbank', '2021-10-15'),
('VN Health Care 2x Leveraged ETF', 'VNHC2', 'Vietcombank', '2022-03-20'),
('VN Telecommunications 2x Leveraged ETF', 'VNTC2', 'Agribank', '2022-08-15'),
('VN Energy 2x Leveraged ETF', 'VNE2', 'Viet Capital', '2022-12-01'),
('VN Consumer Staples 2x Leveraged ETF', 'VNCS2', 'Asia Commercial Bank', '2023-03-20'),
('VN Information Technology 2x Leveraged ETF', 'VNIT2', 'Saigon-Hanoi Bank', '2023-07-01'),
('VN30 Inverse ETF', 'VN30I', 'Vinacapital', '2013-10-15'),
('VN100 Inverse ETF', 'VN100I', 'Dragon Capital', '2014-03-20'),
('VN Small Cap Inverse ETF', 'VNSCI', 'BaoViet', '2015-08-01'),
('VN Mid Cap Inverse ETF', 'VNMI', 'SSI', '2016-01-15'),
('VN Large Cap Inverse ETF', 'VNLI', 'Techcombank', '2016-05-30'),
('VN Financials Inverse ETF', 'VNFI3', 'VPBank', '2017-10-15');
GO

INSERT INTO top_stocks (stock_id, rank, reason)
VALUES
(1, 1, N'Doanh thu tăng trưởng mạnh'),
(3, 2, N'Cổ tức cao'),
(5, 3, N'Sản phẩm mới tiềm năng'),
(7, 4, N'Điều chỉnh chiến lược kinh doanh'),
(9, 5, N'Định giá hấp dẫn');
GO

--ETF holding là các cổ phiếu, trái phiếu hoặc tài sản khác mà một ETF nắm giữ trong danh mục đầu tư của mình.
INSERT INTO etf_holdings (etf_id, stock_id, shares_held, weight)
VALUES
(1, 1, 15000.1234, 0.065),
(1, 2, 23000.6789, 0.057),
(1, 3, 30000.4567, 0.045),
(1, 4, 7500.2345, 0.021),
(1, 5, 12000.7890, 0.038),
(2, 6, 9000.1234, 0.059),
(2, 7, 18000.6789, 0.067),
(2, 8, 22000.4567, 0.055),
(2, 9, 13000.2345, 0.046),
(2, 10, 4000.7890, 0.032),
(3, 11, 11000.1234, 0.029),
(3, 12, 21000.6789, 0.048),
(3, 13, 31000.4567, 0.051),
(3, 14, 15000.2345, 0.043),
(3, 15, 5000.7890, 0.017),
(4, 16, 7000.1234, 0.022),
(4, 17, 17000.6789, 0.040),
(4, 18, 16000.4567, 0.039),
(4, 19, 14000.2345, 0.037),
(4, 20, 3000.7890, 0.015),
(5, 21, 8000.1234, 0.035),
(5, 22, 19000.6789, 0.041),
(5, 23, 27000.4567, 0.049),
(5, 24, 11000.2345, 0.030),
(5, 25, 2000.7890, 0.013),
(6, 26, 13000.1234, 0.044),
(6, 27, 18000.6789, 0.066),
(6, 28, 23000.4567, 0.056);
GO

INSERT INTO watchlists (user_id, stock_id)
VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(2, 6),
(2, 7),
(2, 8),
(2, 9),
(2, 10),
(3, 11),
(3, 12),
(3, 13),
(3, 14),
(3, 15),
(4, 16),
(4, 17),
(4, 18),
(4, 19),
(4, 20),
(5, 21),
(5, 22),
(5, 23),
(5, 24),
(5, 25),
(6, 26),
(6, 27),
(6, 28);
GO

INSERT INTO orders (user_id, stock_id, order_type, direction, quantity, price, status, order_date)
VALUES
(1, 1, 'market', 'buy', 100, 1500.1234, 'executed', '2023-03-01 10:00:00'),
(1, 2, 'limit', 'sell', 50, 1000.1234, 'pending', '2023-03-02 11:00:00'),
(1, 3, 'stop', 'buy', 200, 2000.1234, 'canceled', '2023-03-03 12:00:00'),
(2, 4, 'market', 'sell', 150, 2500.1234, 'executed', '2023-03-04 13:00:00'),
(2, 5, 'limit', 'buy', 300, 3000.1234, 'pending', '2023-03-05 14:00:00'),
(3, 6, 'stop', 'sell', 100, 3500.1234, 'canceled', '2023-03-06 15:00:00'),
(3, 7, 'market', 'buy', 200, 4000.1234, 'executed', '2023-03-07 16:00:00'),
(4, 8, 'limit', 'sell', 150, 4500.1234, 'pending', '2023-03-08 17:00:00'),
(4, 9, 'stop', 'buy', 300, 5000.1234, 'canceled', '2023-03-09 18:00:00'),
(5, 10, 'market', 'sell', 100, 5500.1234, 'executed', '2023-03-10 19:00:00'),
(5, 11, 'limit', 'buy', 200, 6000.1234, 'pending', '2023-03-11 20:00:00'),
(6, 12, 'stop', 'sell', 150, 6500.1234, 'canceled', '2023-03-12 21:00:00'),
(6, 13, 'market', 'buy', 300, 7000.1234, 'executed', '2023-03-13 22:00:00'),
(7, 14, 'limit', 'sell', 100, 7500.1234, 'pending', '2023-03-14 23:00:00'),
(7, 15, 'stop', 'buy', 200, 8000.1234, 'canceled', '2023-03-15 01:00:00'),
(8, 16, 'market', 'sell', 150, 8500.1234, 'executed', '2023-03-16 02:00:00'),
(8, 17, 'limit', 'buy', 300, 9000.1234, 'pending', '2023-03-17 03:00:00'),
(9, 18, 'stop', 'sell', 100, 9500.1234, 'canceled', '2023-03-18 04:00:00'),
(9, 19, 'market', 'buy', 200, 10000.1234, 'executed', '2023-03-19 05:00:00'),
(10, 20, 'limit', 'sell', 150, 10500.1234, 'pending', '2023-03-20 06:00:00'),
(10, 21, 'stop', 'buy', 300, 11000.1234, 'canceled', '2023-03-21 07:00:00'),
(1, 22, 'market', 'sell', 100, 11500.1234, 'executed', '2023-03-22 08:00:00'),
(2, 23, 'limit', 'buy', 200, 12000.1234, 'pending', '2023-03-23 09:00:00'),
(3, 24, 'stop', 'sell', 150, 12500.1234, 'canceled', '2023-03-24 10:00:00'),
(4, 25, 'market', 'buy', 300, 13000.1234, 'executed', '2023-03-25 11:00:00'),
(5, 26, 'limit', 'sell', 100, 13500.1234, 'pending', '2023-03-26 12:00:00'),
(6, 27, 'stop', 'buy', 200, 14000.1234, 'canceled', '2023-03-27 13:00:00'),
(7, 28, 'market', 'sell', 150, 14500.1234, 'executed', '2023-03-28 14:00:00');
GO

INSERT INTO portfolios (user_id, stock_id, quantity, purchase_price, purchase_date)
VALUES
(3, 16, 100, 45.25, '2022-10-01 09:00:00'),
(4, 7, 500, 68.75, '2022-12-05 14:30:00'),
(2, 21, 50, 32.40, '2022-09-15 11:45:00'),
(5, 3, 250, 12.90, '2023-01-22 16:20:00'),
(1, 19, 75, 55.60, '2022-11-30 13:15:00'),
(6, 12, 200, 78.25, '2022-09-05 10:10:00'),
(1, 18, 150, 38.90, '2023-03-18 11:55:00'),
(3, 2, 300, 19.85, '2022-08-12 15:40:00'),
(4, 13, 100, 42.60, '2022-11-03 12:20:00'),
(5, 9, 400, 52.75, '2022-10-29 09:30:00'),
(6, 11, 150, 63.20, '2023-02-14 14:50:00'),
(2, 17, 75, 34.90, '2022-12-28 10:15:00'),
(3, 8, 200, 55.80, '2022-09-17 16:40:00'),
(4, 15, 50, 95.00, '2023-03-07 11:25:00'),
(5, 14, 300, 28.45, '2022-10-05 13:10:00'),
(1, 22, 100, 85.75, '2023-01-08 10:00:00'),
(6, 6, 250, 50.60, '2022-11-19 15:30:00'),
(2, 1, 500, 25.40, '2023-02-21 09:45:00'),
(3, 10, 150, 75.25, '2022-10-16 14:20:00'),
(4, 4, 100, 105.00, '2022-09-01 11:55:00'),
(5, 20, 200, 30.90, '2023-03-12 09:10:00'),
(1, 16, 150, 42.60, '2022-11-10 12:30:00'),
(6, 7, 400, 62.75, '2022-09-27 10:50:00'),
(2, 21, 50, 35.90, '2022-08-19 14:15:00'),
(3, 3, 200, 11.80, '2022-12-06 09:40:00'),
(4, 18, 75, 39.20, '2023-02-05 11:25:00');
GO

INSERT INTO educational_resources (title, content, category, date_published) VALUES
(N'Phân tích kỹ thuật cơ bản', N'Bài viết này trình bày những khái niệm cơ bản của phân tích kỹ thuật, nhưng cũng cung cấp một số kiến thức nâng cao. Nếu bạn mới bắt đầu học phân tích kỹ thuật, đây là một bài viết tuyệt vời để bắt đầu.', N'Phân tích kỹ thuật', '2022-01-01'),
(N'Bảo vệ tài khoản giao dịch của bạn', N'Bài viết này cung cấp một số lời khuyên để giúp bạn bảo vệ tài khoản giao dịch của mình, đảm bảo rằng bạn không bao giờ mất hết số tiền đầu tư của mình trong một lần.', N'Quản lý rủi ro', '2022-02-15'),
(N'Hướng dẫn đầu tư vào thị trường chứng khoán', N'Bài viết này cung cấp một số lời khuyên cơ bản để bắt đầu đầu tư vào thị trường chứng khoán, bao gồm việc lựa chọn cổ phiếu, phân tích cơ bản và kỹ thuật, và quản lý rủi ro.', N'Đầu tư', '2022-03-10'),
(N'Kỹ năng quản lý rủi ro cho nhà đầu tư', N'Bài viết này trình bày những kỹ năng cơ bản để quản lý rủi ro khi đầu tư vào thị trường chứng khoán, bao gồm cách đánh giá rủi ro và quản lý tỷ lệ rủi ro / lợi nhuận.', N'Quản lý rủi ro', '2022-04-22'),
(N'Phương pháp đầu tư giá trị', N'Bài viết này giải thích phương pháp đầu tư giá trị và cách sử dụng nó để tìm kiếm các cổ phiếu định giá thấp nhưng có tiềm năng tăng trưởng dài hạn. Bạn sẽ học được các công cụ và chỉ số đầu vào để tìm kiếm cổ phiếu giá trị.', N'Đầu tư', '2022-05-11');
GO

INSERT INTO linked_bank_accounts (user_id, bank_name, account_number, routing_number, account_type) VALUES
(1, 'Vietcombank', '1234567890', '12345678', 'checking'),
(1, 'Techcombank', '2345678901', '23456789', 'savings'),
(2, 'ACB Bank', '3456789012', '34567890', 'checking'),
(2, 'VietinBank', '4567890123', '45678901', 'savings'),
(3, 'BIDV', '5678901234', '56789012', 'checking'),
(3, 'Sacombank', '6789012345', '67890123', 'savings'),
(4, 'VPBank', '7890123456', '78901234', 'checking'),
(4, 'Agribank', '8901234567', '89012345', 'savings'),
(5, 'TPBank', '9012345678', '90123456', 'checking'),
(5, 'Maritime Bank', '0123456789', '01234567', 'savings'),
(6, 'HSBC', '2345678901', '23456789', 'checking'),
(6, 'ANZ', '3456789012', '34567890', 'savings'),
(7, 'CitiBank', '4567890123', '45678901', 'checking'),
(7, 'Standard Chartered', '5678901234', '56789012', 'savings'),
(8, 'Shinhan Bank', '6789012345', '67890123', 'checking'),
(8, 'Woori Bank', '7890123456', '78901234', 'savings'),
(9, 'KB Kookmin Bank', '9012345678', '90123456', 'checking'),
(9, 'KEB Hana Bank', '0123456789', '01234567', 'savings'),
(10, 'Bank of America', '2345678901', '23456789', 'checking'),
(10, 'JPMorgan Chase', '3456789012', '34567890', 'savings');
GO

--SELECT * FROM linked_bank_accounts;
INSERT INTO transactions (user_id, linked_account_id, transaction_type, amount, transaction_date) VALUES
(1, 1, 'deposit', 5000.00, '2022-03-10 08:23:10'),
(1, 1, 'withdrawal', 1000.00, '2022-03-15 12:34:56'),
(2, 2, 'deposit', 3000.00, '2022-03-18 09:45:32'),
(2, 2, 'withdrawal', 2000.00, '2022-03-20 13:27:48'),
(3, 3, 'deposit', 10000.00, '2022-03-22 10:15:25'),
(3, 3, 'withdrawal', 5000.00, '2022-03-25 14:56:37'),
(4, 4, 'deposit', 8000.00, '2022-03-26 11:27:42'),
(4, 4, 'withdrawal', 6000.00, '2022-03-30 16:18:59'),
(5, 5, 'deposit', 2000.00, '2022-04-02 09:10:12'),
(5, 5, 'withdrawal', 1500.00, '2022-04-05 14:29:45'),
(6, 6, 'deposit', 5000.00, '2022-04-08 10:05:23'),
(6, 6, 'withdrawal', 3000.00, '2022-04-10 15:14:57'),
(7, 7, 'deposit', 9000.00, '2022-04-12 11:37:40'),
(7, 7, 'withdrawal', 7000.00, '2022-04-15 17:03:29'),
(8, 8, 'deposit', 1500.00, '2022-04-18 08:45:10'),
(8, 8, 'withdrawal', 1000.00, '2022-04-20 12:48:39'),
(9, 9, 'deposit', 6000.00, '2022-04-22 09:56:32'),
(9, 9, 'withdrawal', 4000.00, '2022-04-25 14:19:47'),
(10, 10, 'deposit', 4000.00, '2022-04-28 10:17:35'),
(10, 10, 'withdrawal', 2500.00, '2022-05-01 15:37:58');
GO


--create views

CREATE VIEW vw_UserPortfolioSummary AS
SELECT
    p.user_id,
    s.symbol,
    s.company_name,
    p.quantity,
    p.purchase_price,
    p.purchase_date
FROM
    portfolios p
JOIN
    stocks s ON p.stock_id = s.stock_id;
GO

-- Tổng quan danh mục đầu tư của người dùng
-- Thêm giao dịch vào tài khoản ngân hàng liên kết
CREATE PROCEDURE sp_AddTransaction
(
    @user_id INT,
    @linked_account_id INT,
    @transaction_type NVARCHAR(50),
    @amount DECIMAL(18, 2)
)
AS
BEGIN
    INSERT INTO transactions (user_id, linked_account_id, transaction_type, amount, transaction_date)
    VALUES (@user_id, @linked_account_id, @transaction_type, @amount, GETDATE());
END;
GO

-- Tổng quan về các chỉ số thị trường
CREATE VIEW vw_MarketIndicesSummary AS
SELECT
    mi.index_id,
    mi.name,
    mi.symbol,
    COUNT(ic.stock_id) AS number_of_constituents
FROM
market_indices mi
JOIN
    index_constituents ic ON mi.index_id = ic.index_id
GROUP BY
mi.index_id, mi.name, mi.symbol;
GO

-- Tổng quan về các Quỹ Đầu Tư Chứng Khoán (ETF)
CREATE VIEW vw_ETFsSummary AS
SELECT
    e.etf_id,
    e.name,
    e.symbol,
    e.management_company,
    e.inception_date,
    COUNT(eh.stock_id) AS number_of_holdings
FROM
    etfs e
JOIN
    etf_holdings eh ON e.etf_id = eh.etf_id
GROUP BY
    e.etf_id, e.name, e.symbol, e.management_company, e.inception_date;
GO

SELECT * FROM view_quotes_realtime;
