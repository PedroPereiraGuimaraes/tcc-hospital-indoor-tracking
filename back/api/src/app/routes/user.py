from fastapi import APIRouter, status, Response, HTTPException
from src.database.repository.user import UserDAO
from src.app.models import User, User_login, New_user_admin

router = APIRouter()

@router.get("/read-all", status_code=status.HTTP_200_OK)
def get_all_users():
    userDAO = UserDAO()
    users = userDAO.get_all()

    if users == None:
        raise HTTPException(status_code=500)

    return users

@router.post("/create", status_code=status.HTTP_201_CREATED)
def create_new_user(new_user: User):
    userDAO = UserDAO()
    user = userDAO.get_user_by_register(new_user.register_)
    if user:
        raise HTTPException(status_code=409, detail="User with this register already exists")

    creation_status = userDAO.create_user(new_user)

    if creation_status == None:
        raise HTTPException(status_code=500)

    return creation_status

@router.post("/login", status_code=status.HTTP_200_OK)
def login(user_login:User_login):
    userDAO = UserDAO()
    user_login = userDAO.login_authentication(user_login.email, user_login.password)

    if user_login == None:
        raise HTTPException(status_code=401, detail="Login not found")
    
    return user_login

@router.post("/change-user-admin", status_code=status.HTTP_200_OK)
def changeAdmin(new_user_admin:New_user_admin):
    userDAO = UserDAO()
    user_updated = userDAO.change_admin(new_user_admin.register_, new_user_admin.is_admin)

    if user_updated == False:
        raise HTTPException(status_code=404, detail="User not found")
    elif user_updated == None:
        raise HTTPException(status_code=500)


    return user_updated

@router.delete("/delete", status_code=status.HTTP_200_OK)
def deleteUser(user_register: str):
    userDAO = UserDAO()
    status = userDAO.delete_user(user_register)

    if status == False:
        raise HTTPException(status_code=404, detail="User not found")
    elif status == None:        
        raise HTTPException(status_code=500)

    return status

@router.put("/update", status_code=status.HTTP_200_OK)
def update_user(update_user: User):
    userDAO = UserDAO()
    creation_status = userDAO.update_user(update_user)

    if creation_status == False:
        raise HTTPException(status_code=404, detail="User not found")
    elif creation_status == None:        
        raise HTTPException(status_code=500)
    
    return creation_status
