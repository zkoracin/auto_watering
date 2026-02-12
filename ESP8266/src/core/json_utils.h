#pragma once
#include <ArduinoJson.h>
#include <ESP8266WebServer.h>

inline void sendJson(ESP8266WebServer& server, int statusCode, const JsonDocument& doc) {
  sendCorsHeaders(server);
  // Stream JSON directly to the client
  server.setContentLength(measureJson(doc));
  server.send(statusCode, F("application/json"), "");
  serializeJson(doc, server.client());
}

inline void sendError(ESP8266WebServer& server, int code, const __FlashStringHelper* message) {
  JsonDocument doc;
  doc[F("error")] = message;
  sendJson(server, code, doc);
}

inline bool validateJsonBody(ESP8266WebServer& server, JsonDocument& outDoc,
                             std::initializer_list<const char*> requiredKeys = {}) {
  if (!server.hasArg(F("plain"))) {
    sendError(server, 400, F("Missing body"));
    return false;
  }

  DeserializationError error = deserializeJson(outDoc, server.arg(F("plain")));
  if (error) {
    sendError(server, 400, F("Invalid JSON"));
    return false;
  }

  for (const char* key : requiredKeys) {
    if (outDoc[key].isNull()) {
      sendError(server, 400, F("Missing required field"));
      return false;
    }
  }

  return true;
}