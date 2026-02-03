#pragma once
#include <Arduino.h>

struct ScheduleEntry {
  uint8_t hour;      
  uint8_t minute;    
  uint8_t interval; 
};

void pumpStorageInit();

uint16_t pumpStorageLoadExecutionTime();
void pumpStorageSaveExecutionTime(uint16_t seconds);

void pumpStorageSaveSchedule(const ScheduleEntry &entry);
ScheduleEntry pumpStorageLoadSchedule();
