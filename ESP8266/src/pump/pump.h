#pragma once
#include <Arduino.h>
#include "config.h"

static bool pumpOn = false;

inline void pumpInit() {
  pinMode(PUMP_PIN, OUTPUT);
  digitalWrite(PUMP_PIN, LOW);
  pumpOn = false;
}

inline void pumpSet(bool on) {
  pumpOn = on;
  digitalWrite(PUMP_PIN, on ? HIGH : LOW);
}

inline void pumpToggle() {
  pumpSet(!pumpOn);
}

inline bool pumpState() {
  return pumpOn;
}
