#pragma once
#include <ESP8266WebServer.h>
#include <ArduinoJson.h>
#include "pump.h"
#include "pump_storage.h"
#include "core/cors.h"
#include "core/json_utils.h"

inline void registerPumpRoutes(ESP8266WebServer& server) {
  server.on("/pump", HTTP_GET, [&]() {
    StaticJsonDocument<100> doc;
    doc["pumpOn"] = pumpState();
    sendJson(server, 200, doc);
  });

  server.on("/pump", HTTP_PUT, [&]() {
    StaticJsonDocument<100> body;
    if (!validateJsonBody(server, "on", body)) return;
    
    pumpSet(body["on"]);

    StaticJsonDocument<100> doc;
    doc["pumpOn"] = pumpState();
    sendJson(server, 200, doc);
  });

  server.on("/pump/toggle", HTTP_POST, [&]() {
    pumpToggle();

    StaticJsonDocument<100> doc;
    doc["pumpOn"] = pumpState();
    sendJson(server, 200, doc);
  });

  server.on("/pump/time", HTTP_GET, [&]() {
    StaticJsonDocument<100> doc;
    doc["seconds"] = pumpStorageLoadExecutionTime();                             
    doc["min"] = PUMP_MIN_EXECUTION_TIME_SECONDS;                 
    doc["max"] = PUMP_MAX_EXECUTION_TIME_SECONDS;                 
    sendJson(server, 200, doc);
  });

  server.on("/pump/time", HTTP_PUT, [&]() {
    StaticJsonDocument<100> body;
    if (!validateJsonBody(server, "seconds", body)) return;

    uint16_t seconds = body["seconds"];
    seconds = constrain(seconds,
                        PUMP_MIN_EXECUTION_TIME_SECONDS,
                        PUMP_MAX_EXECUTION_TIME_SECONDS);

    pumpStorageSaveExecutionTime(seconds);

    StaticJsonDocument<100> doc;
    doc["seconds"] = pumpStorageLoadExecutionTime();
    sendJson(server, 200, doc);
  });
}
