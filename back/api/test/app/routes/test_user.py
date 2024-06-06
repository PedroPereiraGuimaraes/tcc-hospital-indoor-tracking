from fastapi.testclient import TestClient
from test.utils.mockUser import valid_user, valid_login, valid_user_change_admin, valid_user_update,valid_login_fail, valid_user_change_admin_fail, valid_user_update_fail
 
# read all when it doesn't have any user 
def test_read_all(client: TestClient) -> None:
    response = client.get('/user/read-all')
    assert response.status_code == 200

def test_create_new_user(client: TestClient) -> None:
    body = valid_user()
    response = client.post("/user/create", json=body)
    assert response.status_code == 201

def test_create_new_user_wrong_body(client: TestClient) -> None:
    body = {}
    response = client.post("/user/create", json=body)
    assert response.status_code == 422

def test_create_new_user_fail(client: TestClient) -> None:
    body = valid_user()
    response = client.post("/user/create", json=body)
    assert response.status_code == 409

def test_login_valid(client: TestClient) -> None:
    body = valid_login()
    response = client.post("/user/login", json=body)
    assert response.status_code == 200

def test_login_valid_fail(client: TestClient) -> None:
    body = valid_login_fail()
    response = client.post("/user/login", json=body)
    assert response.status_code == 401

def test_changeAdmin(client: TestClient) -> None:
    body = valid_user_change_admin()
    response = client.post("/user/change-user-admin", json=body)
    assert response.status_code == 200

def test_changeAdmin_fail(client: TestClient) -> None:
    body = valid_user_change_admin_fail()
    response = client.post("/user/change-user-admin", json=body)
    assert response.status_code == 404

def test_update_user(client: TestClient) -> None:
    body = valid_user_update()
    response = client.put("/user/update", json=body)
    assert response.status_code == 200

def test_update_user_fail(client: TestClient) -> None:
    body = valid_user_update_fail()
    response = client.put("/user/update", json=body)
    assert response.status_code == 404

def test_deleteUser(client: TestClient) -> None:
    param = "string"
    response = client.delete(f"/user/delete?user_register={param}")
    assert response.status_code == 200

def test_deleteUser_fail(client: TestClient) -> None:
    param = "string1"
    response = client.delete(f"/user/delete?user_register={param}")
    assert response.status_code == 404