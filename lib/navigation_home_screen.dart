import 'package:flutter/material.dart';
import 'package:startup_namer/app_theme.dart';

class NavigationHomeScreen extends StatefulWidget {
  const NavigationHomeScreen({Key? key}) : super(key: key);

  @override
  _NavigationHomeScreenState createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: const SafeArea(
        child: Scaffold(
          body: Text("TODO", style: TextStyle(fontStyle: FontStyle.italic),),
        ),
      ),
    );
  }

}