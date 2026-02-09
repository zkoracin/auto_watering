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

void pumpStorageInit();

uint16_t pumpStorageLoadExecutionTime();
void pumpStorageSaveExecutionTime(uint16_t seconds);

ScheduleEntry pumpStorageLoadSchedule();
void pumpStorageSaveSchedule(const ScheduleEntry& entry);

DeviceTime deviceTimeLoad();
void deviceTimeSave(const DeviceTime& time);