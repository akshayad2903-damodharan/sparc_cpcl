# SPARC Sports Scholarship Portal
**Sports Promotion and Recognition by CPCL – CSR Initiative**

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

Production-ready Flask + PostgreSQL web application for CPCL CSR sports scholarship workflow. Digitizes complete application lifecycle with strict eligibility enforcement, seat limits, and audit trails.

## 🎯 Features

### Student Features
- ✅ Secure registration/login with Aadhaar-based identity
- ✅ View only eligible scholarship schemes (age, sport, timeline)
- ✅ Complete digital application form with all mandatory documents
- ✅ Real-time application status tracking
- ✅ Single application per scheme enforcement

### Admin Features
- ✅ Create/manage scholarship schemes and seat limits
- ✅ Application review workflow with document verification
- ✅ Approve/Reject with Scholar/Elite Scholar categorization
- ✅ Transactional seat allocation with gender limits
- ✅ Full audit trail of all status changes

### Technical Features
- Strict eligibility validation (3 levels: Frontend, Backend, Database)
- Secure file uploads with type/size validation
- Session-based authentication with CSRF protection
- PostgreSQL normalized schema with constraints/triggers
- Government/PSU-style UI (Bootstrap 5)

## 🛠️ Technology Stack

| Layer | Technology |
|-------|------------|
| **Backend** | Python 3.9+, Flask, Flask Blueprints, Flask-Sessions |
| **Frontend** | HTML5, Bootstrap 5, Vanilla JS/CSS |
| **Database** | PostgreSQL 13+ |
| **Security** | Werkzeug password hashing, CSRF tokens |
| **File Storage** | Secure server-side filesystem |

## 🚀 Quick Start

### Prerequisites
```bash
# Install Python 3.9+
# Install PostgreSQL 13+
# Create database: CREATE DATABASE sparc_portal;
