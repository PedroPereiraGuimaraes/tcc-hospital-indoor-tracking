from src.database.connection_db import Database
from datetime import datetime
import json
from bson import json_util 
from datetime import datetime

class EquipmentDAO: # DAO - Data Access Object
    def __init__(self):
        self.db = Database(collection="equipment")

    def get_all(self):
        try:
            res = self.db.collection.find({}, {"_id": 0, "name": 1,"patrimonio": 1, "maintenance": 1, "current_room": 1, "current_date": 1})

            parsed_json = json.loads(json_util.dumps(res))
            return parsed_json
        
        except Exception as e:
            print(f"Houve um erro ao tentar pegar os equipamentos: {e}")
            return None
    
    def create(self, new_equipment):
        try:
            user_json = {"name": new_equipment.name,
                         "patrimonio": new_equipment.patrimonio,
                         "maintenance": False}
            res = self.db.collection.insert_one(user_json)
            
            return True
        except Exception as e:
            print(f"Houve um erro ao tentar pegar os equipamentos: {e}")
            return None

    def read_one(self, patrimonio):
        try:
            res = self.db.collection.find_one({"patrimonio": patrimonio})
            print("one equipment: ", res)

            parsed_json = json.loads(json_util.dumps(res))

            return parsed_json
        except Exception as e:
            return False
        
    def get_equipments_by_current_room(self, current_room):
        try:
            res = self.db.collection.find({"current_room": current_room})

            parsed_json = json.loads(json_util.dumps(res))

            return parsed_json
        except Exception as e:
            return False
        
    def update(self, data_equipment):
        try:
            res = self.db.collection.update_one({"patrimonio": data_equipment.patrimonio}, {"$set":  {"name": data_equipment.name, "last_maintenance": data_equipment.last_maintenance, "next_maintenance": data_equipment.next_maintenance}})

            if res.matched_count == 0:
                return False
            else:
                return True
        except Exception as e:
            print(f"Houve um erro ao tentar pegar os equipamentos: {e}")
            return None
        
    def delete(self, patrimonio):
        try:
            res = self.db.collection.delete_one({"patrimonio": patrimonio})

            if res.deleted_count == 0:
                return False
            else:
                return True
        except Exception as e:
            print(f"Houve um erro ao tentar pegar os equipamentos: {e}")
            return None
        
    def get_history(self):
        try:
            res = self.db.collection.find({}, {"_id": 0, "name": 1,"patrimonio": 1, "historic": 1})

            parsed_json = json.loads(json_util.dumps(res))
            print("res historico:", parsed_json)
            return parsed_json
        
        except Exception as e:
            print(f"Houve um erro ao tentar pegar os equipamentos: {e}")
            return None
        
    def update_maintenance(self, data_equipment):
        try:
            res = self.db.collection.update_one({"patrimonio": data_equipment.patrimonio}, {"$set":  {"maintenance": data_equipment.maintenance}})


            if res.matched_count == 0:
                return False
            else:
                return True
        except Exception as e:
            print(f"Houve um erro ao tentar atualizar o manutenção: {e}")
            return None

    def get_current_room_and_date(self, esp_id):
        try:
            res = self.db.collection.find_one({"esp_id": esp_id},  {"_id": 0, "name": 1, "patrimonio": 1,  "current_room": 1, "current_date": 1})
            # print("one equipment: ", res['current_room'])

            return res
        except Exception as e:
            raise e
        
    def update_historic(self, esp_id, room, date):
        try:
            new_data = {
                "room": room,
                "inicial_date": date,
            }
            res = self.db.collection.update_one({"esp_id": esp_id}, {"$push": {"historic": new_data}})
            print("one equipment: ", res)

            return res
        except Exception as e:
            raise e
    
    def update_current_room(self, esp_id, room):
        try:
            date = datetime.now()
            
            res = self.db.collection.update_one({"esp_id": esp_id},{"$set": {"current_room": room, "current_date": date}})
            print("one equipment type: ", type(res))

            return res
        except Exception as e:
            raise e