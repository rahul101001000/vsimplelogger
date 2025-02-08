from fastapi.testclient import TestClient
from main import app

client = TestClient(app)


def test_log_action():
    response = client.post("/log", json={
        "user": "test_user",
        "action": "test_action",
        "timestamp": "2023-10-01T12:34:56Z"
    })
    assert response.status_code == 200
    assert response.json() == {"message": "Log recorded successfully"}
