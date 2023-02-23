# arduino_iot_dash

This is a flutter project which is a part of set of appliacations for sending messages to and from arduino IOT Cloud.
This project is frontend part of the system.
Currently application receive pressure data from sensor and sending command to switch on LED on desk.

The chain of application is

Flutter             WebSocket (SocketIO) Server           NodeRed Client              Arduino IOT Cloud endpoints on MKR 1010
(this project)      on Ubuntu Server behind NGINX         on local RaspberryPI        or Arduino MKR 1000
                                                          with SocketIO libs and
                                                          Arduino Cloud libs

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
