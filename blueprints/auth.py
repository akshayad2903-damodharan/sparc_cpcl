from flask import Blueprint, request, redirect, url_for, render_template, session, flash
import psycopg2
from config import Config
from werkzeug.security import check_password_hash, generate_password_hash

auth_bp = Blueprint("auth", __name__, template_folder="../templates/auth")

def get_db():
    return psycopg2.connect(Config.DB_URI)

@auth_bp.route("/login", methods=["GET", "POST"])
def login():
    if request.method == "POST":
        email = request.form.get("email")
        password = request.form.get("password")

        conn = get_db()
        cur = conn.cursor()
        cur.execute("SELECT id, password, role FROM users WHERE email=%s", (email,))
        user = cur.fetchone()
        cur.close()
        conn.close()

        if user and check_password_hash(user[1], password):
            session["user_id"] = user[0]
            session["role"] = user[2]
            flash("Login successful!", "success")
            if user[2] == "student":
                return redirect(url_for("student.dashboard"))
            else:
                return redirect(url_for("admin.dashboard"))
        else:
            flash("Invalid credentials!", "danger")

    return render_template("login.html")

@auth_bp.route("/logout")
def logout():
    session.clear()
    return redirect(url_for("auth.login"))
