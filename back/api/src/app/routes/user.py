from fastapi import APIRouter
from src.database.repository.user import UserDAO
from src.app.models import User, User_login, New_user_admin

router = APIRouter()

@router.get("/read-all")
def get_all_users():
    userDAO = UserDAO()
    users = userDAO.get_all()

    return users

@router.post("/create")
def create_new_user(new_user: User):
    userDAO = UserDAO()
    creation_status = userDAO.create_user(new_user)

    return creation_status

@router.post("/login")
def login(user_login:User_login):
    userDAO = UserDAO()
    user_verify = userDAO.login_authentication(user_login.email, user_login.password)

    return user_verify

@router.post("/change-user-admin")
def changeAdmin(new_user_admin:New_user_admin):
    userDAO = UserDAO()
    user_verify = userDAO.change_admin(new_user_admin.register, new_user_admin.is_admin)

    return user_verify

@router.delete("/delete")
def deleteUser(user_register: str):
    userDAO = UserDAO()
    status = userDAO.delete_user(user_register)

    return status

@router.put("/update")
def update_user(update_user: User):
    userDAO = UserDAO()
    creation_status = userDAO.update_user(update_user)

    return creation_status
