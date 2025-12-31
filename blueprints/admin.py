from flask import Blueprint, session, render_template

admin_bp = Blueprint("admin", __name__, template_folder="../templates/admin")

@admin_bp.route("/dashboard")
def dashboard():
    if session.get("role") != "admin":
        return "Access denied", 403
    return render_template("dashboard.html")
