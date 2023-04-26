from faker import Faker
import random
from database import Database



db = Database()

# Tạo đối tượng faker
fake = Faker()

# Tạo danh sách các ký hiệu cho Quỹ Đầu Tư Chứng Khoán (ETF)
symbols = ['VTI', 'VXUS', 'BND', 'BNDX', 'VEA', 'VWO', 'QQQ', 'SPY', 'GLD', 'EFA']

# Tạo set để lưu trữ các giá trị đã được sử dụng của trường 'symbol'
used_symbols = set()

# Tạo 1000 bản ghi giả cho bảng etfs
for i in range(1000):
    name = fake.company() + ' ETF'    
    # Chọn ngẫu nhiên một ký hiệu từ danh sách 'symbols' và kiểm tra xem ký hiệu đó đã được sử dụng trước đó chưa
    while True:
        symbol = random.choice(symbols) + str(random.randint(1, 100))
        if symbol not in used_symbols:
            used_symbols.add(symbol)
            break
            
    management_company = fake.company()
    inception_date = fake.date_between(start_date='-10y', end_date='today')

    # Thêm dữ liệu giả vào bảng etfs
    query = "INSERT INTO etfs (name, symbol, management_company, inception_date) VALUES (?, ?, ?, ?)"
    params = (name, symbol, management_company, inception_date)
    db.execute_query(query, params)
    
    print(f"Đã insert bản ghi: {i}")
    print(f"Tên: {name}, Ký hiệu: {symbol}, Công ty quản lý: {management_company}, Ngày thành lập: {inception_date}")
