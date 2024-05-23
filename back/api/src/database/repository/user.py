from src.database.connection_db import Database
import json
from bson import json_util 
# import attr

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

            if self.db.collection.find_one({"registration": new_user.register_}) != None:
                return {"Error messagem": "Usuário existente"}
            
            user_json = {"name": new_user.name,
                         "email": new_user.email,
                         "password": new_user.password,
                         "registration": new_user.register_,
                         "isAdmin": False}
            res = self.db.collection.insert_one(user_json)
            
            return True
        except Exception as e:
            print(f"Houve um erro ao tentar pegar os usuários: {e}")
            return False


    def login_authentication(self, email, password):
        try:
            res = self.db.collection.find_one({"email": email, "password": password})
            
            parsed_json = json.loads(json_util.dumps(res))
            print(res)


            return parsed_json
        except Exception as e:
            print(f"Houve um erro ao tentar pegar os usuários: {e}")
            return None
    
    def change_admin(self, register, is_admin):
        try:
            res = self.db.collection.update_one({"registration": register}, {"$set": {"isAdmin": is_admin}})

            return res.raw_result['updatedExisting']
        except Exception as e:
            print(f"Houve um erro ao tentar pegar os usuários: {e}")
            return False
    
    def delete_user(self, register):
        try:
            res = self.db.collection.delete_one({"registration": register})
            print("res: ", res.deleted_count)

            if res.deleted_count == 0:
                return False
            else:
                return True
        except Exception as e:
            print(f"Houve um erro ao tentar pegar os usuários: {e}")
            return False
        
    def update_user(self, data_user):
        try:
            res = self.db.collection.update_one({"registration": data_user.register}, {"$set":  {"name": data_user.name,
                         "email": data_user.email,
                         "password": data_user.password}})
            print("res: ", res)
            print("res match: ", res.matched_count)
            print("res modified: ", res.modified_count)

            if res.matched_count == 0:
                return False
            else:
                return True
        except Exception as e:
            print(f"Houve um erro ao tentar pegar os usuários: {e}")
            return False
        
    
    