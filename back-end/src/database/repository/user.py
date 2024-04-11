from database.connection_db import Database
import json
from bson import json_util 
import attr

class UserDAO: # DAO - Data Access Object
    def __init__(self):
        self.db = Database(database="indoor_db", collection="user")

    def get_all(self):
        try:
            res = self.db.collection.find()
            print("total users: ", res)

            parsed_json = json.loads(json_util.dumps(res))

            return parsed_json
        except Exception as e:
            print(f"Houve um erro ao tentar pegar os usuários: {e}")
            return None
        
    def create_user(self, new_user):
        try:
            user_json = {"name": new_user.name,
                         "email": new_user.email,
                         "password": new_user.password,
                         "registration": new_user.register,
                         "isAdmin": False}
            res = self.db.collection.insert_one(user_json)
            print("res create_user: ", res)

            # parsed_json = json.loads(json_util.dumps(res))

            return True
        except Exception as e:
            print(f"Houve um erro ao tentar pegar os usuários: {e}")
            return False


    def login_authentication(self, register, password):
        try:
            res = self.db.collection.find_one({"registration": register, "password": password})
            
            parsed_json = json.loads(json_util.dumps(res))


            return parsed_json
        except Exception as e:
            print(f"Houve um erro ao tentar pegar os usuários: {e}")
            return None
