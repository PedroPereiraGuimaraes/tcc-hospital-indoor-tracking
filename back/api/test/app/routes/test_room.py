from fastapi.testclient import TestClient

def test_read_all(client: TestClient) -> None:
    response = client.get('/room/read-all')
    assert response.status_code == 200

def test_create_new_room(client: TestClient) -> None:
    body = {"name": "sala 1"}
    response = client.post("/room/create", json=body)
    assert response.status_code == 201

def test_read_one_room(client: TestClient) -> None:
    param = "sala 1"
    response = client.get(f"/room/read-one?name={param}")
    assert response.status_code == 200

def test_deleteUser(client: TestClient):
    # getting uuid to pass as parameter to delete room
    param = "sala 1"
    aux_response = client.get(f"/room/read-one?name={param}")
    aux_content = aux_response.json()
    print(aux_content)
    uuid = aux_content["uuid"]

    response = client.delete(f"/room/delete?uuid={uuid}")
    assert response.status_code == 200
