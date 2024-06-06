from fastapi import APIRouter, status, HTTPException
from src.database.repository.room import RoomDAO
from src.app.models import Room_data

router = APIRouter()

@router.get("/read-all", status_code=status.HTTP_200_OK)
def get_all_rooms():
    roomDAO = RoomDAO()
    rooms = roomDAO.get_all()

    if rooms == None:
        raise HTTPException(status_code=500)
    return rooms

@router.post("/create", status_code=status.HTTP_201_CREATED)
def create_room(room: Room_data):
    roomDAO = RoomDAO()

    room_ = roomDAO.read_one(room.name)
    if room_:
        raise HTTPException(status_code=409, detail="This room already exists")
    status_creation = roomDAO.create(room.name)

    if status_creation == None:
        raise HTTPException(status_code=500)
    
    return status_creation

#Por enquanto não haverá salas com mesmo nome
@router.get("/read-one", status_code=status.HTTP_200_OK)
def read_one_room(name: str):
    roomDAO = RoomDAO()
    room = roomDAO.read_one(name)
    
    if room == None:
        raise HTTPException(status_code=404, detail="Room not found")
    if room == False:
        raise HTTPException(status_code=500)
    
    return room

@router.delete("/delete", status_code=status.HTTP_200_OK)
def delete_room(uuid: str):
    roomDAO = RoomDAO()
    status = roomDAO.delete(uuid)

    if status == False:
        raise HTTPException(status_code=404, detail="Room not found")
    elif status == None:        
        raise HTTPException(status_code=500)

    return status