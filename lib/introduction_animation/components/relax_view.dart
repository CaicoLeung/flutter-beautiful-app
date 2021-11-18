import 'package:flutter/material.dart';

class RelaxView extends StatelessWidget {
  const RelaxView({Key? key, required this.animationController}) : super(key: key);

  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    final _firstHalfAnimation = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(
      CurvedAnimation(parent: animationController, curve: const Interval(0, 0.2, curve: Curves.fastOutSlowIn))
    );
    final _secondHalfAnimation = Tween<Offset>(begin: Offset.zero, end: const Offset(-1, 0)).animate(
        CurvedAnimation(parent: animationController, curve: const Interval(0.2, 0.4, curve: Curves.fastOutSlowIn))
    );
    final _relaxAnimation = Tween<Offset>(begin: const Offset(0, -2), end: Offset.zero).animate(
        CurvedAnimation(parent: animationController, curve: const Interval(0, 0.2, curve: Curves.fastOutSlowIn))
    );
    final _textAnimation = Tween<Offset>(begin: Offset.zero, end: const Offset(-2, 0)).animate(
        CurvedAnimation(parent: animationController, curve: const Interval(0.2, 0.4, curve: Curves.fastOutSlowIn))
    );
    final _imageAnimation = Tween<Offset>(begin: Offset.zero, end: const Offset(-4, 0)).animate(
        CurvedAnimation(parent: animationController, curve: const Interval(0.2, 0.4, curve: Curves.fastOutSlowIn))
    );
    return SlideTransition(
      position: _firstHalfAnimation,
      child: SlideTransition(
        position: _secondHalfAnimation,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SlideTransition(
                  position: _relaxAnimation,
                  child: const Text(
                    "Relax",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                ),
                SlideTransition(
                  position: _textAnimation,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 64, vertical: 16),
                    child: Text(
                      "Lorem ipsum dolor sit amet,consectetur adipiscing elit,sed do eiusmod tempor incididunt ut labore",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SlideTransition(
                  position: _imageAnimation,
                  child:  Container(
                    constraints: const BoxConstraints(maxWidth: 350, maxHeight: 250),
                    child: Image.asset('assets/introduction_animation/relax_image.png', fit: BoxFit.contain,),
                  ),
                ),
              ],
          ),
        ),
      ),
    );
  }
}

