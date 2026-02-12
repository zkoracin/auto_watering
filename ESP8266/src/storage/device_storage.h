#pragma once
#include <Arduino.h>
#include "storage_manager.h"

class DeviceStorage {
public:
  DeviceTime getDeviceTime() const {
    return deviceTime;
  }
  void setDeviceTime(const DeviceTime& time) {
    deviceTime = time;
  }

  void loadDeviceTime() {
    deviceTime = Storage.read<DeviceTime>(EEPROM_ADDR_DEVICE_TIME);
    // If uninitialized, reset to day 0, 00:00
    if (deviceTime.day == 0xFFFF) {
      deviceTime.day = 0;
      deviceTime.hour = 0;
      deviceTime.minute = 0;
    }
  }

  void saveDeviceTime() {
    Storage.write<DeviceTime>(EEPROM_ADDR_DEVICE_TIME, deviceTime,
                              false); // write without auto-commit
    Storage.commit();
  }

private:
  DeviceTime deviceTime{};
};

extern DeviceStorage device;
