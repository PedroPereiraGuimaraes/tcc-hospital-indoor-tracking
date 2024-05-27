from fastapi import APIRouter, status
from src.database.repository.equipment import EquipmentDAO
from src.app.models import Equipment, Equipment_maintenance

router = APIRouter()

@router.get("/read-all", status_code=status.HTTP_200_OK)
def get_all_equipments():
    equipmentDAO = EquipmentDAO()

    equipments = equipmentDAO.get_all()

    return equipments

@router.post("/create", status_code=status.HTTP_201_CREATED)
def create_equipment(equipment: Equipment):
    equipmentDAO = EquipmentDAO()

    equipments = equipmentDAO.create(equipment)

    return equipments

@router.get("/read-one", status_code=status.HTTP_200_OK)
def read_one_equipment(patrimonio: str):
    equipmentDAO = EquipmentDAO()

    equipment = equipmentDAO.read_one(patrimonio)

    return equipment

@router.get("/get-equipments-by-current-room", status_code=status.HTTP_200_OK)
def read_equipments_by_current_room(current_room: str):
    equipmentDAO = EquipmentDAO()

    equipment = equipmentDAO.get_equipments_by_current_room(current_room)

    return equipment

@router.put("/update", status_code=status.HTTP_200_OK)
def update_equipment(update_data: Equipment):
    equipmentDAO = EquipmentDAO()
    update_status = equipmentDAO.update(update_data)

    return update_status

@router.delete("/delete", status_code=status.HTTP_200_OK)
def delete_equipment(patrimonio: str):
    equipmentDAO = EquipmentDAO()
    status = equipmentDAO.delete(patrimonio)

    return status

@router.get("/history", status_code=status.HTTP_200_OK)
def history_equipment(patrimonio: str):
    equipmentDAO = EquipmentDAO()
    status = equipmentDAO.get_history(patrimonio)

    return status

@router.put("/update-maintenance", status_code=status.HTTP_200_OK)
def update_maintenante_equipment(update_data: Equipment_maintenance):
    equipmentDAO = EquipmentDAO()
    update_status = equipmentDAO.update_maintenance(update_data)

    return update_status