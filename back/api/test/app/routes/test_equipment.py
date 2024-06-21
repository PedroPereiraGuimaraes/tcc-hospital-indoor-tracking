from fastapi.testclient import TestClient
from test.utils.mockEquipment import valid_create_equipment, valid_update_equipment, valid_update_equipment_fail


def test_get_all_equipments(client: TestClient) -> None:
    response = client.get('/equipment/read-all')
    assert response.status_code == 200

def test_create_equipment(client: TestClient) -> None:
    body = valid_create_equipment()
    response = client.post("/equipment/create", json=body)
    assert response.status_code == 201

def test_create_equipment_wrong_body(client: TestClient) -> None:
    body = {}
    response = client.post("/equipment/create", json=body)
    assert response.status_code == 422

def test_create_equipment_fail(client: TestClient) -> None:
    body = valid_create_equipment()
    response = client.post("/equipment/create", json=body)
    assert response.status_code == 409

def test_read_one_equipment(client: TestClient) -> None:
    patrimonio = "string"
    response = client.get(f"/equipment/read-one?patrimonio={patrimonio}")
    assert response.status_code == 200

def test_read_one_equipment_fail(client: TestClient) -> None:
    patrimonio = "string1"
    response = client.get(f"/equipment/read-one?patrimonio={patrimonio}")
    assert response.status_code == 404

def test_read_equipments_by_current_room(client: TestClient) -> None:
    current_room = "sala1"
    response = client.get(f"/equipment/get-equipments-by-current-room?current_room={current_room}")
    assert response.status_code == 200

def test_update_equipment(client: TestClient) -> None:
    body = valid_update_equipment()
    response = client.put("/equipment/update", json=body)
    assert response.status_code == 200

def test_update_equipment_fail(client: TestClient) -> None:
    body = valid_update_equipment_fail()
    response = client.put("/equipment/update", json=body)
    assert response.status_code == 404

def test_history_equipment(client: TestClient) -> None:
    response = client.get(f"/equipment/history")
    assert response.status_code == 200

def test_delete_equipment(client: TestClient) -> None:
    patrimonio = "string"
    response = client.delete(f"/equipment/delete?patrimonio={patrimonio}")
    assert response.status_code == 200

def test_delete_equipment_fail(client: TestClient) -> None:
    patrimonio = "string2"
    response = client.delete(f"/equipment/delete?patrimonio={patrimonio}")
    assert response.status_code == 404