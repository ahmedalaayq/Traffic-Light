// import 'package:http/http.dart' as http;
//
// class EspService {
//   final String baseUrl;
//
//   EspService(this.baseUrl);
//
//   Future<bool> setLed(String color, bool on) async {
//     final res = await http.get(Uri.parse('$baseUrl/led?color=$color&state=${on ? "on" : "off"}')).timeout(Duration(seconds:5));
//     return res.statusCode == 200;
//   }
//
//   Future<bool> setDuration(String color, int ms) async {
//     final res = await http.get(Uri.parse('$baseUrl/setDuration?color=$color&ms=$ms')).timeout(Duration(seconds:5));
//     return res.statusCode == 200;
//   }
//
//   Future<bool> startAuto() async {
//     final res = await http.get(Uri.parse('$baseUrl/startAuto')).timeout(Duration(seconds:5));
//     return res.statusCode == 200;
//   }
//
//   Future<bool> stopAuto() async {
//     final res = await http.get(Uri.parse('$baseUrl/stopAuto')).timeout(Duration(seconds:5));
//     return res.statusCode == 200;
//   }
//
//   Future<String?> status() async {
//     final res = await http.get(Uri.parse('$baseUrl/status')).timeout(Duration(seconds:5));
//     if (res.statusCode == 200) return res.body;
//     return null;
//   }
// }