from mysql.connector import Error, connect

def connect_to_database():
    try:
        conn = connect(
            host='localhost',
            user='root',
            password='',
            database='darnab'
        )
        return conn
    except Error as e:
        print(e)
        return None