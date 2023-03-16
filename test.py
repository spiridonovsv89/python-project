import unittest
from app import app
from app import conn


class FlaskTestPages(unittest.TestCase):

    def setUp(self):
        app.testing = True
        self.client = app.test_client()

    def test_index(self):
        response = self.client.get('/')
        assert response.status_code == 200

    def test_Articles(self):
        response = self.client.get('/Articles')
        assert response.status_code == 200

    def test_article_types(self):
        response = self.client.get('/article_types')
        assert response.status_code == 200

    def test_author(self):
        response = self.client.get('/author')
        assert response.status_code == 200

    def test_magazines(self):
        response = self.client.get('/magazines')
        assert response.status_code == 200


class TestDatabaseConnection(unittest.TestCase):

    def test_db_connection(self):
        connection = conn
        self.assertIsNotNone(connection)


class TestTablesDatabase(unittest.TestCase):

    def setUp(self):
        self.con = conn

    def tearDown(self):
        self.con.close()

    def test_db_tables(self):
        cur = self.con.cursor()
        cur.execute("SHOW TABLES")
        tables = cur.fetchall()
        self.assertTrue(('Articles',) in tables)
        self.assertTrue(('magazines',) in tables)
        self.assertTrue(('article_types',) in tables)
        self.assertTrue(('author',) in tables)


if __name__ == '__main__':
    unittest.main()
