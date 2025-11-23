#include <WiFi.h>
#include <PubSubClient.h>

// Configurações de WiFi (Padrão do Wokwi)
const char* ssid = "Wokwi-GUEST";
const char* password = "";

// Configurações do MQTT (Broker Público para teste)
const char* mqtt_server = "broker.hivemq.com"; // Ou test.mosquitto.org
const int mqtt_port = 1883;
const char* mqtt_topic = "fiap/mindspace/estresse"; // Tópico exclusivo

WiFiClient espClient;
PubSubClient client(espClient);

// Pino do Potenciômetro (Simulador de Estresse)
const int potPin = 34;

void setup() {
  Serial.begin(115200);
  setup_wifi();
  client.setServer(mqtt_server, mqtt_port);
}

void setup_wifi() {
  delay(10);
  Serial.println();
  Serial.print("Conectando em ");
  Serial.println(ssid);
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("");
  Serial.println("WiFi conectado");
}

void reconnect() {
  while (!client.connected()) {
    Serial.print("Tentando conexao MQTT...");
    String clientId = "ESP32Client-";
    clientId += String(random(0xffff), HEX);
    if (client.connect(clientId.c_str())) {
      Serial.println("conectado");
    } else {
      Serial.print("falhou, rc=");
      Serial.print(client.state());
      Serial.println(" tentando novamente em 5s");
      delay(5000);
    }
  }
}

void loop() {
  if (!client.connected()) {
    reconnect();
  }
  client.loop();

  // Ler o valor do Potenciômetro (0 a 4095)
  int sensorValue = analogRead(potPin);
  
  // Converter para porcentagem de Estresse (0 a 100%)
  int stressLevel = map(sensorValue, 0, 4095, 0, 100);

  // Criar a mensagem JSON
  String msg = "{\"id_usuario\": 1, \"nivel_estresse\": " + String(stressLevel) + "}";
  
  Serial.print("Enviando: ");
  Serial.println(msg);

  // Publicar no tópico MQTT
  client.publish(mqtt_topic, msg.c_str());

  delay(2000); // Envia a cada 2 segundos
}
