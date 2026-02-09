#include "pump_storage.h"
#include "config/config.h"
#include <EEPROM.h>

void pumpStorageInit() {
  EEPROM.begin(EEPROM_SIZE);
}

uint16_t pumpStorageLoadExecutionTime() {
  uint16_t value;
  EEPROM.get(EEPROM_ADDR_PUMP_SECONDS, value);

  // If EEPROM uninitialized, use default
  if (value == 0xFFFF || value == 0) {
    value = PUMP_DEFAULT_EXECUTION_TIME_SECONDS;
  }

  return constrain(value, PUMP_MIN_EXECUTION_TIME_SECONDS, PUMP_MAX_EXECUTION_TIME_SECONDS);
}

void pumpStorageSaveExecutionTime(uint16_t seconds) {
  seconds = constrain(seconds, PUMP_MIN_EXECUTION_TIME_SECONDS, PUMP_MAX_EXECUTION_TIME_SECONDS);

  EEPROM.put(EEPROM_ADDR_PUMP_SECONDS, seconds);
  EEPROM.commit();
}

void pumpStorageSaveSchedule(const ScheduleEntry& entry) {
  EEPROM.put(EEPROM_ADDR_PUMP_SCHEDULE, entry);
  EEPROM.commit();
}

ScheduleEntry pumpStorageLoadSchedule() {
  ScheduleEntry entry;
  EEPROM.get(EEPROM_ADDR_PUMP_SCHEDULE, entry);
  return entry;
}

void deviceTimeSave(const DeviceTime& time) {
  EEPROM.put(EEPROM_ADDR_DEVICE_TIME, time);
  EEPROM.commit();
}

DeviceTime deviceTimeLoad() {
  DeviceTime time;
  EEPROM.get(EEPROM_ADDR_DEVICE_TIME, time);

  // If uninitialized, reset to day 0, 00:00
  if (time.day == 0xFFFF) {
    time.day = 0;
    time.hour = 0;
    time.minute = 0;
  }

  return time;
}
