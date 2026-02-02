#include <ESP8266WiFi.h>
#include <ESP8266WebServer.h>
#include "config/config.h"
#include "core/wifi_manager.h"
#include "core/cors.h"

ESP8266WebServer server(80);

void handleRoot() {
  sendCorsHeaders(server);
  server.send(200, "text/plain", "Hello from ESP8266!");
}

void handleStatus() {
  sendCorsHeaders(server);
  String msg = "ESP8266 is running\n";
  msg += "IP: " + WiFi.localIP().toString();
  server.send(200, "text/plain", msg);
}
void handleOptions() {
  sendCorsHeaders(server);
  server.send(204);
}

void setup() {
  Serial.begin(SERIAL_BAUD);
  delay(1000);

  Serial.println();
  Serial.println("Connecting to WiFi...");
  connectWiFi();

  server.on("/", HTTP_GET, handleRoot);
  server.on("/", HTTP_OPTIONS, handleOptions);
  server.on("/status", HTTP_GET, handleStatus);
  server.on("/status", HTTP_OPTIONS, handleOptions);

  server.begin();
  Serial.println("HTTP server started");
}

void loop() {
  server.handleClient();
}
