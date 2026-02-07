#pragma once
#include <ESP8266WebServer.h>
#include <ArduinoJson.h>
#include <ESP8266WiFi.h>
#include "core/cors.h"
#include "core/json_utils.h"
#include "pump/pump_storage.h"

inline void registerStatusRoutes(ESP8266WebServer& server) {
  server.on("/status", HTTP_GET, [&]() {
    StaticJsonDocument<100> doc;
    doc["status"] = "ok";
    doc["ip"] = WiFi.localIP().toString();

    sendJson(server, 200, doc);
  });

  server.on("/setTime", HTTP_POST, [&]() {
    StaticJsonDocument<100> body;
    if (!validateJsonBody(server, "day", body)) return;
    if (!validateJsonBody(server, "hour", body)) return;
    if (!validateJsonBody(server, "minute", body)) return;

    DeviceTime newTime;
    newTime.day = body["day"];
    newTime.hour = body["hour"];
    newTime.minute = body["minute"];

    deviceTimeSave(newTime);

    StaticJsonDocument<100> doc;
    doc["day"] = newTime.day;
    doc["hour"] = newTime.hour;
    doc["minute"] = newTime.minute;
    sendJson(server, 200, doc);
  });
}
