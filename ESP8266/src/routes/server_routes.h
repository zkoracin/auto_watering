#pragma once
#include <ESP8266WebServer.h>
#include "routes/status_routes.h"
#include "pump/pump.routes.h"

inline void sendNotFound(ESP8266WebServer& server) {
  JsonDocument doc;
  doc["error"] = F("Not found");
  sendJson(server, 404, doc);
}

inline void registerRoutes(ESP8266WebServer& server) {
  registerStatusRoutes(server);
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