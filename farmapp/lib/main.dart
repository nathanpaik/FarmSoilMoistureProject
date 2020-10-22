import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:farmapp/Treatment/StateContainer.dart';

import 'MyApp.dart';

const SERVER_DOMAIN = "https://www.farmsoilmoisture.tk/mobile";
final storage = FlutterSecureStorage();

void main() => runApp(new MyApp());
