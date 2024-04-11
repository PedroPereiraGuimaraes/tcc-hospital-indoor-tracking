from fastapi import APIRouter
from database.repository.user import UserDAO
from api.models import User, User_login

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
    user = userDAO.login_authentication(user_login.register, user_login.password)

    return user

