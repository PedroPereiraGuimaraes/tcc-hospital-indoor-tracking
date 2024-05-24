from fastapi import APIRouter
from src.database.repository.room import RoomDAO
from src.app.models import Room_data

router = APIRouter()

@router.get("/read-all")
def get_all_rooms():
    roomDAO = RoomDAO()

    rooms = roomDAO.get_all()

    return rooms

@router.post("/create")
def create_room(room: Room_data):
    roomDAO = RoomDAO()

    status_creation = roomDAO.create(room.name)

    return status_creation

#Por enquanto não haverá salas com mesmo nome
@router.get("/read-one")
def read_one_room(name: str):
    roomDAO = RoomDAO()

    room = roomDAO.read_one(name)

    return room

# @router.put("/update")
# def update_room(update_data:str ):
#     equipmentDAO = EquipmentDAO()
#     update_status = equipmentDAO.update(update_data)

#     return update_status

@router.delete("/delete")
def deleteUser(uuid: str):
    roomDAO = RoomDAO()
    status = roomDAO.delete(uuid)

    return status