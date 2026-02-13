#pragma once
#include <Arduino.h>

struct ScheduleInterval {
  uint8_t length;
  uint8_t min;
  uint8_t max;

  ScheduleInterval(uint8_t len = PUMP_MIN_INTERVAL, uint8_t minVal = PUMP_MIN_INTERVAL,
                   uint8_t maxVal = PUMP_MAX_INTERVAL)
      : length(len), min(minVal), max(maxVal) {
  }
};
struct ScheduleEntry {
  uint8_t hour;
  uint8_t minute;
  ScheduleInterval interval;
  uint8_t startDay;
};

struct DeviceTime {
  uint8_t day;
  uint8_t hour;
  uint8_t minute;
};

struct RuntimeLimits {
  uint8_t min;
  uint16_t max;
};
