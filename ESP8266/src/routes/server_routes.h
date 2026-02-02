#pragma once
#include <ESP8266WebServer.h>
#include "routes/status_routes.h"

inline void registerRoutes(ESP8266WebServer& server) {
  registerStatusRoutes(server);

  server.onNotFound([&]() {
    if (server.method() == HTTP_OPTIONS) {
      sendCorsHeaders(server);
      server.send(204);
    } else {
      sendCorsHeaders(server);
      StaticJsonDocument<100> doc;
      doc["error"] = "Not found";
      sendJson(server, 404, doc);
    }
  });
}
