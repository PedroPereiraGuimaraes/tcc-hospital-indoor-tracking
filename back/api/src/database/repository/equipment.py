from src.database.connection_db import Database
import json
from bson import json_util 

class EquipmentDAO: # DAO - Data Access Object
    def __init__(self):
        self.db = Database(database="indoor_db", collection="equipment")

    def get_all(self):
        try:
            res = self.db.collection.find()

            parsed_json = json.loads(json_util.dumps(res))
            return parsed_json
        
        except Exception as e:
            print(f"Houve um erro ao tentar pegar os equipamentos: {e}")
            return None
    
    def create(self, new_equipment):
        try:
            user_json = {"name": new_equipment.name,
                         "patrimonio": new_equipment.patrimonio,
                         "maintenance": new_equipment.maintenance,
                         "current_room": new_equipment.current_room,
                         "current_date": new_equipment.current_date}
            res = self.db.collection.insert_one(user_json)
            
            return True
        except Exception as e:
            print(f"Houve um erro ao tentar pegar os equipamentos: {e}")
            return False

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
            res = self.db.collection.update_one({"patrimonio": data_equipment.patrimonio}, {"$set":  {"name": data_equipment.name}})

            if res.matched_count == 0:
                return False
            else:
                return True
        except Exception as e:
            print(f"Houve um erro ao tentar pegar os equipamentos: {e}")
            return False
        
    def delete(self, patrimonio):
        try:
            res = self.db.collection.delete_one({"patrimonio": patrimonio})

            if res.deleted_count == 0:
                return False
            else:
                return True
        except Exception as e:
            print(f"Houve um erro ao tentar pegar os equipamentos: {e}")
            return False
        
    def get_history(self, patrimonio):
        try:
            res = self.db.collection.find({"patrimonio": patrimonio}, {"historic": 1})

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
            return False