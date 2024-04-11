from pydantic import BaseModel


class Equipment(BaseModel):
    name: str
    patrimonio: int
    maintenance: bool
    current_room: str
    current_date: str
    historic: dict

class User(BaseModel):
    name: str
    email: str
    password: str
    register: str

class User_login(BaseModel):
    register: str
    password: str

class Room(BaseModel):
    name: str
    equipment: dict