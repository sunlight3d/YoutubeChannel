/*
use master;
DROP DATABASE StockApp;
CREATE DATABASE StockApp;
*/
USE StockApp;
-- Users table (Bảng người dùng)
CREATE TABLE users (
    user_id INT PRIMARY KEY IDENTITY(1,1), -- ID người dùng
    username NVARCHAR(50) UNIQUE NOT NULL, -- Tên đăng nhập
    hashed_password NVARCHAR(255) NOT NULL,
    email NVARCHAR(255) UNIQUE NOT NULL, -- Email
    phone NVARCHAR(20) NOT NULL, -- Số điện thoại
    full_name NVARCHAR(255), -- Họ và tên
    date_of_birth DATE, -- Ngày sinh
    country NVARCHAR(255) -- Quốc gia
);

EXEC sp_help 'users';

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
    sector NVARCHAR(100), -- Ngành
    industry NVARCHAR(100), -- Lĩnh vực
    stock_type NVARCHAR(50)
    --Common Stock (Cổ phiếu thường),Preferred Stock (Cổ phiếu ưu đãi),ETF (Quỹ Đầu Tư Chứng Khoán): 
);
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
    strike_price DECIMAL(18, 4) -- Giá thực hiện (giá mà người mua chứng khoán phái sinh có quyền mua/bán tài sản cơ bản)
    -- Strike price thường được đặt ở một mức giá gần bằng với giá thị trường của tài sản cơ bản 
    -- để tăng khả năng tùy chọn sẽ được sử dụng.
);

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




