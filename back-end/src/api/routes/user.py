from fastapi import APIRouter
from database.repository.user import UserDAO

router = APIRouter()

@router.get("/read-all")
def get_all_users():
    userDAO = UserDAO()

    users = userDAO.get_all()

    return users