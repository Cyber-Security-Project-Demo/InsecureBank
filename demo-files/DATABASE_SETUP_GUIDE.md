# InsecureBank Database Setup Guide

This guide will help you set up the InsecureBank database for the vulnerable banking application.

## Option 1: Using CleverCloud (Recommended for Cloud Deployment)

### Step 1: Create CleverCloud Account
1. Go to [clever-cloud.com](https://clever-cloud.com)
2. Sign up for a free account
3. Verify your email

### Step 2: Create MySQL Add-on
1. In CleverCloud dashboard, click **"Create an application"**
2. Choose **"Add-on"** → **"MySQL"**
3. Select the **free plan**
4. Name it: `insecurebank-db`
5. Click **"Create"**

### Step 3: Get Database Credentials
After creation, you'll get credentials like:
- **Host**: `your-host.mysql.services.clever-cloud.com`
- **Database Name**: `your-database-name`
- **User**: `your-username`
- **Password**: `your-password`
- **Port**: `3306`

### Step 4: Import Database
1. **In CleverCloud dashboard**, click on your MySQL add-on
2. **Find "Database Manager"** or **"phpMyAdmin"** button
3. **Click it** to open the web interface
4. **Go to SQL tab**
5. **Copy and paste** the entire content from `demo-files/manual-db-setup.sql`
6. **Click "Go"** or **"Execute"**

### Step 5: Configure Environment Variables (Secure Method)

**IMPORTANT: Never commit database credentials to your code!**

1. **In the `backend` folder**, copy the `.env.example` file:
   ```bash
   cp .env.example .env
   ```

2. **Edit the `.env` file** with your actual CleverCloud credentials:
   ```env
   MYSQL_ADDON_HOST=your-host.mysql.services.clever-cloud.com
   MYSQL_ADDON_USER=your-username
   MYSQL_ADDON_PASSWORD=your-password
   MYSQL_ADDON_DB=your-database-name
   MYSQL_ADDON_PORT=3306
   ```

3. **Verify `.env` is in `.gitignore`** (it should be already)

4. **Install dotenv package**:
   ```bash
   cd backend
   npm install dotenv
   ```

The backend code will automatically load these environment variables.

---

## Option 2: Using XAMPP (Local Development)

### Step 1: Install XAMPP
1. Download from [apachefriends.org](https://www.apachefriends.org/)
2. Install and start **Apache** and **MySQL** services

### Step 2: Create Database
1. Open **phpMyAdmin** (`http://localhost/phpmyadmin`)
2. Click **"New"** to create database
3. Name it: `vulnerable_bank`
4. Click **"Create"**

### Step 3: Import Database
1. **Select** the `vulnerable_bank` database
2. **Click "Import"** tab
3. **Choose file**: `demo-files/manual-db-setup.sql`
4. **Click "Go"**

### Step 4: Backend Configuration (XAMPP)
For local XAMPP, use:

```javascript
const dbConfig = {
  host: 'localhost',
  user: 'root',
  password: '', // Usually empty for XAMPP
  database: 'vulnerable_bank',
  port: 3306
};
```

---

## What's Included in the Database

### Users Table (5 demo users):
| Username | Password | Role | Balance |
|----------|----------|------|---------|
| `admin` | `admin123` | Administrator | $41,300 |
| `john_doe` | `password` | User | $3,200 |
| `jane_smith` | `123456` | User | $2,950 |
| `bob_wilson` | `Bobbbbb` | User | $2,000 |
| `ycp27` | `ycp123` | User | $11,550 |

### Transactions Table:
- 28 demo transactions including CSRF attack examples
- Various transaction types: deposits, withdrawals, transfers

---

## Running the Application

### Backend:
```bash
cd backend
npm install
npm start
```
Server runs on: `http://localhost:5000`

### Frontend:
```bash
cd vul-bank-app
npm install
npm run dev
```
Frontend runs on: `http://localhost:5173`

---

## ⚠️ Security Warning

**This application contains intentional security vulnerabilities for educational purposes:**
- SQL Injection
- XSS (Cross-Site Scripting)
- CSRF (Cross-Site Request Forgery)
- Command Injection
- And more...

**Use only in controlled environments for learning cybersecurity concepts.**

---

## Troubleshooting

### Common Issues:

1. **Connection refused**: Ensure MySQL service is running
2. **Access denied**: Check username/password in `server.js`
3. **Database not found**: Verify database name matches configuration
4. **Port conflicts**: Ensure ports 5000 and 5173 are available

### Environment Variables (Optional):
Create `.env` file in backend folder:
```
MYSQL_ADDON_HOST=your-host
MYSQL_ADDON_USER=your-username
MYSQL_ADDON_PASSWORD=your-password
MYSQL_ADDON_DB=your-database-name
MYSQL_ADDON_PORT=3306
```

---

## Support

If you encounter issues:
1. Check console logs in browser (F12)
2. Check terminal output for backend errors
3. Verify database connection credentials
4. Ensure all npm packages are installed

---

**Repository**: [GitHub Repository Link](https://github.com/Cyber-Security-Project-Demo/Vulnerable-web-app)