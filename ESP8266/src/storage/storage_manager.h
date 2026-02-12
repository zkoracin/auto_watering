#pragma once
#include <Arduino.h>
#include <EEPROM.h>
#include <config/config.h>
#include "models/storage_models.h"

class StorageManager {
public:
  void begin() {
    EEPROM.begin(EEPROM_SIZE);
  }

  bool commit() {
    bool success = EEPROM.commit();
    LOG_INFO("EEPROM", success ? "Commit SAVED" : "Commit FAILED");
    return success;
  }

  template <typename T> T read(int address, const T& defaultValue = T()) {
    T data;
    EEPROM.get(address, data);
    if (isUninitialized(data)) return defaultValue;
    return data;
  }

  template <typename T> void write(int address, const T& data, bool autoCommit = true) {
    EEPROM.put(address, data);
    if (autoCommit) commit();
  }

private:
  // Detect uninitialized EEPROM for common types
  template <typename T> bool isUninitialized(const T& value) {
    return false; // default: assume initialized
  }

  // Specialization for uint16_t
  bool isUninitialized(const uint16_t& value) {
    return value == 0xFFFF || value == 0;
  }

  // Specialization for structs can be added if needed
  bool isUninitialized(const ScheduleEntry& value) {
    return false;
  }
  bool isUninitialized(const DeviceTime& value) {
    return value.day == 0xFFFF;
  }
};

extern StorageManager Storage;
