import 'package:flutter/material.dart';
import 'super_visors_screen.dart';
class CustomDrawerItem extends StatelessWidget {
  const CustomDrawerItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF2196F3), Color(0xFF0D47A1)],
        ),
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.transparent),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.lightbulb_outline, size: 40, color: Colors.amber),
                ),
                SizedBox(height: 10),
                Text(
                  'Smart Light Control',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'تحكم ذكي وسهل في إشارة المرور💡',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),

          ListTile(
            leading: const Icon(Icons.supervised_user_circle, color: Colors.white),
            title: const Text('الإشراف', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SupervisorView()),
              );
            },
          ),
          const ListTile(
            leading: Icon(Icons.settings, color: Colors.white),
            title: Text('الإعدادات', style: TextStyle(color: Colors.white)),
          ),
          const Divider(color: Colors.white24, indent: 16, endIndent: 16),
          ListTile(
            leading: const Icon(Icons.info_outline, color: Colors.white),
            title: const Text('عن التطبيق', style: TextStyle(color: Colors.white)),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'Smart Light Control',
                applicationVersion: '1.0.0',
                applicationIcon:
                const Icon(Icons.lightbulb_outline, color: Colors.amber),
                children: const [
                  Text(
                    'تطبيق ذكي للتحكم في الإضاءة عبر شبكة WiFi. '
                        'يسمح لك بتغيير الألوان، وضبط المؤقت، وتشغيل الوضع التلقائي بسهولة وسرعة.',
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
