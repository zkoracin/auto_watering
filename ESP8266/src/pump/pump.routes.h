#pragma once
#include <ESP8266WebServer.h>
#include <ArduinoJson.h>
#include "pump.h"
#include "core/cors.h"
#include "core/json_utils.h"

inline void registerPumpRoutes(ESP8266WebServer& server) {
  server.on("/pump", HTTP_GET, [&]() {
    sendCorsHeaders(server);
    StaticJsonDocument<100> doc;
    doc["pumpOn"] = pumpState();
    sendJson(server, 200, doc);
  });

  server.on("/pump", HTTP_PUT, [&]() {
    sendCorsHeaders(server);

    if (!server.hasArg("plain")) {
      StaticJsonDocument<100> doc;
      doc["error"] = "Missing body";
      sendJson(server, 400, doc);
      return;
    }

    StaticJsonDocument<100> body;
    if (deserializeJson(body, server.arg("plain")) || !body.containsKey("on")) {
      StaticJsonDocument<100> doc;
      doc["error"] = "Invalid JSON";
      sendJson(server, 400, doc);
      return;
    }

    pumpSet(body["on"]);

    StaticJsonDocument<100> doc;
    doc["pumpOn"] = pumpState();
    sendJson(server, 200, doc);
  });

  server.on("/pump/toggle", HTTP_POST, [&]() {
    sendCorsHeaders(server);
    pumpToggle();

    StaticJsonDocument<100> doc;
    doc["pumpOn"] = pumpState();
    sendJson(server, 200, doc);
  });
}
