from datetime import datetime
import random
from database import Database

db = Database()

user_ids = [i for i in range(1, 13)]
stock_ids = [i for i in range(1, 100)]

# Hàm insert dữ liệu vào bảng portfolios
def insert_portfolio(user_id, stock_id, quantity, purchase_price, purchase_date):
    # Tạo câu lệnh INSERT và tham số tương ứng
    query = "INSERT INTO portfolios (user_id, stock_id, quantity, purchase_price, purchase_date) VALUES (?, ?, ?, ?, ?)"
    params = (user_id, stock_id, quantity, purchase_price, purchase_date)
    
    try:
        db.execute_query(query, params)
        print(f"Đã insert portfolio: user_id={user_id}, stock_id={stock_id}, quantity={quantity}, purchase_price={purchase_price}, purchase_date={purchase_date}")
    except Exception as e:
        print(f"Lỗi khi insert portfolio: {str(e)}")

# Thực hiện insert 1000 bản ghi vào bảng portfolios
for i in range(1000):
    user_id = random.choice(user_ids)
    stock_id = random.choice(stock_ids)
    quantity = random.randint(1, 1000)
    purchase_price = round(random.uniform(1, 100), 4)
    purchase_date = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    
    insert_portfolio(user_id, stock_id, quantity, purchase_price, purchase_date)
