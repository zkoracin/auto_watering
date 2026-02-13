#pragma once
#include <Arduino.h>
#include "storage/device_storage.h"

class DeviceClock {
public:
  DeviceTime getTime() const {
    return device.getDeviceTime();
  }

  void setTime(const DeviceTime& time) {
    device.setDeviceTime(time);
  }

  void begin() {
    lastUpdateMillis = millis();
    initialized = true;
  }

  void updateTime() {
    if (!initialized) return;

    unsigned long now = millis();
    unsigned long elapsed = now - lastUpdateMillis;

    // Advance every minute (60000 ms)
    while (elapsed >= 60000) {
      incrementMinute();
      lastUpdateMillis += 60000;
      elapsed -= 60000;
    }
  }

private:
  void incrementMinute() {
    DeviceTime t = getTime();

    t.minute++;

    if (t.minute >= 60) {
      t.minute = 0;
      t.hour++;

      if (t.hour >= 24) {
        t.hour = 0;
        t.day++;

        // rollover (1–7)
        if (t.day > 7) {
          t.day = 1; // Back to Monday
        }
      }
    }

    setTime(t);
  }

  unsigned long lastUpdateMillis = 0;
  bool initialized = false;
};

extern DeviceClock deviceClock;
