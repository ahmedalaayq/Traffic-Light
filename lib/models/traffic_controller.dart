class TrafficLightModel {
  final String color;
  bool isOn;
  double duration;

  TrafficLightModel({
    required this.color,
    this.isOn = false,
    this.duration = 5,
  });
}
