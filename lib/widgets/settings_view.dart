import 'package:flutter/material.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF00897B), Color(0xFF004D40)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Icon(Icons.settings, color: Colors.white, size: 80),
              const SizedBox(height: 10),
              const Text(
                'الإعدادات',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Center(
                  child: Card(
                    elevation: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    child: const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        'يمكنك من هنا تعديل عنوان الـ IP الخاص بالـ NodeMCU\n'
                            'وضبط إعدادات الاتصال بالشبكة 🛠️',
                        style: TextStyle(fontSize: 18, height: 1.5),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooter() => const Padding(
    padding: EdgeInsets.all(12.0),
    child: Text(
      'عمل الطالب: أحمد عماد - كريم عبد الشهيد\n'
          'كلية التربية النوعية - شعبة حاسب\n'
          'مقرر نظم إدارة التعلم الذكية',
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.white70, fontSize: 14, height: 1.4),
    ),
  );
}
