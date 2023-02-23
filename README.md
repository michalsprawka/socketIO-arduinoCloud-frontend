# arduino_iot_dash

This is a flutter project which is a part of set of appliacations for sending messages to and from arduino IOT Cloud.
This project is frontend part of the system.
Currently application receive pressure data from sensor and sending command to switch on LED on desk.

The chain of application is
1. Flutter (this project)
2. WebSocket (SocketIO) Server on Ubuntu Server behind NGINX
3. NodeRed Client on local RaspberryPI with SocketIO libs and Arduino Cloud libs
4. Arduino IOT Cloud endpoints on MKR 1010 or Arduino MKR 1000
## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
