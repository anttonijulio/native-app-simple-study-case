import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConnectionPage extends StatefulWidget {
  const ConnectionPage({super.key});

  @override
  State<ConnectionPage> createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage> {
  static const _platform = MethodChannel('native_app/connection');

  String _connectionStatus = 'Waiting to get connection 🔃';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_connectionStatus, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _getConnectionStatus,
              child: const Text('Get Connection'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getConnectionStatus() async {
    String connectionStatus;
    try {
      bool isConnected = await _platform.invokeMethod('getConnectionStatus');
      if (isConnected) {
        connectionStatus = 'Connected to the internet 🛜';
      } else {
        connectionStatus = 'No internet connection ❌';
      }
    } catch (e) {
      connectionStatus =
          '⚠️ Error to get internet connection status with Error: ${e.toString()}';
    }
    setState(() => _connectionStatus = connectionStatus);
  }
}
