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

  Serial.println();
  Serial.println("Connecting to WiFi...");
  connectWiFi();

  registerRoutes(server);

  server.begin();
  Serial.println("HTTP server started");
}

void loop() {
  server.handleClient();
  pumpUpdate();
}
