import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class SupervisorView extends StatelessWidget {
  const SupervisorView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'قسم الإشراف',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff0b0b0d),
              Color(0xff1a1a1d),
              Color(0xff2b2b30),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 👇 أيقونة كبيرة متوهجة
                FadeInDown(
                  duration: const Duration(milliseconds: 800),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.purpleAccent.withOpacity(0.5),
                          blurRadius: 40,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.supervised_user_circle_rounded,
                      color: Colors.white,
                      size: 120,
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // 👇 النص التعريفي
                FadeInUp(
                  duration: const Duration(milliseconds: 900),
                  child: Card(
                    color: Colors.white.withOpacity(0.05),
                    elevation: 12,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: const [
                          Text(
                            'من خلال هذا القسم يمكنك متابعة حالة النظام ومراقبة أداء وحدات الإضاءة والتحكم بها بشكل مركزي 🔍',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              height: 1.6,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 20),
                          Divider(color: Colors.white24, thickness: 0.8),
                          SizedBox(height: 10),
                          Text(
                            'يُتيح هذا القسم لمشرف النظام التحكم في إشارات المرور، مراقبة التوقيتات، وضمان سلامة عمل النظام لحظيًا.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white70,
                              height: 1.6,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 50),

                // 👇 كارت فريق العمل
                FadeInUp(
                  duration: const Duration(milliseconds: 1000),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 25, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withOpacity(0.1)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'فريق العمل 👨‍💻',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Divider(color: Colors.white24, thickness: 1),
                        const SizedBox(height: 14),
                        const Text(
                          'أحمد عماد صادق\n'
                              'كريم عبد الشهيد عبد النبي',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 17,
                            height: 1.6,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 14),
                        const Text(
                          'كلية التربية النوعية - شعبة تكنولوجيا التعليم\n'
                              'مقرر نظم إدارة التعلم الذكية',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white60,
                            fontSize: 14,
                            height: 1.4,
                          ),
                        ),

                        const SizedBox(height: 22),

                        // زر أنيق للتواصل أو الرجوع
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            Colors.purpleAccent.withOpacity(0.8),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            elevation: 10,
                          ),
                          icon: const Icon(Icons.arrow_back_ios_new_rounded,
                              color: Colors.white, size: 22),
                          label: const Text(
                            "رجوع",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
