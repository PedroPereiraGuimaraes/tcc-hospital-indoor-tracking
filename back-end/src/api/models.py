from pydantic import BaseModel

class Equipment(BaseModel):
    name: str
    patrimonio: str
    maintenance: bool
    current_room: str
    current_date: str
    # historic: dict

class Equipment_maintenance(BaseModel):
    patrimonio: str
    maintenance: bool

class User(BaseModel):
    name: str
    email: str
    password: str
    register: str

class User_login(BaseModel):
    email: str
    password: str

class New_user_admin(BaseModel):
    register: str
    is_admin: bool

class Room_data(BaseModel):
    name: str
    # equipment: dict

class Room_response(BaseModel):
    uuid: str
    name: str