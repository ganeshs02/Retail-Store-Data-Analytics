
import pandas as pd
from sqlalchemy import create_engine





path= r"C:\Users\Ganseh\Desktop\Retail  Project\product.csv"  #path of csv file

data=pd.read_csv(path)

print(data)

engine = create_engine('mysql+pymysql://root:258925@localhost:3306/RETAIL PROJECT')  #username pass database name

data.to_sql('product', con=engine, if_exists='replace', index=False)
# table name
print("done")