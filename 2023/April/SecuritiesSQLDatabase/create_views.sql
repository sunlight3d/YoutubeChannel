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

Views:
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
