from fastapi import APIRouter, status, Response
from src.database.repository.user import UserDAO
from src.app.models import User, User_login, New_user_admin

router = APIRouter()

@router.get("/read-all", status_code=status.HTTP_200_OK)
def get_all_users():
    userDAO = UserDAO()
    users = userDAO.get_all()

    return users

@router.post("/create", status_code=status.HTTP_201_CREATED)
def create_new_user(new_user: User, response: Response):
    userDAO = UserDAO()
    creation_status = userDAO.create_user(new_user)

    if creation_status == False:
        response.status_code = status.HTTP_500_INTERNAL_SERVER_ERROR
    elif creation_status == {"Error messagem": "Usuário existente"}:
        response.status_code = status.HTTP_400_BAD_REQUEST

    return creation_status

@router.post("/login", status_code=status.HTTP_200_OK)
def login(user_login:User_login):
    userDAO = UserDAO()
    user_verify = userDAO.login_authentication(user_login.email, user_login.password)

    return user_verify

@router.post("/change-user-admin", status_code=status.HTTP_200_OK)
def changeAdmin(new_user_admin:New_user_admin):
    userDAO = UserDAO()
    user_verify = userDAO.change_admin(new_user_admin.register_, new_user_admin.is_admin)

    return user_verify

@router.delete("/delete", status_code=status.HTTP_200_OK)
def deleteUser(user_register: str):
    userDAO = UserDAO()
    status = userDAO.delete_user(user_register)

    return status

@router.put("/update", status_code=status.HTTP_200_OK)
def update_user(update_user: User):
    userDAO = UserDAO()
    creation_status = userDAO.update_user(update_user)

    return creation_status
