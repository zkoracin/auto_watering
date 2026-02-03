#include "pump_storage.h"
#include <EEPROM.h>
#include "config.h"
#include <config/config.h>

#define EEPROM_SIZE 8
#define EEPROM_ADDR_PUMP_SECONDS 0

void pumpStorageInit()
{
    EEPROM.begin(EEPROM_SIZE);
}

uint16_t pumpStorageLoadExecutionTime()
{
    uint16_t value;
    EEPROM.get(EEPROM_ADDR_PUMP_SECONDS, value);

    // If EEPROM uninitialized, use default
    if (value == 0xFFFF || value == 0)
    {
        value = PUMP_DEFAULT_EXECUTION_TIME_SECONDS;
    }

    return constrain(value,
                     PUMP_MIN_EXECUTION_TIME_SECONDS,
                     PUMP_MAX_EXECUTION_TIME_SECONDS);
}

void pumpStorageSaveExecutionTime(uint16_t seconds)
{
    seconds = constrain(seconds,
                        PUMP_MIN_EXECUTION_TIME_SECONDS,
                        PUMP_MAX_EXECUTION_TIME_SECONDS);

    EEPROM.put(EEPROM_ADDR_PUMP_SECONDS, seconds);
    EEPROM.commit();
}
