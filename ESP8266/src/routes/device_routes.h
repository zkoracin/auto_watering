#pragma once
#include <ESP8266WebServer.h>
#include <ArduinoJson.h>
#include <ESP8266WiFi.h>
#include "core/cors.h"
#include "core/json_utils.h"
#include "storage/device_storage.h"

void sendDeviceTime(ESP8266WebServer& server, const DeviceTime& dt) {
  JsonDocument doc;
  doc["day"] = dt.day;
  doc["hour"] = dt.hour;
  doc["minute"] = dt.minute;
  sendJson(server, 200, doc);
}

inline void registerDeviceRoutes(ESP8266WebServer& server) {
  server.on("/device/status", HTTP_GET, [&server]() {
    LOG_INFO("SERVER", "GET DEVICE/STATUS");
    JsonDocument doc;
    doc["status"] = F("ok");
    doc["ip"] = WiFi.localIP().toString();

    sendJson(server, 200, doc);
  });

  server.on("/device/time", HTTP_GET, [&server]() {
    LOG_INFO("SERVER", "GET DEVICE/TIME");
    sendDeviceTime(server, device.getDeviceTime());
  });

  server.on("/device/time", HTTP_POST, [&server]() {
    LOG_INFO("SERVER", "POST DEVICE/SET TIME");
    JsonDocument doc;
    if (!validateJsonBody(server, doc, {"day", "hour", "minute"})) {
      LOG_INFO("SERVER", "POST DEVICE/SET TIME not valid");
      return;
    };

    DeviceTime newTime{.day = doc["day"], .hour = doc["hour"], .minute = doc["minute"]};

    device.setDeviceTime(newTime);
    device.saveDeviceTime();

    sendDeviceTime(server, device.getDeviceTime());
  });
}
