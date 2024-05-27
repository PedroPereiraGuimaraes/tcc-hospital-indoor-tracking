from fastapi import APIRouter, status
from src.database.repository.room import RoomDAO
from src.app.models import Room_data

router = APIRouter()

@router.get("/read-all", status_code=status.HTTP_200_OK)
def get_all_rooms():
    roomDAO = RoomDAO()

    rooms = roomDAO.get_all()

    return rooms

@router.post("/create", status_code=status.HTTP_201_CREATED)
def create_room(room: Room_data):
    roomDAO = RoomDAO()

    status_creation = roomDAO.create(room.name)

    return status_creation

#Por enquanto não haverá salas com mesmo nome
@router.get("/read-one", status_code=status.HTTP_200_OK)
def read_one_room(name: str):
    roomDAO = RoomDAO()

    room = roomDAO.read_one(name)

    return room

# @router.put("/update")
# def update_room(update_data:str ):
#     equipmentDAO = EquipmentDAO()
#     update_status = equipmentDAO.update(update_data)

#     return update_status

@router.delete("/delete", status_code=status.HTTP_200_OK)
def deleteUser(uuid: str):
    roomDAO = RoomDAO()
    status = roomDAO.delete(uuid)

    return status