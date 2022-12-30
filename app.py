from flask import Flask, render_template
import mariadb, os

app = Flask(__name__)

conn = mariadb.connect(
         host = os.getenv('MARIADB_ROOT_HOST'),
         port = 3306,
         user = 'root',
         password = os.getenv('MARIADB_ROOT_PASSWORD'),
         database= os.getenv('MARIADB_DATABASE'))

@app.route("/")
@app.route("/index")
def index():
    with conn.cursor() as cur:
        cur.execute("SHOW TABLES")
        tables = cur.fetchall()
        cur.close()
    return render_template('index.html', tables=tables)

@app.route("/Articles")
def Articles():
    with conn.cursor() as cur:
        cur.execute("SELECT * FROM Articles")
        data = cur.fetchall()
        headers = [i[0] for i in cur.description]
        cur.close()
    return render_template('index.html', data=data, headers=headers, title='Articles')

@app.route("/article_types")
def article_types():
    with conn.cursor() as cur:
        cur.execute("SELECT * FROM article_types")
        data = cur.fetchall()
        headers = [i[0] for i in cur.description]
        cur.close()
    return render_template('index.html', data=data, headers=headers, title='article_types')

@app.route("/author")
def author():
    with conn.cursor() as cur:
        cur.execute("SELECT * FROM author")
        data = cur.fetchall()
        headers = [i[0] for i in cur.description]
        cur.close()
    return render_template('index.html', data=data, headers=headers, title='author')

@app.route("/magazines")
def magazines():
    with conn.cursor() as cur:
        cur.execute("SELECT * FROM magazines")
        data = cur.fetchall()
        headers = [i[0] for i in cur.description]
        cur.close()
    return render_template('index.html', data=data, headers=headers, title='magazines')

if __name__ == "__main__":
    app.run()