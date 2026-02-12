#pragma once
#include <ESP8266WiFi.h>
#include "config/config.h"
#include "include/wifi_credentials.h"

inline void connectWiFi() {
  WiFi.begin(ssid, password);
  int retries = 0;

  while (WiFi.status() != WL_CONNECTED && retries < WIFI_MAX_RETRIES) {
    delay(WIFI_RETRY_DELAY);
    retries++;
  }
}
