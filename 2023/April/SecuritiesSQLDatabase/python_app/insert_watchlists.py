from faker import Faker
import random
from database import Database

db = Database()

# Tạo đối tượng faker
fake = Faker()

user_ids = [i for i in range(1, 11)]  
stock_ids = [i for i in range(1, 99)] 

for i in range(100):
    user_id = random.choice(user_ids)
    stock_id = random.choice(stock_ids)
    
    query = "INSERT INTO watchlists (user_id, stock_id) VALUES (?, ?)"
    params = (user_id, stock_id)    
    try:
        db.execute_query(query, params)
        print(f"Đã insert bản ghi: {i}")
        print(f"user_id: {user_id}, stock_id: {stock_id}")
    except Exception as e:
        print(f"Lỗi khi insert bản ghi {i}: {str(e)}")
        continue

