#pragma once
#include <ArduinoJson.h>
#include <ESP8266WebServer.h>

inline void sendJson(ESP8266WebServer& server, int statusCode, JsonDocument& doc) {
  sendCorsHeaders(server);
  String response;
  serializeJson(doc, response);
  server.send(statusCode, "application/json", response);
}

inline bool validateJsonBody(ESP8266WebServer& server, const char* requiredKey,
                             StaticJsonDocument<100>& outDoc) {

  if (!server.hasArg("plain")) {
    StaticJsonDocument<100> errorDoc;
    errorDoc["error"] = "Missing body";
    sendJson(server, 400, errorDoc);
    return false;
  }

  if (deserializeJson(outDoc, server.arg("plain")) || !outDoc.containsKey(requiredKey)) {
    StaticJsonDocument<100> errorDoc;
    errorDoc["error"] = "Invalid JSON";
    sendJson(server, 400, errorDoc);
    return false;
  }

  return true;
}