#pragma once
#include <ESP8266WebServer.h>
#include <ArduinoJson.h>
#include <ESP8266WiFi.h>
#include "core/cors.h"
#include "core/json_utils.h"

inline void registerStatusRoutes(ESP8266WebServer& server) {
  server.on("/status", HTTP_GET, [&]() {
    sendCorsHeaders(server);

    StaticJsonDocument<200> doc;
    doc["status"] = "ok";
    doc["ip"] = WiFi.localIP().toString();

    sendJson(server, 200, doc);
  });
}
