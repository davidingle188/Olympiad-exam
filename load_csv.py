import pandas as pd
from sqlalchemy import create_engine

conn_string = 'postgresql://postgres:admin@localhost:5432/postgres'
db = create_engine(conn_string)

#Call connect() method
conn = db.connect()

files = ['student_list', 'student_response', 'question_paper_code', 'correct_answer']

for file in files:
    # Use read_csv with the correct file path # load data into postgres SQL
    df = pd.read_csv(f"C:\\Users\\Gracy Pauluse Ingle\\Desktop\\python\\{file}.csv")
    df.to_sql(file, con=conn, if_exists='replace', index=False)
