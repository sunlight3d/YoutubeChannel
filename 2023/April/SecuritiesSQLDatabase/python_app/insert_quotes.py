from datetime import datetime, timedelta
import random, time
from database import Database

db = Database()

def insert_10k_records():        
    # Kiểm tra số lượng bản ghi hiện có trong bảng        
    db.cursor.execute('SELECT COUNT(*) FROM quotes')
    row = db.cursor.fetchone()
    count = row[0]
    if count >= 10000:
        print('Đã có đủ 100000 bản ghi.')
        return

    # Thêm 10000 bản ghi fake
    start_date = datetime(2019, 1, 1)
    end_date = datetime(2023, 4, 30)
    delta = end_date - start_date
    for i in range(10000):
        stock_id = random.randint(1, 28)
        price = round(random.uniform(1, 100), 2)
        change = round(random.uniform(-10, 10), 2)
        percent_change = round(change / price * 100, 2)
        volume = random.randint(1000, 1000000)
        # Tạo ngày giờ ngẫu nhiên
        day = random.randint(1, delta.days)
        seconds = random.randint(0, 24*60*60)
        microseconds = random.randint(0, 1000000)
        time_stamp = start_date + timedelta(days=day, seconds=seconds, microseconds=microseconds)

        sql = "INSERT INTO quotes (stock_id, price, change, percent_change, volume, time_stamp) VALUES (?, ?, ?, ?, ?, ?)"
        values = (stock_id, price, change, percent_change, volume, time_stamp)
        print("Inserting: ", values)
        db.execute_query(sql, values)        
    print('Thêm dữ liệu thành công.')

def insert_random_quotes():    
    while True:
        stock_id = random.randint(1, 28)
        price = round(random.uniform(100, 1000), 2)
        change = round(random.uniform(-50, 50), 2)
        percent_change = round(random.uniform(-5, 5), 2)
        volume = random.randint(1000, 10000)
        time_stamp = datetime.now()
        values = (stock_id, price, change, percent_change, volume, time_stamp)
        print("Inserting: ", values)        
        sql = "INSERT INTO quotes(stock_id, price, change, percent_change, volume, time_stamp) VALUES (?, ?, ?, ?, ?, ?)"
        db.execute_query(sql, values)        
        time.sleep(5)

insert_10k_records()
insert_random_quotes()