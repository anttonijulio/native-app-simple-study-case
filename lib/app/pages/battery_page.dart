import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BatteryPage extends StatefulWidget {
  const BatteryPage({super.key});

  @override
  State<BatteryPage> createState() => _BatteryPageState();
}

class _BatteryPageState extends State<BatteryPage> {
  static const _platform = MethodChannel('native_app/battery');

  String _batteryLevel = 'Unknown battery level..';

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final result = await _platform.invokeMethod<int>('getBatteryLevel');
      batteryLevel = 'Battery Level At $result%';
    } catch (e) {
      batteryLevel = 'Failed to get Battery Level with Error: ${e.toString()}';
    }

    setState(() => _batteryLevel = batteryLevel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_batteryLevel, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _getBatteryLevel,
              child: const Text('Get Battery Level'),
            ),
          ],
        ),
      ),
    );
  }
}
