from flask import Flask
import mariadb
app = Flask(__name__)
conn = mariadb.connect(
         host='mariadb-deployment',
         port= 3306,
         user='root',
         password='secret',
         database='mysql')
cur = conn.cursor()
@app.route("/")
def index():
    return "Connected to database"
if __name__ == "__main__":
    app.run()