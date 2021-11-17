import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'custom_drawer/drawer_user_controller.dart';

import 'custom_drawer/helper.dart';
import 'home_screen.dart';

class NavigationHomeScreen extends StatefulWidget {
  const NavigationHomeScreen({Key? key}) : super(key: key);

  @override
  _NavigationHomeScreenState createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  Widget? screenView;
  DrawerIndex? drawerIndex;

  @override
  void initState() {
    screenView = const HomeScreen();
    drawerIndex = DrawerIndex.home;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child:  SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: DrawerUserController(
            screenIndex: drawerIndex!,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            onDrawerCall: (index) {
              // TODO
            },
            screenView: screenView,
          ),
        ),
      ),
    );
  }
}
