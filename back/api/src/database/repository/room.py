from src.database.connection_db import Database
import json
import uuid
from bson import json_util 

class RoomDAO: # DAO - Data Access Object
    def __init__(self):
        self.db = Database(collection="room")

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

            # if self.read_one(new_room_name) != (None and True):
            #     return {"Error message": "Sala já existente"}

            
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
            return None
    
    def update_equipment_in_room(self, name_room, name_equipment, patrimonio):
        try:
            new_data = {
                "equipment": name_equipment,
                "patrimonio": patrimonio,
            }
            res = self.db.collection.update_one({"name": name_room}, {"$push": {"equipments": new_data}})
            print("one equipment: ", res)

            return res
        except Exception as e:
            raise e
        
    def delete_equipment_in_room(self, patrimonio):
        try:
            res = self.db.collection.update_many({}, {"$pull": {"equipments": {"patrimonio": patrimonio}}})
            # print("one equipment: ", res)

            return res
        except Exception as e:
            raise e
