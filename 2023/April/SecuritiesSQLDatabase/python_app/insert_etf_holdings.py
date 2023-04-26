from faker import Faker
import random
from database import Database

db = Database()

# Tạo đối tượng faker
fake = Faker()


etf_ids = [i for i in range(1, 1000)]  # Tạo danh sách 10 etf_ids từ 1 đến 1000
stock_ids = [i for i in range(1, 99)]  # Tạo danh sách 20 stock_ids từ 1 đến 99

for i in range(1000):    
    etf_id = random.choice(etf_ids)  # Lấy ngẫu nhiên một etf_id từ danh sách etf_ids
    stock_id = random.choice(stock_ids)  # Lấy ngẫu nhiên một stock_id từ danh sách stock_ids
    shares_held = round(random.uniform(1000, 100000), 4)  # Sinh ngẫu nhiên số lượng cổ phiếu được nắm giữ từ 1000 đến 100000
    weight = round(random.uniform(0.01, 0.5), 4)  # Sinh ngẫu nhiên trọng số từ 0.01 đến 0.5
    query = "INSERT INTO etf_holdings (etf_id, stock_id, shares_held, weight) VALUES (?, ?, ?, ?)"    
    params = (etf_id, stock_id, shares_held, weight)
    db.execute_query(query, params)
    print(f"Đã insert bản ghi: {i}")
    print(f"etf_id: {etf_id}, stock_id: {stock_id}, shares_held: {shares_held}, weight: {weight}")
