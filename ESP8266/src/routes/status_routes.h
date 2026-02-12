#pragma once
#include <ESP8266WebServer.h>
#include <ArduinoJson.h>
#include <ESP8266WiFi.h>
#include "core/cors.h"
#include "core/json_utils.h"
#include "storage/device_storage.h"

inline void registerStatusRoutes(ESP8266WebServer& server) {
  server.on("/status", HTTP_GET, [&server]() {
    LOG_INFO("SERVER", "GET STATUS");
    JsonDocument doc;
    doc["status"] = F("ok");
    doc["ip"] = WiFi.localIP().toString();

    sendJson(server, 200, doc);
  });

  server.on("/setTime", HTTP_POST, [&server]() {
    LOG_INFO("SERVER", "POST SET TIME");
    JsonDocument doc;
    if (!validateJsonBody(server, doc, {"day", "hour", "minute"})) {
      LOG_INFO("SERVER", "POST SET TIME not valid");
      return;
    };

    DeviceTime newTime{.day = doc["day"], .hour = doc["hour"], .minute = doc["minute"]};

    device.setDeviceTime(newTime);
    device.saveDeviceTime();

    doc["day"] = newTime.day;
    doc["hour"] = newTime.hour;
    doc["minute"] = newTime.minute;
    sendJson(server, 200, doc);
  });
}
