#pragma once

#define PUMP_PIN D2
#define SERIAL_BAUD 9600

#define WIFI_RETRY_DELAY 500
#define WIFI_MAX_RETRIES 2

#define PUMP_MIN_RUNTIME_SECONDS 2
#define PUMP_MAX_RUNTIME_SECONDS 600

#define PUMP_MIN_INTERVAL 1
#define PUMP_MAX_INTERVAL 7

#define EEPROM_ADDR_PUMP_SECONDS 0
#define EEPROM_ADDR_PUMP_SCHEDULE (EEPROM_ADDR_PUMP_SECONDS + sizeof(uint16_t))
#define EEPROM_ADDR_DEVICE_TIME (EEPROM_ADDR_PUMP_SCHEDULE + sizeof(ScheduleEntry))
#define EEPROM_SIZE (EEPROM_ADDR_DEVICE_TIME + sizeof(DeviceTime))

#define LOG_INFO(tag, msg) Serial.println(String("[") + tag + "] " + msg)
