import os

from typing import Generator
from fastapi.testclient import TestClient
import pytest
from main import api

os.environ['ENV_QA'] = 'True'

@pytest.fixture(scope="function")
def client() -> Generator:
    with TestClient(api) as client:
        yield client

