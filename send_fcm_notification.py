"""
FCM Custom Sound Notification Sender
====================================
This script sends FCM notifications with custom sound to Android devices.

Requirements:
1. Install dependencies:
   pip install firebase-admin

2. Place your Firebase service account JSON file in the same directory
   or update the path below

3. Get device FCM token from Flutter app logs

Usage:
    python send_fcm_notification.py
"""

import firebase_admin
from firebase_admin import credentials, messaging
import json

# ============================================================================
# CONFIGURATION - UPDATE THESE VALUES
# ============================================================================

# Path to your Firebase service account JSON file
# Download from: Firebase Console > Project Settings > Service Accounts > Generate New Private Key
SERVICE_ACCOUNT_PATH = "service-account.json"

# Device FCM token (get from Flutter app logs)
DEVICE_TOKEN = "YOUR_DEVICE_FCM_TOKEN_HERE"

# ============================================================================

def initialize_firebase():
    """Initialize Firebase Admin SDK"""
    try:
        cred = credentials.Certificate(SERVICE_ACCOUNT_PATH)
        firebase_admin.initialize_app(cred)
        print("✅ Firebase Admin SDK initialized successfully")
    except Exception as e:
        print(f"❌ Error initializing Firebase: {e}")
        exit(1)

def send_notification_with_custom_sound(token, title, body):
    """
    Send FCM notification with custom sound

    Args:
        token: Device FCM token
        title: Notification title
        body: Notification body
    """

    # Build the message with custom sound
    message = messaging.Message(
        notification=messaging.Notification(
            title=title,
            body=body,
        ),
        android=messaging.AndroidConfig(
            notification=messaging.AndroidNotification(
                channel_id='custom_channel',  # Must match app channel ID
                sound='alert',                 # Custom sound (without extension)
                priority='high',
                default_vibrate_timings=False,
                vibrate_timings_millis=[0, 500, 500, 500],
            ),
        ),
        token=token,
    )

    try:
        # Send the message
        response = messaging.send(message)
        print(f"✅ Notification sent successfully!")
        print(f"   Message ID: {response}")
        return response
    except Exception as e:
        print(f"❌ Error sending notification: {e}")
        return None

def send_notification_with_data_payload(token, title, body, data=None):
    """
    Send FCM notification with custom sound and data payload

    Args:
        token: Device FCM token
        title: Notification title
        body: Notification body
        data: Optional data payload (dict)
    """

    if data is None:
        data = {}

    # Build the message with custom sound and data
    message = messaging.Message(
        notification=messaging.Notification(
            title=title,
            body=body,
        ),
        android=messaging.AndroidConfig(
            notification=messaging.AndroidNotification(
                channel_id='custom_channel',  # Must match app channel ID
                sound='alert',                 # Custom sound (without extension)
                priority='high',
                color='#1771B7',              # Notification color
            ),
        ),
        data=data,  # Additional data payload
        token=token,
    )

    try:
        # Send the message
        response = messaging.send(message)
        print(f"✅ Notification with data sent successfully!")
        print(f"   Message ID: {response}")
        return response
    except Exception as e:
        print(f"❌ Error sending notification: {e}")
        return None

def main():
    """Main function"""
    print("=" * 60)
    print("FCM Custom Sound Notification Sender")
    print("=" * 60)

    # Check if token is set
    if DEVICE_TOKEN == "YOUR_DEVICE_FCM_TOKEN_HERE":
        print("\n❌ Error: Please set your device FCM token in the script!")
        print("   Look for this in your Flutter app logs:")
        print("   🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑 Device Token: <YOUR_TOKEN>")
        return

    # Initialize Firebase
    initialize_firebase()

    print("\n" + "=" * 60)
    print("Select notification type:")
    print("=" * 60)
    print("1. Simple notification with custom sound")
    print("2. Notification with custom sound + data payload")
    print("=" * 60)

    choice = input("\nEnter your choice (1 or 2): ").strip()

    if choice == "1":
        # Send simple notification
        print("\n📤 Sending simple notification with custom sound...")
        send_notification_with_custom_sound(
            token=DEVICE_TOKEN,
            title="Hello Billal! 🔔",
            body="This is a test notification with custom sound!"
        )

    elif choice == "2":
        # Send notification with data
        print("\n📤 Sending notification with custom sound and data...")
        custom_data = {
            "type": "custom_notification",
            "action": "open_screen",
            "screen": "notification_details",
            "timestamp": str(int(firebase_admin.firestore.SERVER_TIMESTAMP))
        }
        send_notification_with_data_payload(
            token=DEVICE_TOKEN,
            title="Custom Data Notification 📦",
            body="This notification includes custom data payload!",
            data=custom_data
        )

    else:
        print("❌ Invalid choice!")

    print("\n" + "=" * 60)
    print("Done!")
    print("=" * 60)

if __name__ == "__main__":
    main()

