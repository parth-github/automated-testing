import requests
import sys

ENDPOINT = "https://your-ecs-service.example.com/health"

def test_e2e():
    try:
        response = requests.get(ENDPOINT, timeout=10)
        if response.status_code == 200:
            print(f"[PASS] Endpoint reachable: {ENDPOINT}")
        else:
            print(f"[FAIL] Endpoint returned status code: {response.status_code}")
            sys.exit(1)
    except requests.RequestException as e:
        print(f"[ERROR] Failed to reach endpoint: {e}")
        sys.exit(1)

if __name__ == "__main__":
    test_e2e()
