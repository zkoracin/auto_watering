#pragma once
#include <Arduino.h>

struct ScheduleEntry {
  uint8_t hour;
  uint8_t minute;
  uint8_t interval;
  uint8_t startDay;
};

struct DeviceTime {
  uint16_t day;
  uint8_t hour;
  uint8_t minute;
};

struct RuntimeLimits {
  uint16_t min;
  uint16_t max;
};