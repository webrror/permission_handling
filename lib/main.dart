import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Permission Handling'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String status = "";

  Future<String> requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (status.isGranted) {
      return "Permission already granted.";
    } else if (status.isDenied) {
      if (await Permission.camera.request().isGranted) {
        return "Camera permission was granted.";
      } else {
        return "Camera permission was denied.";
      }
    } else {
      return "";
    }
  }

  Future<String> requestMultiplePermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.mediaLibrary,
    ].request();
    return statuses.toString();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton.icon(
              onPressed: () async {
                var st = await requestCameraPermission();
                setState(() {
                  status = st;
                });
              },
              label: const Text("Camera Access"),
              icon: const Icon(FluentIcons.camera_20_filled),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
              onPressed: () async {
                var st = await requestMultiplePermissions();
                setState(() {
                  status = st;
                });
              },
              label: const Text("Request multiple permissions"),
              icon: const Icon(FluentIcons.accessibility_20_filled),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
              onPressed: () {
                openAppSettings();
              },
              label: const Text("Open settings"),
              icon: const Icon(FluentIcons.settings_20_filled),
            ),
            const SizedBox(
              height: 50,
            ),
            Text(status, textAlign: TextAlign.center,)
          ],
        ),
      ),
    );
  }
}
