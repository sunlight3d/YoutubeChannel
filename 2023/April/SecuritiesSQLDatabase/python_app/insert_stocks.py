from faker import Faker
from googletrans import Translator
import pyodbc
import random
import string

from database import Database

db = Database()
# Tạo đối tượng faker
fake = Faker()
translator = Translator()

# Tạo danh sách các mã cổ phiếu đã được sử dụng
used_symbols = set()

def generate_word(min_length=2, max_length=10):
    letters = string.ascii_uppercase
    word_length = random.randint(min_length, max_length)
    word = ''.join(random.choice(letters) for i in range(word_length))
    return word

# Tạo 100 bản ghi giả cho bảng stocks
for i in range(100):
    symbol = generate_word(2,10)
    while symbol in used_symbols:
        symbol = generate_word(2,10)
    used_symbols.add(symbol)
    
    company_name = fake.company()
    market_cap = fake.pyfloat(positive=True, min_value=1000000, max_value=1000000000, right_digits=2)
    # Các giá trị cho trường area và sector_en
    SECTORS = {"Thực phẩm": "Food", "Bất động sản": "Real estate", 
            "Ngân hàng": "Banking", "Bán lẻ": "Retail", "Công nghệ": "Technology", 
            "Cơ khí": "Mechanical", "Chứng khoán": "Securities", "Quỹ đầu tư": "Investment fund"}
    # Các giá trị cho trường industry và industry_en
    INDUSTRIES = {"Sữa và sản phẩm sữa": "Dairy and dairy products", 
                "Phát triển bất động sản": "Real estate development", 
                "Bán lẻ thực phẩm": "Food retailing", "Ngân hàng thương mại": "Commercial banking", 
                "Công nghệ thông tin": "Information technology", 
                "Cơ khí chế tạo": "Mechanical manufacturing", 
                "Chứng khoán đầu tư": "Investment securities", 
                "Quỹ đầu tư chứng khoán": "Securities investment fund"}

    STOCK_TYPES = ["Common Stock","Preferred Stock", "ETF"]
    # Tạo giá trị cho trường area và sector_en
    sector = random.choice(list(SECTORS.keys()))
    sector_en = SECTORS[sector]

    # Tạo giá trị cho trường industry và industry_en
    industry = random.choice(list(INDUSTRIES.keys()))
    industry_en = INDUSTRIES[industry]
    
    stock_type = random.choice(STOCK_TYPES)
    rank = fake.random_int(min=1, max=100)
    rank_source = fake.word()
    reason = fake.sentence(nb_words=6, variable_nb_words=True)
    
    # Thêm dữ liệu giả vào bảng stocks
    query = "INSERT INTO stocks (symbol, company_name, market_cap, sector, industry, sector_en, industry_en, stock_type, rank, rank_source, reason) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
    params = (symbol, company_name, market_cap, sector, industry, sector_en, industry_en, stock_type, rank, rank_source, reason)
    db.execute_query(query, params)

    print(f"Đã insert bản ghi: {i}")
    print(f"Mã cổ phiếu: {symbol}, Tên công ty: {company_name}, Vốn hóa: {market_cap}, Ngành: {sector}, Lĩnh vực: {industry}")  
