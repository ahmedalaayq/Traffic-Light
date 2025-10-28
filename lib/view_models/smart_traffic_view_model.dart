import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:traffic_light_ardino/models/traffic_controller.dart';

class SmartTrafficViewModel extends ChangeNotifier {
  final String baseUrl = 'http://192.168.4.1';

  bool isAutoRunning = false;
  bool _isCycleCancelled = false;

  TrafficLightModel red = TrafficLightModel(color: 'red', duration: 5);
  TrafficLightModel yellow = TrafficLightModel(color: 'yellow', duration: 2);
  TrafficLightModel green = TrafficLightModel(color: 'green', duration: 5);

  Future<void> _sendRequest(String color, bool turnOn) async {
    String url = '';
    if (turnOn) {
      switch (color) {
        case 'red':
          url = '$baseUrl/red_on';
          break;
        case 'yellow':
          url = '$baseUrl/yellow_on';
          break;
        case 'green':
          url = '$baseUrl/green_on';
          break;
        case 'all': // ✅ الحالة الجديدة لتشغيل الكل
          url = '$baseUrl/all_on';
          break;
      }
    } else {
      url = '$baseUrl/off';
    }

    try {
      await http.get(Uri.parse(url)).timeout(const Duration(seconds: 15));
      debugPrint('✅ Request sent: $url');
    } catch (e) {
      debugPrint('❌ Request failed: $e');
    }
  }

  void toggleLight(TrafficLightModel light) {
    if (isAutoRunning) return;
    light.isOn = !light.isOn;
    notifyListeners();
    _sendRequest(light.color, light.isOn);
  }

  void setDuration(TrafficLightModel light, double seconds) {
    light.duration = seconds;
    notifyListeners();
  }

  Future<void> _runLight(TrafficLightModel light) async {
    red.isOn = false;
    yellow.isOn = false;
    green.isOn = false;
    notifyListeners();

    light.isOn = true;
    notifyListeners();
    await _sendRequest(light.color, true);

    await Future.delayed(Duration(seconds: light.duration.toInt()));

    light.isOn = false;
    notifyListeners();
    await _sendRequest(light.color, false);
  }

  Future<void> startAutoCycle() async {
    if (isAutoRunning) return;
    isAutoRunning = true;
    _isCycleCancelled = false;
    notifyListeners();

    try {
      await http.get(Uri.parse('$baseUrl/auto')).timeout(const Duration(seconds: 2));
      debugPrint('▶️ Auto Mode Started');
    } catch (e) {
      debugPrint('❌ Failed to start auto mode: $e');
    }

    while (!_isCycleCancelled) {
      await _runLight(red);
      if (_isCycleCancelled) break;
      await _runLight(yellow);
      if (_isCycleCancelled) break;
      await _runLight(green);
      if (_isCycleCancelled) break;
    }

    isAutoRunning = false;
    red.isOn = false;
    yellow.isOn = false;
    green.isOn = false;
    notifyListeners();
  }

  void stopAutoCycle() {
    _isCycleCancelled = true;
    isAutoRunning = false;
    notifyListeners();

    _sendRequest('red', false);
    _sendRequest('yellow', false);
    _sendRequest('green', false);

    red.isOn = false;
    yellow.isOn = false;
    green.isOn = false;
    notifyListeners();

    debugPrint('⛔ Auto Mode Stopped');
  }

  // ✅ دالة جديدة لتشغيل كل اللمبات يدويًا
  void turnAllLightsOn() {
    if (isAutoRunning) return;
    red.isOn = true;
    yellow.isOn = true;
    green.isOn = true;
    notifyListeners();
    _sendRequest('all', true);
  }

  // ✅ دالة لإطفاء الكل يدويًا (اختيارية)
  void turnAllLightsOff() {
    red.isOn = false;
    yellow.isOn = false;
    green.isOn = false;
    notifyListeners();
    _sendRequest('red', false);
    _sendRequest('yellow', false);
    _sendRequest('green', false);
  }
}
