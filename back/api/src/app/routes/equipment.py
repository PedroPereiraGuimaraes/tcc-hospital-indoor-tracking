from fastapi import APIRouter, status, HTTPException
from src.database.repository.equipment import EquipmentDAO
from src.app.models import Equipment, Equipment_update

router = APIRouter()

@router.get("/read-all", status_code=status.HTTP_200_OK)
def get_all_equipments():
    equipmentDAO = EquipmentDAO()
    equipments = equipmentDAO.get_all()

    if equipments == None:
        raise HTTPException(status_code=500)
    
    return equipments

@router.post("/create", status_code=status.HTTP_201_CREATED)
def create_equipment(new_equipment: Equipment):
    equipmentDAO = EquipmentDAO()
    equipment_exist = equipmentDAO.read_one(new_equipment.patrimonio)
    if equipment_exist:
        raise HTTPException(status_code=409, detail="Equipment with this patrimony already exists")
    equipment = equipmentDAO.create(new_equipment)

    if equipment == None:
        raise HTTPException(status_code=500)
    
    return equipment

@router.get("/read-one", status_code=status.HTTP_200_OK)
def read_one_equipment(patrimonio: str):
    equipmentDAO = EquipmentDAO()
    equipment = equipmentDAO.read_one(patrimonio)

    if equipment == None:
        raise HTTPException(status_code=404, detail="Equipment not found")
    if equipment == False:
        raise HTTPException(status_code=500)

    return equipment

@router.get("/get-equipments-by-current-room", status_code=status.HTTP_200_OK)
def read_equipments_by_current_room(current_room: str):
    equipmentDAO = EquipmentDAO()
    equipment = equipmentDAO.get_equipments_by_current_room(current_room)
 
    if equipment == False:
        raise HTTPException(status_code=500)
    return equipment

@router.put("/update", status_code=status.HTTP_200_OK)
def update_equipment(update_data: Equipment_update):
    equipmentDAO = EquipmentDAO()
    update_status = equipmentDAO.update(update_data)

    if update_status == False:
        raise HTTPException(status_code=404, detail="No equipment found")
    elif update_status == None:
        raise HTTPException(status_code=500)
    
    return update_status

@router.delete("/delete", status_code=status.HTTP_200_OK)
def delete_equipment(patrimonio: str):
    equipmentDAO = EquipmentDAO()
    status = equipmentDAO.delete(patrimonio)

    if status == False:
        raise HTTPException(status_code=404, detail="Equipment not found")
    elif status == None:        
        raise HTTPException(status_code=500)
    
    return status

@router.get("/history", status_code=status.HTTP_200_OK)
def history_equipment():
    equipmentDAO = EquipmentDAO()
    status = equipmentDAO.get_history()

    if status == []:
        raise HTTPException(status_code=404, detail="Equipment not found")
    if status == None:
        raise HTTPException(status_code=500)

    return status

# @router.put("/update-maintenance", status_code=status.HTTP_200_OK)
# def update_maintenante_equipment(update_data: Equipment_maintenance):
#     equipmentDAO = EquipmentDAO()
#     update_status = equipmentDAO.update_maintenance(update_data)

#     if update_status == False:
#         raise HTTPException(status_code=404, detail="No equipment found")
#     elif update_status == None:
#         raise HTTPException(status_code=500)

#     return update_status