from src.database.connection_db import Database
import json
import uuid
from bson import json_util 

class RoomDAO: # DAO - Data Access Object
    def __init__(self):
        self.db = Database(database="indoor_db", collection="room")

    def get_all(self):
        try:
            res = self.db.collection.find()

            parsed_json = json.loads(json_util.dumps(res))
            return parsed_json
        
        except Exception as e:
            print(f"Houve um erro ao tentar pegar todas as salas: {e}")
            return None
    
    def create(self, new_room_name):
        try:
            uuid_room = str(uuid.uuid4())

            if self.read_one(new_room_name) != None:
                return {"Error message": "Sala já existente"}

            
            room_json = {"name": new_room_name, "uuid": uuid_room}
            res = self.db.collection.insert_one(room_json)
            
            return True
        except Exception as e:
            print(f"Houve um erro ao tentar criar uma nova sala: {e}")
            return False

    def read_one(self, name):
        try:
            res = self.db.collection.find_one({"name": name})
            print("one room: ", res)

            parsed_json = json.loads(json_util.dumps(res))

            return parsed_json
        except Exception as e:
            return False
        
    def delete(self, uuid):
        try:
            res = self.db.collection.delete_one({"uuid": uuid})

            if res.deleted_count == 0:
                return False
            else:
                return True
        except Exception as e:
            print(f"Houve um erro ao tentar apagar a sala:  {e}")
            return False
