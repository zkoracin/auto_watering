#pragma once
#include <Arduino.h>

void pumpStorageInit();
uint16_t pumpStorageLoadExecutionTime();
void pumpStorageSaveExecutionTime(uint16_t seconds);
