# ---------- Stage 1: Builder ----------
FROM python:3.10-slim as builder

WORKDIR /install

# ติดตั้ง dependencies เฉพาะที่จำเป็น
COPY requirements.txt .

RUN pip install --no-cache-dir --upgrade pip \
 && pip install --no-cache-dir --prefix=/install/packages -r requirements.txt

# ---------- Stage 2: Final Image ----------
FROM python:3.10-slim

ENV TZ=Asia/Bangkok

# ติดตั้ง system dependencies ที่จำเป็นต่อ deepcut
RUN apt-get update && apt-get install -y \
    git \
    libthai-dev \
    libatlas-base-dev \
    curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# เตรียมโฟลเดอร์ทำงาน
WORKDIR /app

# คัดลอกไฟล์โปรแกรม
COPY thai_tokenizer_api.py .

# คัดลอกเฉพาะ Python packages จาก builder stage
COPY --from=builder /install/packages /usr/local

# ลบไฟล์ cache และ pyc/pyo เพื่อลดขนาด
RUN find /usr/local -type f -name '*.pyc' -delete \
 && find /usr/local -type f -name '*.pyo' -delete \
 && python -m pip cache purge || true

EXPOSE 5000

CMD ["python", "thai_tokenizer_api.py"]
