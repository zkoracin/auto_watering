#pragma once
#include <Arduino.h>
#include "storage_manager.h"

class PumpStorage {
public:
  uint16_t getRuntime() const {
    return runtime;
  }

  RuntimeLimits getRuntimeLimits() const {
    return {.min = minRuntime, .max = maxRuntime};
  }

  void setRuntime(uint16_t seconds) {
    runtime = constrain(seconds, minRuntime, maxRuntime);
  }

  void loadRuntime() {
    runtime = Storage.read<uint16_t>(EEPROM_ADDR_PUMP_SECONDS, minRuntime);
  }

  void saveRuntime() {
    Storage.write<uint16_t>(EEPROM_ADDR_PUMP_SECONDS, runtime);
  }

  ScheduleEntry getSchedule() const {
    return schedule;
  }

  void setSchedule(const ScheduleEntry& entry) {
    schedule.hour = entry.hour;
    schedule.minute = entry.minute;
    schedule.interval = constrain(entry.interval.length, entry.interval.min, entry.interval.max);
    schedule.startDay = (entry.startDay >= 1 && entry.startDay <= 7) ? entry.startDay : 1;
  }

  void loadSchedule() {
    schedule = Storage.read<ScheduleEntry>(EEPROM_ADDR_PUMP_SCHEDULE);
    if (schedule.interval.length < schedule.interval.min ||
        schedule.interval.length > schedule.interval.max) {
      schedule.interval = schedule.interval.min;
      schedule.hour = 8;
      schedule.minute = 0;
      schedule.startDay = 1;
    }
  }

  void saveSchedule() {
    Storage.write<ScheduleEntry>(EEPROM_ADDR_PUMP_SCHEDULE, schedule);
  }

private:
  uint16_t runtime = PUMP_MIN_RUNTIME_SECONDS;
  uint8_t minRuntime = PUMP_MIN_RUNTIME_SECONDS;
  uint16_t maxRuntime = PUMP_MAX_RUNTIME_SECONDS;
  ScheduleEntry schedule;
};

extern PumpStorage pump;