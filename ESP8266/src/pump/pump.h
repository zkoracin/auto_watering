#pragma once
#include <Arduino.h>
#include "config/config.h"

static bool pumpOn = false;
static unsigned long pumpEndTime = 0;

inline void pumpInit() {
  pinMode(PUMP_PIN, OUTPUT);
  digitalWrite(PUMP_PIN, LOW);
  pumpOn = false;
  pumpEndTime = 0;
}

inline void pumpSet(bool on) {
  LOG_INFO("PUMP", "PUMP SET START: " + on);
  pumpOn = on;
  digitalWrite(PUMP_PIN, on ? HIGH : LOW);
  if (!on) {
    pumpEndTime = 0;
  }
}

inline void pumpToggle() {
  pumpSet(!pumpOn);
}

inline bool pumpState() {
  return pumpOn;
}

inline void pumpRunForSeconds(uint16_t seconds) {
  pumpSet(true);
  pumpEndTime = millis() + (unsigned long)seconds * 1000UL;
}

inline void pumpUpdate() {
  if (pumpOn && pumpEndTime > 0) {
    if ((long)(millis() - pumpEndTime) >= 0) {
      pumpSet(false);
      pumpEndTime = 0;
    }
  }
}
