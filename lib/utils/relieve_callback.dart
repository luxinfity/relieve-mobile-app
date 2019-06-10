import 'package:flutter/widgets.dart';
import 'package:relieve_app/datamodel/profile.dart';

/// Naming Convention for custom `datamodel` callback
/// typedef [Return]Callback[Model](Model model)
///
/// Non `datamodel` callback name should use the context where it is used

// relieve
typedef VoidCallbackProfile(Profile profile);

typedef RelieveBottomAction(int index, bool isCall); // non data model

// flutter
typedef VoidCallbackContext(BuildContext context);

// dart
typedef String StringCallback();
