#pragma once
#include <Arduino.h>
#include "storage_manager.h"

class DeviceStorage {
public:
  DeviceTime getDeviceTime() const {
    return deviceTime;
  }
  void setDeviceTime(const DeviceTime& time) {
    deviceTime.day = (time.day >= 1 && time.day <= 7) ? time.day : 1;
    deviceTime.hour = (time.hour <= 23) ? time.hour : 0;
    deviceTime.minute = (time.minute <= 59) ? time.minute : 0;
  }

  void loadDeviceTime() {
    deviceTime = Storage.read<DeviceTime>(EEPROM_ADDR_DEVICE_TIME);
    // reset to day 1, 00:00
    if (deviceTime.day < 1 || deviceTime.day > 7 || deviceTime.hour > 23 ||
        deviceTime.minute > 59) {
      deviceTime.day = 1;
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
