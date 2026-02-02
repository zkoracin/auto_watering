#pragma once
#include <ESP8266WebServer.h>
#include <ArduinoJson.h>

inline void sendJson(
  ESP8266WebServer& server,
  int statusCode,
  JsonDocument& doc
) {
  String response;
  serializeJson(doc, response);
  server.send(statusCode, "application/json", response);
}
