import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:ielts/home_module/view/clock_view.dart';
import 'package:ielts/home_module/view/credit_card_view.dart';
import 'package:ielts/home_module/view/flutter_side_menu.dart';
import 'package:ielts/home_module/view/hidden_drawer_view.dart';

import 'package:ielts/utilities/navigation/go_paths.dart';

import '../../home_module/view/custom_drawer_view.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

final prefs = GetStorage();

final GoRouter goRouterConfig = GoRouter(
  initialLocation: GoPaths.landingView,
  // : _defaultController.state?.result?.path ?? GoPaths.selectCountryData,
  navigatorKey: rootNavigatorKey,
  routes: [
    // // -------------------------------------- NAV BAR Routes --------------------------------------

    // ShellRoute(
    //   navigatorKey: shellNavigatorKey,
    //   builder: (context, state, child) {
    //     return LandingView(
    //       child: child,
    //     );
    //   },
    //   routes: [
    //     // GoRoute(
    //     //   parentNavigatorKey: shellNavigatorKey,
    //     //   path: GoPaths.ieltsDashboard,
    //     //   name: GoPaths.ieltsDashboard,
    //     //   builder: (context, state) {
    //     //     return const HomeViewScreen();
    //     //   },
    //     // ),
    //
    //     //    add more bottom navigation routes here
    //   ],
    // ),

  GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.landingView,
      name: GoPaths.landingView,
      builder: (context, state) {
        // return const HiddenDrawerView();
        // return const DefaultCustomDrawer();
        // return const CustomSideDrawer();
        // return  CustomClock();
        return  CreditCardPage();
      },
    ),
  ],
);
