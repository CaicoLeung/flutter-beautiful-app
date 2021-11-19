import 'package:flutter/cupertino.dart';
import 'package:startup_namer/design_course/design_course_screen.dart';
import 'package:startup_namer/fitness_app/fitness_app_screen.dart';
import 'package:startup_namer/hotel_booking/hotel_booking_screen.dart';
import 'package:startup_namer/introduction_animation/introduction_animation_screen.dart';

class HomeList {
  HomeList({this.navigateScreen, this.imagePath = ""});

  Widget? navigateScreen;
  String imagePath;

  static List<HomeList> homeList = [
    HomeList(
        imagePath: 'assets/images/img01.png',
        navigateScreen: const IntroductionAnimationScreen()
    ),
    HomeList(
        imagePath: 'assets/images/img02.png',
        navigateScreen: const HotelBookingScreen()
    ),
    HomeList(
        imagePath: 'assets/images/img03.png',
        navigateScreen: const FitnessAppScreen()
    ),
    HomeList(
        imagePath: 'assets/images/img04.png',
        navigateScreen: const DesignCourseScreen()
    ),
  ];
}
