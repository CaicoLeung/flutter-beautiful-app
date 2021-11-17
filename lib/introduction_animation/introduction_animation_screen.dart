
import 'package:flutter/material.dart';
import 'package:startup_namer/introduction_animation/components/splash_view.dart';

class IntroductionAnimationScreen extends StatefulWidget {
  const IntroductionAnimationScreen({Key? key}) : super(key: key);

  @override
  _IntroductionAnimationScreenState createState() => _IntroductionAnimationScreenState();
}

class _IntroductionAnimationScreenState extends State<IntroductionAnimationScreen> with TickerProviderStateMixin {
  AnimationController? _animationController;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 8));
    _animationController?.animateTo(0);
    super.initState();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7EBE1),
      body: ClipRRect(
        child: Stack(
          children: [
            SplashView(animationController: _animationController!)
          ],
        ),
      ),
    );
  }
}