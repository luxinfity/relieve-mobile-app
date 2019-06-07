import 'package:flutter/widgets.dart';
import 'package:relieve_app/datamodel/map_address.dart';
import 'package:relieve_app/datamodel/user.dart';

/// Naming Convention for custom `datamodel` callback
/// typedef [Return]Callback[Model](Model model)
///
/// Non `datamodel` callback name should use the context where it is used

// relieve
typedef VoidCallbackUser(User user);

typedef RelieveBottomAction(int index, bool isCall); // non data model

typedef VoidCallbackMapAddress(MapAddress profile);

// flutter
typedef VoidCallbackContext(BuildContext context);

// dart
typedef String StringCallback();
