from fastapi import APIRouter
from database.repository.equipment import EquipmentDAO

router = APIRouter()

@router.get("/read-all")
def get_all_equipaments():
    equipmentDAO = EquipmentDAO()

    equipments = equipmentDAO.get_all()

    return equipments