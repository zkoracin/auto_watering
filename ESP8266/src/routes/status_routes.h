#pragma once
#include <ESP8266WebServer.h>
#include <ArduinoJson.h>
#include <ESP8266WiFi.h>
#include "core/cors.h"
#include "core/json_utils.h"
#include "pump/pump_storage.h"

inline void registerStatusRoutes(ESP8266WebServer& server) {
  server.on("/status", HTTP_GET, [&server]() {
    JsonDocument doc;
    doc["status"] = F("ok");
    doc["ip"] = WiFi.localIP().toString();

    sendJson(server, 200, doc);
  });

  server.on("/setTime", HTTP_POST, [&server]() {
    JsonDocument body;
    if (!validateJsonBody(server, "day", body)) return;

    if (body["day"].isNull() || body["hour"].isNull() || body["minute"].isNull()) {
      JsonDocument err;
      err["error"] = F("Invalid time values");
      sendJson(server, 400, err);
      return;
    }

    DeviceTime newTime{.day = body["day"], .hour = body["hour"], .minute = body["minute"]};

    deviceTimeSave(newTime);

    JsonDocument doc;
    doc["day"] = newTime.day;
    doc["hour"] = newTime.hour;
    doc["minute"] = newTime.minute;
    sendJson(server, 200, doc);
  });
}
