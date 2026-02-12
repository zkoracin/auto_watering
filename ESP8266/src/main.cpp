#include "config/config.h"
#include "core/cors.h"
#include "core/wifi_manager.h"
#include "pump/pump_storage.h"
#include "routes/server_routes.h"
#include <ESP8266WebServer.h>
#include <ESP8266WiFi.h>

ESP8266WebServer server(80);

void setup() {
  Serial.begin(SERIAL_BAUD);
  delay(1000);

  pumpInit();
  pumpStorageInit();
  connectWiFi();

  registerRoutes(server);

  server.begin();
  LOG_INFO("SERVER", "HTTP SERVER STARTED");
}

void loop() {
  server.handleClient();
  pumpUpdate();
}
