# Auto-Watering (ESP8266 + Flutter)

> 🚧 **Work in Progress**
>
> This is a personal play project exploring an **auto-watering solution** built with an **ESP8266** and a **Flutter + Riverpod**.
>  
> The project mostly works, but some features are still experimental or incomplete.

---

## Overview

This project experiments with an **automatic plant watering system** consisting of:

- An **ESP8266-based device** responsible for:
  - Running a web server
  - Persisting configuration (EEPROM)
  - Controlling the water pump
- A **Flutter mobile app** used for monitoring, configuration, and testing

---

## What It Aims to Do

- Control watering behavior remotely
- Provide a simple mobile interface for configuration
- Persist configuration on the device
- Explore automation logic based on **watering schedules**

---

## Tech Stack

- **Hardware:** ESP8266  
- **App:** Flutter  
- **State Management:** Riverpod  
- **Communication:** Wi-Fi (local network)

---

## Current Status

- ✅ ESP8266 firmware runs
- ✅ Flutter app is functional and uses Riverpod for state management
- ✅ Manual watering and configuration work
- ⚠️ Minor bugs
- ❌ Automatic watering based on saved schedules is not fully working yet

---
