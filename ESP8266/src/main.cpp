#include "config/config.h"
#include "core/cors.h"
#include "core/wifi_manager.h"
#include "routes/server_routes.h"
#include <ESP8266WebServer.h>
#include <ESP8266WiFi.h>
#include "storage/storage_manager.h"
#include "storage/device_storage.h"
#include "storage/pump_storage.h"
#include "device/device_clock.h"
#include "pump/pump_scheduler.h"

StorageManager Storage;
DeviceStorage device;
DeviceClock deviceClock;
PumpStorage pump;
PumpScheduler pumpScheduler;

ESP8266WebServer server(80);

void setup() {
  Serial.begin(SERIAL_BAUD);
  delay(5000);

  LOG_INFO("STORAGE", "INITIALIZING STORAGE");
  Storage.begin();

  LOG_INFO("STORAGE", "LOADING DEVICE TIME");
  device.loadDeviceTime();

  DeviceTime dt = device.getDeviceTime();
  LOG_INFO("STORAGE", String("DEVICE TIME: ") + "day=" + dt.day + ", hour=" + dt.hour +
                          ", minute=" + dt.minute);

  LOG_INFO("CLOCK", "STARTING DEVICE CLOCK");
  deviceClock.begin();

  LOG_INFO("STORAGE", "LOADING PUMP RUNTIME");
  pump.loadRuntime();
  LOG_INFO("STORAGE", "PUMP RUNTIME: " + pump.getRuntime());

  pumpInit();
  LOG_INFO("PUMP", "PUMP INITIALIZED");

  pumpScheduler.begin();
  pump.loadSchedule();
  LOG_INFO("SCHEDULER", "SCHEDULER INITIALIZED");

  connectWiFi();

  registerRoutes(server);

  server.begin();
  LOG_INFO("SERVER", "HTTP SERVER STARTED");
}

void loop() {
  server.handleClient();
  deviceClock.updateTime();
  pumpScheduler.update();
  pumpUpdate();
}
