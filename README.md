# 🤖 MindSpace - Solução IoT

Este diretório contém os arquivos e documentação da solução de **Internet das Coisas (IoT)** do projeto MindSpace. O objetivo é simular a coleta de dados biométricos (nível de estresse) de um colaborador e integrar esses dados à plataforma corporativa na nuvem.

---

## 📋 Descrição da Solução

A solução utiliza um microcontrolador **ESP32** simulado para capturar níveis de estresse (representados por um potenciômetro) e enviá-los via protocolo **MQTT** para um Gateway inteligente (**Node-RED**). O Gateway processa os dados, aplica regras de negócio (alertas críticos) e encaminha as informações para a API Java principal hospedada na Azure.

### 🏗️ Arquitetura
1.  **Dispositivo (Edge):** ESP32 (Simulado no Wokwi)
2.  **Protocolo de Transporte:** MQTT (Broker Público: HiveMQ)
3.  **Gateway & Lógica:** Node-RED
4.  **Integração:** HTTP POST (Para API Java/Spring Boot)

---

## 🛠️ Componentes e Hardware

* **Plataforma:** Wokwi (Simulador Online)
* **Microcontrolador:** ESP32
* **Sensores:**
    * 1x Potenciômetro (Simulando sensor de resposta galvânica da pele/estresse)
    * Conexão: Pino de Sinal no GPIO 34 (Analog Input)

---

## 🚀 Como Rodar o Projeto

### 1. Configuração do Hardware (Wokwi)
1.  Acesse o arquivo `sketch.ino` neste repositório.
2.  Copie o código para um novo projeto ESP32 no [Wokwi.com](https://wokwi.com).
3.  Adicione a biblioteca **`PubSubClient`** no Library Manager do Wokwi.
4.  **Configuração de Rede:** O código já está configurado para usar a rede `Wokwi-GUEST` e o broker `broker.hivemq.com`.

### 2. Configuração do Gateway (Node-RED)
1.  Certifique-se de ter o **Node.js** e o **Node-RED** instalados localmente.
2.  Inicie o Node-RED (`node-red` no terminal) e acesse `http://localhost:1880`.
3.  Vá em **Menu > Importar** e selecione o arquivo `flows.json` deste repositório.
4.  **Ajuste de Integração:**
    * Abra o nó **`requisição http`**.
    * Atualize a URL com o IP Público atual da VM Linux na Azure:
    * `http://<SEU_IP_PUBLICO>:8080/registros`
5.  Clique em **Deploy**.

---

## 🧪 Roteiro de Testes

1.  **Inicie a Simulação:** Clique no "Play" no Wokwi. Aguarde a mensagem "MQTT conectado" no Serial Monitor.
2.  **Cenário 1 (Registro Normal):**
    * Gire o potenciômetro para um nível baixo (< 80).
    * **Resultado:** O Node-RED recebe o dado via MQTT e envia um `POST` para a API. O dado é salvo no Banco de Dados Oracle.
3.  **Cenário 2 (Alerta Crítico):**
    * Gire o potenciômetro para um nível alto (> 80).
    * **Resultado:** O Node-RED detecta o risco e aciona o fluxo de Alerta (Debug), simulando uma notificação imediata ao gestor/RH.

---

## 👨‍💻 Desenvolvedores

* **Luann Noqueli** (RM560313) - Desenvolvimento IoT & Integração
* **Henrique Marques** (RM560698) 
* **Lucas Higuti** (RM561120) 

## 🎥 Vídeo Demonstrativo

Confira o funcionamento completo da solução IoT no link abaixo:
* **[INSIRA O LINK DO YOUTUBE AQUI]**
