#pragma once
#include <ESP8266WebServer.h>
#include <ArduinoJson.h>
#include "pump.h"
#include "pump_storage.h"
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
  server.on("/pump", HTTP_GET, [&server]() { sendPumpState(server); });

  server.on("/pump", HTTP_PUT, [&server]() {
    JsonDocument body;
    if (validateJsonBody(server, "on", body)) {
      pumpSet(body["on"]);
      sendPumpState(server);
    }
  });

  server.on("/pump/toggle", HTTP_POST, [&server]() {
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

  server.on("/pump/runtime", HTTP_GET, sendRuntime);

  server.on("/pump/runtime", HTTP_PUT, [&server, sendRuntime]() {
    JsonDocument body;

    if (validateJsonBody(server, "seconds", body)) {
      uint16_t seconds = body["seconds"];
      seconds =
          constrain(seconds, PUMP_MIN_EXECUTION_TIME_SECONDS, PUMP_MAX_EXECUTION_TIME_SECONDS);
      pumpStorageSaveExecutionTime(seconds);
      sendRuntime();
    }
  });

  server.on("/pump/runtime-test", HTTP_POST, [&server]() {
    uint16_t seconds = pumpStorageLoadExecutionTime();
    pumpRunForSeconds(seconds);

    JsonDocument doc;
    doc["pumpOn"] = pumpState();
    doc["seconds"] = seconds;
    sendJson(server, 200, doc);
  });

  server.on("/pump/schedule", HTTP_GET, [&server]() {
    sendPumpSchedule(server, pumpStorageLoadSchedule());
  });

  server.on("/pump/schedule", HTTP_PUT, [&server]() {
    JsonDocument body;
    if (!validateJsonBody(server, "hour", body)) return;

    if (body["hour"].isNull() || body["minute"].isNull() || body["interval"].isNull() ||
        body["startDay"].isNull()) {
      JsonDocument err;
      err["error"] = F("Invalid schedule");
      sendJson(server, 400, err);
      return;
    }

    ScheduleEntry schedule = {.hour = body["hour"],
                              .minute = body["minute"],
                              .interval = body["interval"],
                              .startDay = body["startDay"]};

    pumpStorageSaveSchedule(schedule);
    sendPumpSchedule(server, schedule);
  });
}
