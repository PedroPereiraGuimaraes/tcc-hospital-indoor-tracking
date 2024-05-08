import pymongo
from dotenv import load_dotenv
import os

# Carregar variáveis de ambiente do arquivo .env
load_dotenv()

#classe Database, que fará a conexão com o MongoDB 
class Database:
    def __init__(self, database, collection):
        self.connect(database, collection) 

    def connect(self, database, collection):
        try:
            connectionString = f"mongodb+srv://{os.getenv('DB_USER')}:{os.getenv('DB_PASSWORD')}@indoor-tracking.gf1iu9s.mongodb.net/?retryWrites=true&w=majority&appName=indoor-tracking"
            self.clusterConnection = pymongo.MongoClient(
                connectionString,
                tlsAllowInvalidCertificates=True 
            )
            self.db = self.clusterConnection[database] 
            self.collection = self.db[collection] 
            print("Conectado ao banco de dados com sucesso!")
        except Exception as e:
            print(e)
