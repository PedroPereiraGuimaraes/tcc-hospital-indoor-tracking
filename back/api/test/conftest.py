from typing import Generator
from fastapi.testclient import TestClient
import pytest
from main import api

@pytest.fixture(scope="function")
def client() -> Generator:
    with TestClient(api) as client:
        yield client