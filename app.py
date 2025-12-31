from flask import Flask
from config import Config
from flask import Flask, render_template

app = Flask(__name__)
app.config.from_object(Config)

# Blueprints
from blueprints.auth import auth_bp
from blueprints.student import student_bp
from blueprints.admin import admin_bp

app.register_blueprint(auth_bp)
app.register_blueprint(student_bp, url_prefix="/student")
app.register_blueprint(admin_bp, url_prefix="/admin")

@app.route("/")
def home():
    return render_template("home.html")

if __name__ == "__main__":
    app.run(debug=True)
