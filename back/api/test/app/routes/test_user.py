from fastapi.testclient import TestClient
# from main import api
 
# client = TestClient(api)
 
def test_read_all(client: TestClient) -> None:
    response = client.get('/user/read-all')
    assert response.status_code == 200