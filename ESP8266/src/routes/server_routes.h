#pragma once
#include <ESP8266WebServer.h>
#include "routes/device_routes.h"
#include "routes/pump_routes.h"

inline void sendNotFound(ESP8266WebServer& server) {
  JsonDocument doc;
  doc["error"] = F("Not found");
  sendJson(server, 404, doc);
}

inline void registerRoutes(ESP8266WebServer& server) {
  registerDeviceRoutes(server);
  registerPumpRoutes(server);

  server.onNotFound([&server]() {
    sendCorsHeaders(server);

    if (server.method() == HTTP_OPTIONS) {
      server.send(204);
      return;
    }

    sendNotFound(server);
  });
}