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

  server.on("/pump/run", HTTP_POST, [&]() {
    StaticJsonDocument<100> doc;

    uint16_t seconds = pumpStorageLoadExecutionTime();
    pumpRunForSeconds(seconds);

    doc["pumpOn"] = pumpState();
    doc["seconds"] = seconds;

    sendJson(server, 200, doc);
  });

  server.on("/pump/schedule", HTTP_GET, [&]() {
    ScheduleEntry schedule = pumpStorageLoadSchedule();

    StaticJsonDocument<100> doc;
    doc["hour"] = schedule.hour;
    doc["minute"] = schedule.minute;
    doc["interval"] = schedule.interval;
    sendJson(server, 200, doc);
  });

  server.on("/pump/schedule", HTTP_PUT, [&]() {
    StaticJsonDocument<100> body;
    if (!validateJsonBody(server, "hour", body)) return;
    if (!validateJsonBody(server, "minute", body)) return;
    if (!validateJsonBody(server, "interval", body)) return;

    ScheduleEntry schedule;
    schedule.hour = body["hour"];
    schedule.minute = body["minute"];
    schedule.interval = body["interval"];

    pumpStorageSaveSchedule(schedule);

    StaticJsonDocument<100> doc;
    doc["hour"] = schedule.hour;
    doc["minute"] = schedule.minute;
    doc["interval"] = schedule.interval;
    sendJson(server, 200, doc);
  });

}
