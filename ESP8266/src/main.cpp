#include <ESP8266WiFi.h>
#include <ESP8266WebServer.h>
#include "wifi_credentials.h"

ESP8266WebServer server(80);

void handleRoot() {
  server.send(200, "text/plain", "Hello from ESP8266!");
}

void handleStatus() {
  String msg = "ESP8266 is running\n";
  msg += "IP: " + WiFi.localIP().toString();
  server.send(200, "text/plain", msg);
}

void setup() {
  Serial.begin(9600);
  delay(1000);

  Serial.println();
  Serial.println("Connecting to WiFi...");
  WiFi.begin(ssid, password);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }

  Serial.println("\nWiFi connected");
  Serial.print("IP address: ");
  Serial.println(WiFi.localIP());

  server.on("/", handleRoot);
  server.on("/status", handleStatus);

  server.begin();
  Serial.println("HTTP server started");
}

void loop() {
  server.handleClient();
}
