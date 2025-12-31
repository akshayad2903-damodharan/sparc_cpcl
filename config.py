class Config:
    SECRET_KEY = "sparc-secret-key"

    DB_URI = (
        "dbname=sparc "
        "user=postgres "
        "password=2903"   # 👈 CHANGE ONLY THIS
        "host=127.0.0.1 "
        "port=5432"
    )

    UPLOAD_FOLDER = "uploads"
