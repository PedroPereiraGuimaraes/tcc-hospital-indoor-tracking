from pydantic import BaseModel
from datetime import datetime
class Equipment(BaseModel):
    name: str
    patrimonio: str
    # historic: dict

class Equipment_update(BaseModel):
    patrimonio: str
    name: str
    last_maintenance: datetime
    next_maintenance: datetime

class User(BaseModel):
    name: str
    email: str
    password: str
    register_: str

class User_login(BaseModel):
    email: str
    password: str

class New_user_admin(BaseModel):
    register_: str
    is_admin: bool

class Room_data(BaseModel):
    name: str
    # equipment: dict

class Room_response(BaseModel):
    uuid: str
    name: str