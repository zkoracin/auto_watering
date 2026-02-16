# Auto-Watering (ESP8266 + Flutter)

🚧 **Work in Progress**
This is a personal play/learning project exploring an **auto-watering solution** built with an **ESP8266** and a **Flutter + Riverpod**. The goal is to learn by building while creating a small IoT system.

## Tech Stack

- **Hardware:** ESP8266 + custom electronic circuit controlling a water pump
- **App:** Flutter  
- **State Management:** Riverpod  
- **Communication:** Wi-Fi (local network), HTTP (future: MQTT/WebSockets)


## Features

- Display and sync ESP device time
- Test ESP device connection
- Manual pump ON/OFF control
- Configure schedule (time, start day, interval) - schedule is always active
- Set and test pump runtime duration
- View current schedule status

## Future

- WiFi provisioning  
- Real-time updates via WebSockets or MQTT (currently using HTTP requests)  
- UI enhancements to support adding and managing multiple devices 