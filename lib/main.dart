import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traffic_light_ardino/services/views/smart_traffic_view.dart';
import 'view_models/smart_traffic_view_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SmartTrafficViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SmartTrafficView(),
    );
  }
}
