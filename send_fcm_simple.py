"""
Simple FCM Notification Sender using HTTP v1 API
================================================
This script sends FCM notifications using the HTTP v1 API with OAuth2.

Requirements:
    pip install google-auth requests

Usage:
    python send_fcm_simple.py
"""

from google.oauth2 import service_account
from google.auth.transport.requests import Request
import requests
import json

# ============================================================================
# CONFIGURATION
# ============================================================================

# Path to Firebase service account JSON
SERVICE_ACCOUNT_FILE = "service-account.json"

# Your Firebase project ID
PROJECT_ID = "senaeya-59503"

# Device FCM token
DEVICE_TOKEN = "YOUR_DEVICE_FCM_TOKEN_HERE"

# ============================================================================

def get_access_token():
    """Get OAuth2 access token for FCM"""
    credentials = service_account.Credentials.from_service_account_file(
        SERVICE_ACCOUNT_FILE,
        scopes=["https://www.googleapis.com/auth/firebase.messaging"]
    )
    credentials.refresh(Request())
    return credentials.token

def send_fcm_notification(token, title, body):
    """Send FCM notification with custom sound"""

    access_token = get_access_token()

    url = f"https://fcm.googleapis.com/v1/projects/{PROJECT_ID}/messages:send"

    headers = {
        "Authorization": f"Bearer {access_token}",
        "Content-Type": "application/json"
    }

    payload = {
        "message": {
            "token": token,
            "notification": {
                "title": title,
                "body": body
            },
            "android": {
                "notification": {
                    "channel_id": "custom_channel",
                    "sound": "alert",
                    "priority": "high",
                    "color": "#1771B7"
                }
            }
        }
    }

    response = requests.post(url, headers=headers, json=payload)

    if response.status_code == 200:
        print(f"✅ Notification sent successfully!")
        print(f"   Response: {response.json()}")
    else:
        print(f"❌ Error: {response.status_code}")
        print(f"   {response.text}")

if __name__ == "__main__":
    print("=" * 60)
    print("FCM Custom Sound Notification Sender (Simple)")
    print("=" * 60)

    if DEVICE_TOKEN == "YOUR_DEVICE_FCM_TOKEN_HERE":
        print("\n❌ Please set DEVICE_TOKEN in the script!")
        exit(1)

    print("\n📤 Sending notification...")
    send_fcm_notification(
        token=DEVICE_TOKEN,
        title="Hello Billal! 🔔",
        body="Custom sound notification test!"
    )

