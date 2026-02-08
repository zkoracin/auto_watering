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

inline bool validateJsonBody(ESP8266WebServer& server, const char* requiredKey,
                             JsonDocument& outDoc) {

  if (!server.hasArg(F("plain"))) {
    JsonDocument errorDoc;
    errorDoc[F("error")] = F("Missing body");
    sendJson(server, 400, errorDoc);
    return false;
  }

  DeserializationError error = deserializeJson(outDoc, server.arg(F("plain")));

  if (error || outDoc[requiredKey].isNull()) {
    JsonDocument errorDoc;
    errorDoc[F("error")] = error ? F("Invalid JSON") : F("Missing required key");
    sendJson(server, 400, errorDoc);
    return false;
  }

  return true;
}