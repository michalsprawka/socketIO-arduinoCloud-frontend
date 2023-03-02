# arduino_iot_dash

## description

This is a flutter project which is a part of set of appliacations for sending messages to and from arduino IOT Cloud.
This project is frontend part of the system.
Currently application receive pressure data from sensor and sending command to switch on LED on desk.

The chain of application is
1. Flutter SocketIOClient (this project)
2. WebSocket (SocketIO) Server on Ubuntu Server behind NGINX (socketIO-arduinoCloud-backend)
3. NodeRed Client on local RaspberryPI with SocketIO libs and Arduino Cloud libs
4. Arduino IOT Cloud endpoints on MKR 1010 or Arduino MKR 1000

## how tu run
1. clone repository
2. run flutter pub get 
3. create .env file with adress of server ADR=https://something
4. run flutter pub run build_runner build command (info: https://pub.dev/packages/envied)
