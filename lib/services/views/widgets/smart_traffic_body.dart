import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traffic_light_ardino/models/traffic_controller.dart';
import 'package:traffic_light_ardino/view_models/smart_traffic_view_model.dart';
import 'package:traffic_light_ardino/widgets/custom_appbar.dart';
import 'package:traffic_light_ardino/widgets/custom_drawer_item.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:animate_do/animate_do.dart';
import 'package:url_launcher/url_launcher.dart';

class SmartTrafficBody extends StatelessWidget {
  const SmartTrafficBody({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SmartTrafficViewModel>();
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 700;

    return Scaffold(
      drawer: const Drawer(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        child: CustomDrawerItem(),
      ),
      extendBodyBehindAppBar: true,
      appBar: const CustomAppbar(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff0b0b0d), Color(0xff1a1a1d)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isTablet ? 60 : 20,
            vertical: isTablet ? 120 : 80,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildTrafficBox(vm, size),
                  SizedBox(height: isTablet ? 50 : 35),
                  _buildControlPanel(vm, size),
                  SizedBox(height: isTablet ? 50 : 35),
                  _buildButtonsSection(vm, size),
                  const SizedBox(height: 60),
                  _buildQrSection(isTablet),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTrafficBox(SmartTrafficViewModel vm, Size size) {
    final circleSize = size.width < 400 ? 80.0 : 110.0;

    return Container(
      margin: EdgeInsets.only(top: circleSize*0.5),
      padding: EdgeInsets.symmetric(vertical: 25,horizontal: circleSize * 0.2),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha:0.25),
        borderRadius: BorderRadius.circular(35),
        border: Border.all(color: Colors.white12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.7),
            blurRadius: 25,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildLight(vm.red, vm, circleSize),
          _buildLight(vm.yellow, vm, circleSize),
          _buildLight(vm.green, vm, circleSize),
        ],
      ),
    );
  }

  Widget _buildLight(TrafficLightModel light, SmartTrafficViewModel vm, double size) {
    final Map<String, Color> colors = {
      'red': Colors.redAccent,
      'yellow': Colors.yellowAccent,
      'green': Colors.greenAccent,
    };

    final activeColor = colors[light.color] ?? Colors.white;

    return GestureDetector(
      onTap: () => vm.toggleLight(light),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        margin: const EdgeInsets.symmetric(vertical: 14),
        height: size,
        width: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: light.isOn
              ? RadialGradient(
            colors: [
              activeColor,
              activeColor.withValues(alpha:0.4),
              Colors.black.withValues(alpha:0.2),
            ],
            stops: const [0.2, 0.7, 1],
          )
              : const RadialGradient(
            colors: [Color(0xff222226), Color(0xff161617)],
            stops: [0.3, 1],
          ),
          boxShadow: light.isOn
              ? [
            BoxShadow(
              color: activeColor.withValues(alpha:0.7),
              blurRadius: 40,
              spreadRadius: 10,
            ),
          ]
              : [],
          border: Border.all(color: Colors.white10, width: 2),
        ),
      ),
    );
  }

  Widget _buildControlPanel(SmartTrafficViewModel vm, Size size) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha:0.05),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '⏱ Timing Controls',
            style: TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 20),
          _buildSlider(vm.red, Colors.redAccent, vm),
          _buildSlider(vm.yellow, Colors.yellowAccent, vm),
          _buildSlider(vm.green, Colors.greenAccent, vm),
        ],
      ),
    );
  }

  Widget _buildSlider(TrafficLightModel light, Color color, SmartTrafficViewModel vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${light.color.toUpperCase()} Light (${light.duration.toStringAsFixed(0)}s)",
          style: const TextStyle(color: Colors.white70, fontSize: 15),
        ),
        Slider(
          value: light.duration,
          min: 1,
          max: 10,
          divisions: 9,
          activeColor: color,
          inactiveColor: Colors.white24,
          thumbColor: color,
          onChanged: (v) => vm.setDuration(light, v),
        ),
      ],
    );
  }

  Widget _buildButtonsSection(SmartTrafficViewModel vm, Size size) {
    final isTablet = size.width > 700;

    return Column(
      children: [
        Wrap(
          spacing: 16,
          runSpacing: 12,
          alignment: WrapAlignment.center,
          children: [
            _buildButton(
              label: "Start Auto",
              icon: Icons.play_arrow_rounded,
              color: Colors.greenAccent,
              enabled: !vm.isAutoRunning,
              onTap: vm.startAutoCycle,
            ),
            _buildButton(
              label: "Stop Auto",
              icon: Icons.stop_circle_outlined,
              color: Colors.redAccent,
              enabled: vm.isAutoRunning,
              onTap: vm.stopAutoCycle,
            ),
          ],
        ),
        const SizedBox(height: 25),
        Wrap(
          spacing: 16,
          alignment: WrapAlignment.center,
          children: [
            _buildButton(
              label: "Start All",
              icon: Icons.lightbulb_outline,
              color: Colors.blueAccent,
              enabled: !vm.isAutoRunning,
              onTap: vm.turnAllLightsOn,
            ),
            _buildButton(
              label: "Stop All",
              icon: Icons.power_settings_new,
              color: Colors.orangeAccent,
              enabled: true,
              onTap: vm.turnAllLightsOff,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildButton({
    required String label,
    required IconData icon,
    required Color color,
    required bool enabled,
    required VoidCallback onTap,
  }) {
    return ElevatedButton.icon(
      onPressed: enabled ? onTap : null,
      icon: Icon(icon, size: 24, color: Colors.white),
      label: Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: enabled ? color.withValues(alpha:0.85) : Colors.grey.withValues(alpha:0.3),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        elevation: 8,
      ),
    );
  }

  Widget _buildQrSection(bool isTablet) {
    return FadeInUp(
      duration: const Duration(milliseconds: 800),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withValues(alpha:0.8),
                  Colors.grey.shade900.withValues(alpha:0.6),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.greenAccent.withValues(alpha:0.4),
                  blurRadius: 20,
                  spreadRadius: 3,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Scan to Submit Feedback',
                  style: TextStyle(
                    color: Colors.greenAccent.shade100,
                    fontSize: isTablet ? 22 : 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                InkWell(
                  onTap: () {
                    final url = 'https://forms.gle/ntzvL3VZKYeBb5A59';
                    launchUrl(Uri.parse(url));
                  },
                  borderRadius: BorderRadius.circular(20),
                  splashColor: Colors.greenAccent.withValues(alpha:0.2),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.greenAccent.withValues(alpha:0.5),
                          blurRadius: 15,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: QrImageView(
                      data: 'https://forms.gle/ntzvL3VZKYeBb5A59',
                      version: QrVersions.auto,
                      size: isTablet ? 220 : 160,
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          )
,
          const SizedBox(height: 18),
          Text(
            "📱 Scan to open the form",
            style: TextStyle(
              color: Colors.white.withValues(alpha:0.85),
              fontSize: isTablet ? 18 : 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          const PulseGlow(color: Colors.greenAccent, size: 80),
        ],
      ),
    );
  }
}

class PulseGlow extends StatefulWidget {
  final Color color;
  final double size;
  const PulseGlow({super.key, required this.color, required this.size});

  @override
  State<PulseGlow> createState() => _PulseGlowState();
}

class _PulseGlowState extends State<PulseGlow> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))
      ..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.5, end: 1.4).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: widget.color.withValues(alpha:0.4),
              blurRadius: 40,
              spreadRadius: 20,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
