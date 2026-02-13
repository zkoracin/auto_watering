# Auto-Watering (ESP8266 + Flutter)

🚧 **Work in Progress**
This is a personal play/learning project exploring an **auto-watering solution** built with an **ESP8266** and a **Flutter + Riverpod**. The goal is to learn by building while creating a small IoT system.


## What It Aims to Do

- Control watering behavior remotely
- Provide a simple web/mobile interface for configuration
- Persist configuration on the device
- Automation logic based on watering schedules

## Tech Stack

- **Hardware:** ESP8266 + custom electronic circuit controlling a water pump
- **App:** Flutter  
- **State Management:** Riverpod  
- **Communication:** Wi-Fi (local network), HTTP (future: MQTT/WebSockets)


## Current Status

- ✅ ESP8266 firmware runs
- ✅ Flutter app is functional with Riverpod for state management
- ✅ Manual watering and configuration work
- ✅ Automatic watering works with schedule sync from the app
- 🛠️ Missing final design polish
- 🛠️ Preserve current page/tab on reload
- 🛠️ Build cross-platform support

## Future
 - 🌍 Localization (multi-language support)
 - 🌐 Implement WebSockets or MQTT for real-time updates