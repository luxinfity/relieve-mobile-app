import 'package:flutter/widgets.dart';
import 'package:relieve_app/datamodel/map_address.dart';
import 'package:relieve_app/datamodel/user.dart';

/// Naming Convention for custom `datamodel` callback
/// typedef [Return][Model]Callback(Model model)
///
/// Non `datamodel` callback name should use the context where it is used

// relieve
typedef UserCallback(User user);

typedef RelieveBottomAction(int index, bool isCall); // non data model

typedef MapAddressCallback(MapAddress profile);

// flutter
typedef VoidContextCallback(BuildContext context);

// dart
typedef String StringCallback();
