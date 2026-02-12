#pragma once
#include <ESP8266WebServer.h>
#include <ArduinoJson.h>
#include "pump/pump.h"
#include "pump/pump_storage.h"
#include "core/cors.h"
#include "core/json_utils.h"

inline void sendPumpState(ESP8266WebServer& server) {
  JsonDocument doc;
  doc["pumpOn"] = pumpState();
  sendJson(server, 200, doc);
}

void sendPumpSchedule(ESP8266WebServer& server, const ScheduleEntry& schedule) {
  JsonDocument doc;
  doc["hour"] = schedule.hour;
  doc["minute"] = schedule.minute;
  doc["interval"] = schedule.interval;
  doc["startDay"] = schedule.startDay;
  sendJson(server, 200, doc);
}

inline void registerPumpRoutes(ESP8266WebServer& server) {
  server.on("/pump", HTTP_GET, [&server]() {
    LOG_INFO("SERVER", "GET PUMP");
    sendPumpState(server);
  });

  server.on("/pump", HTTP_PUT, [&server]() {
    LOG_INFO("SERVER", "PUT PUMP");
    JsonDocument doc;
    if (!validateJsonBody(server, doc, {"on"})) {
      LOG_INFO("SERVER", "PUT PUMP not valid request");
      return;
    };
    pumpSet(doc["on"]);
    sendPumpState(server);
  });

  server.on("/pump/toggle", HTTP_POST, [&server]() {
    LOG_INFO("SERVER", "POST PUMP");
    pumpToggle();
    sendPumpState(server);
  });

  auto sendRuntime = [&server]() {
    JsonDocument doc;
    doc["seconds"] = pumpStorageLoadExecutionTime();
    doc["min"] = PUMP_MIN_EXECUTION_TIME_SECONDS;
    doc["max"] = PUMP_MAX_EXECUTION_TIME_SECONDS;
    sendJson(server, 200, doc);
  };

  server.on("/pump/runtime", HTTP_GET, [&server, sendRuntime]() {
    LOG_INFO("SERVER", "GET PUMP/RUNTIME");
    sendRuntime();
  });

  server.on("/pump/runtime", HTTP_PUT, [&server, sendRuntime]() {
    LOG_INFO("SERVER", "PUT PUMP/RUNTIME");
    JsonDocument doc;
    if (!validateJsonBody(server, doc, {"seconds"})) {
      LOG_INFO("SERVER", "PUT PUMP/RUNTIME not valid request");
      return;
    };
    uint16_t seconds = doc["seconds"];
    seconds = constrain(seconds, PUMP_MIN_EXECUTION_TIME_SECONDS, PUMP_MAX_EXECUTION_TIME_SECONDS);
    pumpStorageSaveExecutionTime(seconds);
    sendRuntime();
  });

  server.on("/pump/runtime-test", HTTP_POST, [&server]() {
    LOG_INFO("SERVER", "POST PUMP/RUNTIME-TEST");
    uint16_t seconds = pumpStorageLoadExecutionTime();
    pumpRunForSeconds(seconds);

    JsonDocument doc;
    doc["pumpOn"] = pumpState();
    doc["seconds"] = seconds;
    sendJson(server, 200, doc);
  });

  server.on("/pump/schedule", HTTP_GET, [&server]() {
    LOG_INFO("SERVER", "GET PUMP/SCHEDLE");
    sendPumpSchedule(server, pumpStorageLoadSchedule());
  });

  server.on("/pump/schedule", HTTP_PUT, [&server]() {
    LOG_INFO("SERVER", "PUT PUMP/SCHEDULE");
    JsonDocument doc;
    if (!validateJsonBody(server, doc, {"startDay", "hour", "minute", "interval"})) {
      LOG_INFO("SERVER", "PUT PUMP/SCHEDULE not valid request");
      return;
    }
    ScheduleEntry schedule{.hour = doc["hour"],
                           .minute = doc["minute"],
                           .interval = doc["interval"],
                           .startDay = doc["startDay"]};

    pumpStorageSaveSchedule(schedule);
    sendPumpSchedule(server, schedule);
  });
}
