
import 'package:flutter/material.dart';
import 'package:startup_namer/introduction_animation/components/care_view.dart';
import 'package:startup_namer/introduction_animation/components/center_next_button.dart';
import 'package:startup_namer/introduction_animation/components/mood_diary_view.dart';
import 'package:startup_namer/introduction_animation/components/relax_view.dart';
import 'package:startup_namer/introduction_animation/components/splash_view.dart';
import 'package:startup_namer/introduction_animation/components/top_back_skip_view.dart';
import 'package:startup_namer/introduction_animation/components/welcome_view.dart';

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

  void _onSkipCall() {
    _animationController?.animateTo(0.8, duration: const Duration(milliseconds: 1200));
  }

  void _onBackCall() {
    if (_animationController!.value >= 0 && _animationController!.value <= 0.2) {
      _animationController?.animateTo(0);
    } else if (_animationController!.value > 0.2 && _animationController!.value <= 0.4) {
      _animationController?.animateTo(0.2);
    } else if (_animationController!.value > 0.4 && _animationController!.value <= 0.6) {
      _animationController?.animateTo(0.4);
    } else if (_animationController!.value > 0.6 && _animationController!.value <= 0.8) {
      _animationController?.animateTo(0.6);
    }  else if (_animationController!.value > 0.8 && _animationController!.value <= 1) {
      _animationController?.animateTo(0.8);
    }
  }

  void _signUpClick() {
    Navigator.pop(context);
  }

  void _onNextClick() {
    if (_animationController!.value >= 0 &&
        _animationController!.value <= 0.2) {
      _animationController?.animateTo(0.4);
    } else if (_animationController!.value > 0.2 &&
        _animationController!.value <= 0.4) {
      _animationController?.animateTo(0.6);
    } else if (_animationController!.value > 0.4 &&
        _animationController!.value <= 0.6) {
      _animationController?.animateTo(0.8);
    } else if (_animationController!.value > 0.6 &&
        _animationController!.value <= 0.8) {
      _signUpClick();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7EBE1),
      body: ClipRRect(
        child: Stack(
          children: [
            SplashView(animationController: _animationController!),
            RelaxView(animationController: _animationController!,),
            CareView(animationController: _animationController!),
            MoodDiaryView(animationController: _animationController!,),
            WelcomeView(animationController: _animationController!,),
            TopBackSkipView(animationController: _animationController!, onBackCall: _onBackCall, onSkipCall: _onSkipCall,),
            CenterNextButton(animationController: _animationController!, onNextClick: _onNextClick,)
          ],
        ),
      ),
    );
  }
}