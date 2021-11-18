import 'package:flutter/material.dart';

class TopBackSkipView extends StatelessWidget {
  const TopBackSkipView(
      {Key? key,
      required this.animationController,
      required this.onBackCall,
      required this.onSkipCall})
      : super(key: key);

  final AnimationController animationController;
  final VoidCallback onBackCall;
  final VoidCallback onSkipCall;

  @override
  Widget build(BuildContext context) {
    final _animation =
        Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero).animate(
            CurvedAnimation(
                parent: animationController,
                curve: const Interval(0, 0.2, curve: Curves.fastOutSlowIn)));
    final _skipAnimation =
        Tween<Offset>(begin: Offset.zero, end: const Offset(2, 0)).animate(
            CurvedAnimation(
                parent: animationController,
                curve: const Interval(0.6, 0.8, curve: Curves.fastOutSlowIn)));
    return SlideTransition(
      position: _animation,
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: SizedBox(
          height: 58,
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: onBackCall,
                    icon: const Icon(Icons.arrow_back_ios_new_rounded)),
                SlideTransition(
                  position: _skipAnimation,
                  child: IconButton(
                    onPressed: onSkipCall,
                    icon: const Text("跳过", style: TextStyle(color: Color(0xff132137)),),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
