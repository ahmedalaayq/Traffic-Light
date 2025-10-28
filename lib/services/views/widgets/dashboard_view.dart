// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:traffic_light_ardino/view_models/smart_traffic_view_model.dart';
// import 'package:traffic_light_ardino/models/traffic_controller.dart';
//
// class DashboardView extends StatefulWidget {
//   const DashboardView({super.key});
//
//   @override
//   State<DashboardView> createState() => _DashboardViewState();
// }
//
// class _DashboardViewState extends State<DashboardView> with TickerProviderStateMixin {
//   late AnimationController _pulseController;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _pulseController = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 1),
//     )..repeat(reverse: true);
//
//     Future.doWhile(() async {
//       await Future.delayed(const Duration(seconds: 5));
//       final vm = context.read<SmartTrafficViewModel>();
//       await vm.checkConnection();
//       return true;
//     });
//   }
//
//   @override
//   void dispose() {
//     _pulseController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final vm = context.watch<SmartTrafficViewModel>();
//     final size = MediaQuery.of(context).size;
//     final isTablet = size.width > 600;
//
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFF0D001F), Color(0xFF2E0059)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: SafeArea(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               children: [
//                 _buildArduinoStatus(vm),
//                 const SizedBox(height: 30),
//                 _buildLedSection(vm, isTablet),
//                 const SizedBox(height: 30),
//                 _buildAutoModeCard(vm, isTablet),
//                 const SizedBox(height: 30),
//                 _buildControlButtons(vm, isTablet),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildArduinoStatus(SmartTrafficViewModel vm) {
//     return AnimatedBuilder(
//       animation: _pulseController,
//       builder: (context, child) {
//         final glow = _pulseController.value * 25 + 10;
//         return Container(
//           padding: const EdgeInsets.all(20),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(30),
//             color: Colors.white.withOpacity(0.1),
//             border: Border.all(color: Colors.white.withOpacity(0.15)),
//             boxShadow: [
//               BoxShadow(
//                 color: vm.isConnected ? Colors.greenAccent.withOpacity(0.5) : Colors.redAccent.withOpacity(0.5),
//                 blurRadius: glow,
//                 spreadRadius: 1,
//               ),
//             ],
//             gradient: vm.isConnected
//                 ? RadialGradient(colors: [Colors.greenAccent.withOpacity(0.4), Colors.green.withOpacity(0.05)])
//                 : RadialGradient(colors: [Colors.redAccent.withOpacity(0.4), Colors.red.withOpacity(0.05)]),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text(
//                 'Arduino Status',
//                 style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
//               ),
//               Row(
//                 children: [
//                   Container(
//                     width: 18,
//                     height: 18,
//                     decoration: BoxDecoration(
//                       color: vm.isConnected ? Colors.greenAccent : Colors.redAccent,
//                       shape: BoxShape.circle,
//                       boxShadow: [
//                         BoxShadow(
//                           color: vm.isConnected ? Colors.greenAccent.withOpacity(0.6) : Colors.redAccent.withOpacity(0.6),
//                           blurRadius: glow,
//                           spreadRadius: 1,
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                   Text(
//                     vm.isConnected ? 'Connected ✅' : 'Disconnected ❌',
//                     style: TextStyle(
//                       color: vm.isConnected ? Colors.greenAccent : Colors.redAccent,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildLedSection(SmartTrafficViewModel vm, bool isTablet) {
//     final leds = [vm.red, vm.yellow, vm.green];
//     final colors = [Colors.redAccent, Colors.yellowAccent, Colors.greenAccent];
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Padding(
//           padding: EdgeInsets.only(bottom: 12),
//           child: Text(
//             'حالة اللمبات',
//             style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//         ),
//         GridView.builder(
//           physics: const NeverScrollableScrollPhysics(),
//           shrinkWrap: true,
//           itemCount: leds.length,
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: isTablet ? 3 : 2,
//             mainAxisSpacing: 25,
//             crossAxisSpacing: 25,
//             childAspectRatio: 1,
//           ),
//           itemBuilder: (context, index) {
//             return _buildLedCard(leds[index], colors[index]);
//           },
//         ),
//       ],
//     );
//   }
//
//   Widget _buildLedCard(TrafficLightModel led, Color color) {
//     return TweenAnimationBuilder<double>(
//       tween: Tween(begin: 0, end: led.isOn ? 1 : 0),
//       duration: const Duration(milliseconds: 500),
//       builder: (context, value, child) {
//         final glow = value * 20 + 5;
//         return GestureDetector(
//           onTap: ()=> context.read<SmartTrafficViewModel>().toggleLight(led),
//           child: Container(
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: Colors.white.withOpacity(0.05),
//               gradient: led.isOn
//                   ? RadialGradient(colors: [color.withOpacity(0.95), color.withOpacity(0.2)])
//                   : null,
//               boxShadow: [
//                 BoxShadow(
//                   color: led.isOn ? color.withOpacity(0.7) : Colors.black.withOpacity(0.2),
//                   blurRadius: glow,
//                   spreadRadius: led.isOn ? 5 : 1,
//                 ),
//               ],
//             ),
//             alignment: Alignment.center,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   led.color.toUpperCase(),
//                   style: TextStyle(
//                     color: led.isOn ? Colors.white : color,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 20,
//                   ),
//                 ),
//                 const SizedBox(height: 6),
//                 Text(
//                   '${led.duration.toInt()} sec',
//                   style: const TextStyle(color: Colors.white70, fontSize: 14),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildAutoModeCard(SmartTrafficViewModel vm, bool isTablet) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 500),
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(30),
//         gradient: LinearGradient(
//           colors: vm.isAutoRunning
//               ? [Colors.greenAccent.withOpacity(0.6), Colors.greenAccent.withOpacity(0.2)]
//               : [Colors.redAccent.withOpacity(0.6), Colors.redAccent.withOpacity(0.2)],
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: (vm.isAutoRunning ? Colors.greenAccent : Colors.redAccent).withOpacity(0.5),
//             blurRadius: 25,
//             offset: const Offset(0, 6),
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           const Text(
//             'Auto Mode',
//             style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           ElevatedButton.icon(
//             onPressed: vm.isAutoRunning ? vm.stopAutoCycle : vm.startAutoCycle,
//             icon: Icon(vm.isAutoRunning ? Icons.stop_circle : Icons.play_arrow),
//             label: Text(vm.isAutoRunning ? 'Stop' : 'Start'),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: vm.isAutoRunning ? Colors.redAccent : Colors.greenAccent,
//               padding: EdgeInsets.symmetric(horizontal: isTablet ? 30 : 18, vertical: isTablet ? 14 : 10),
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
//               elevation: 12,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildControlButtons(SmartTrafficViewModel vm, bool isTablet) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         _buildControlButton('تشغيل الكل', Colors.greenAccent, vm.turnAllLightsOn, isTablet),
//         _buildControlButton('إيقاف الكل', Colors.redAccent, vm.turnAllLightsOff, isTablet),
//       ],
//     );
//   }
//
//   Widget _buildControlButton(String text, Color color, VoidCallback onTap, bool isTablet) {
//     return ElevatedButton(
//       onPressed: onTap,
//       style: ElevatedButton.styleFrom(
//         backgroundColor: color,
//         padding: EdgeInsets.symmetric(horizontal: isTablet ? 50 : 25, vertical: isTablet ? 18 : 12),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//         elevation: 12,
//       ),
//       child: Text(
//         text,
//         style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//       ),
//     );
//   }
// }
