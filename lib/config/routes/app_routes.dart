import 'package:flutter/material.dart';
import '../../views/screens/screens.dart';

class AppRoute {
  static const intialRoute = 'listscreen';

  static Map<String, Widget Function(BuildContext)> routes = {
    'listscreen': (context) => const ListScreen(),
    'formscreen': (context) => const FormScreen(),
    'viewscreen': (context) => const ViewScreen(),
  };
}
