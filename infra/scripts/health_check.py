import requests
import sys

HEALTH_URL = "https://your-ecs-service.example.com/health"

def health_check():
    try:
        resp = requests.get(HEALTH_URL, timeout=5)
        if resp.status_code == 200:
            print(f"[PASS] Health check passed.")
        else:
            print(f"[FAIL] Health check failed. Status code: {resp.status_code}")
            sys.exit(1)
    except Exception as e:
        print(f"[ERROR] Exception during health check: {e}")
        sys.exit(1)

if __name__ == "__main__":
    health_check()
