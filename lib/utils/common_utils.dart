import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logging/logging.dart';

typedef VoidContextCallback(BuildContext context);
typedef String StringCallback();

void defaultBackPressed(BuildContext context) {
  Navigator.pop(context);
}

final CameraPosition jakartaCoordinate = CameraPosition(
  target: LatLng(-6.21462, 106.84513),
  zoom: 14,
);

Timer _debounceTimer;

void debounce(VoidCallback callback,
    {Duration duration = const Duration(seconds: 3)}) {
  if (_debounceTimer != null) {
    _debounceTimer.cancel();
  }

  _debounceTimer = Timer(duration, callback);
}

Logger debugLog(Type where) => Logger(where.toString());
