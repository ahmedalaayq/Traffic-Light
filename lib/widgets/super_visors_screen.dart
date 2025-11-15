
import 'package:flutter/material.dart';

class SupervisorView extends StatefulWidget {
  const SupervisorView({super.key}); 

  @override
  State<SupervisorView> createState() => _SupervisorViewState();
}

class _SupervisorViewState extends State<SupervisorView> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..forward();

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'قسم الإشراف',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF2C003E),
              Color(0xFF512DA8),
              Color(0xFF7E57C2),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: FadeTransition(
              opacity: _animation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
//👩‍🏫
                  _buildSectionTitle('إشراف المشروع'),
                  const SizedBox(height: 15),
                  _buildSupervisorCard(
                    name: 'أ.د/ أميرة',
                    subtitle: 'المشرف العام على المشروع',
                    image: null,
                  ),
                  const SizedBox(height: 20),
                  _buildSupervisorCard(
                    name: 'د/ شاهندة',
                    subtitle: 'المشرف المساعد',
                    image: null,
                  ),

                  const SizedBox(height: 40),
//👨‍💻
                  _buildSectionTitle('فريق العمل'),
                  const SizedBox(height: 15),
                  _buildTeamMemberCard(
                    name: 'أحمد عماد صادق',
                    subtitle: 'تطوير واجهات المستخدم والبرمجة',
                    image: 'assets/images/ahmed.jpg',
                  ),
                  const SizedBox(height: 20),
                  _buildTeamMemberCard(
                    name: 'كريم عبد الشهيد عبد النبي',
                    subtitle: 'برمجة الأنظمة والتحكم الذكي',
                    image: 'assets/images/kareem.jpeg',
                  ),

                  const SizedBox(height: 60),
                  Text(
                    'كلية التربية النوعية - شعبة إعداد معلم حاسب\nمقرر نظم إدارة التعلم الذكية',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: isTablet ? 18 : 15,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 22,
        color: Colors.white,
        fontWeight: FontWeight.bold,
        letterSpacing: 1,
      ),
    );
  }

  Widget _buildSupervisorCard({
    required String name,
    required String subtitle,
    required String? image,
  }) {
    return _buildPersonCard(
      name: name,
      subtitle: subtitle,
      image: image,
      glowColor: Colors.purpleAccent,
    );
  }

  Widget _buildTeamMemberCard({
    required String name,
    required String subtitle,
    required String image,
  }) {
    return _buildPersonCard(
      name: name,
      subtitle: subtitle,
      image: image,
      glowColor: Colors.cyanAccent,
    );
  }

  Widget _buildPersonCard({
    required String name,
    required String subtitle,
    String? image,
    required Color glowColor,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 30 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
          boxShadow: [
            BoxShadow(
              color: glowColor.withOpacity(0.4),
              blurRadius: 25,
              spreadRadius: 3,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: glowColor.withOpacity(0.6),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: image != null
                  ? CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage(image),
              )
                  : const CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white24,
                child: Icon(Icons.person, color: Colors.white70, size: 40),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
