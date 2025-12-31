from flask import Blueprint, render_template

student_bp = Blueprint('student', __name__, url_prefix='/student')

@student_bp.route('/dashboard')
def dashboard():
    return "<h2>Student Dashboard – OK</h2>"
from flask import Blueprint, session, render_template

student_bp = Blueprint("student", __name__, template_folder="../templates/student")

@student_bp.route("/dashboard")
def dashboard():
    if session.get("role") != "student":
        return "Access denied", 403
    return render_template("dashboard.html")
