# Sử dụng base image có sẵn
FROM python:3.9-slim

# Sao chép mã nguồn vào thư mục /app trong container
COPY . /app

# Đặt thư mục làm thư mục làm việc
WORKDIR /app

# Cài đặt các thư viện cần thiết
RUN pip install --no-cache-dir numpy tensorflow tensorflow_hub matplotlib pillow

# Khởi chạy script Python
CMD [ "python", "your_script.py" ]
