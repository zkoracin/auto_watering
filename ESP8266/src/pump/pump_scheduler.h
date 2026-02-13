#pragma once
#include <Arduino.h>
#include "storage/pump_storage.h"
#include "device/device_clock.h"
#include "pump.h"

class PumpScheduler {
public:
  void begin() {
    lastCheckMinute = deviceClock.getTime().minute;
  }

  void update() {
    DeviceTime now = deviceClock.getTime();

    // Only check once per minute
    if (now.minute == lastCheckMinute) return;
    lastCheckMinute = now.minute;

    ScheduleEntry schedule = pump.getSchedule();
    uint16_t runtime = pump.getRuntime();

    // Check if today is scheduled
    if (isScheduledDay(now.day, schedule.startDay, schedule.interval.length)) {
      if (now.hour == schedule.hour && now.minute == schedule.minute) {
        pumpRunForSeconds(runtime);
      }
    }
  }

private:
  uint8_t lastCheckMinute = 255;

  // Check if today is a scheduled day based on interval
  bool isScheduledDay(uint16_t currentDay, uint8_t startDay, uint8_t interval) {
    if (interval == 1) return true; // every day

    // Convert 1–7 weekday to 0–6
    uint8_t current = (currentDay - 1) % 7;
    uint8_t start = (startDay - 1) % 7;

    // interval > 1: every n days
    // calculate distance from start
    uint8_t distance = (current + 7 - start) % 7;
    return (distance % interval) == 0;
  }
};

extern PumpScheduler pumpScheduler;
