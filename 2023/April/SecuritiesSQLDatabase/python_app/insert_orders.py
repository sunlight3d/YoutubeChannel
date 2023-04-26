from datetime import datetime
import random
from database import Database

db = Database()

user_ids = [i for i in range(1, 13)]
stock_ids = [i for i in range(1, 100)]

# Hàm insert dữ liệu vào bảng orders
def insert_order(user_id, stock_id, order_type, direction, quantity, price, status, order_date):
    # Tạo câu lệnh INSERT và tham số tương ứng
    query = "INSERT INTO orders (user_id, stock_id, order_type, direction, quantity, price, status, order_date) VALUES (?, ?, ?, ?, ?, ?, ?, ?)"
    params = (user_id, stock_id, order_type, direction, quantity, price, status, order_date)
    
    try:
        db.execute_query(query, params)
        print(f"Đã insert order: user_id={user_id}, stock_id={stock_id}, order_type={order_type}, direction={direction}, quantity={quantity}, price={price}, status={status}, order_date={order_date}")
    except Exception as e:
        print(f"Lỗi khi insert order: {str(e)}")

# Thực hiện insert 1000 bản ghi vào bảng orders
for i in range(1000):
    user_id = random.choice(user_ids)
    stock_id = random.choice(stock_ids)
    order_type = random.choice(["executed", "pending", "canceled"])
    direction = random.choice(["buy", "sell"])
    quantity = round(random.uniform(1, 100), 2)
    price = round(random.uniform(1, 100), 2)
    status = random.choice(["open", "closed"])
    order_date = datetime.now().strftime("%Y-%m-%d %H:%M:%S")    
    insert_order(user_id, stock_id, order_type, direction, quantity, price, status, order_date)


