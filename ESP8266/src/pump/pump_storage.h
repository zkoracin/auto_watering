#pragma once
#include <Arduino.h>
#include <models/storage_models.h>

void pumpStorageInit();

uint16_t pumpStorageLoadExecutionTime();
void pumpStorageSaveExecutionTime(uint16_t seconds);

ScheduleEntry pumpStorageLoadSchedule();
void pumpStorageSaveSchedule(const ScheduleEntry& entry);

DeviceTime deviceTimeLoad();
void deviceTimeSave(const DeviceTime& time);