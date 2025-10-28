import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_models/smart_traffic_view_model.dart';
import 'widgets/smart_traffic_body.dart';

class SmartTrafficView extends StatelessWidget {
  const SmartTrafficView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SmartTrafficViewModel(),
      child: const SmartTrafficBody(),
    );
  }
}
