import 'package:flutter/foundation.dart';

class Disaster {
  final bool isLive;
  final String title;
  final String location;
  final int time;

  const Disaster({
    @required this.isLive,
    this.title,
    this.location,
    this.time,
  });
}
