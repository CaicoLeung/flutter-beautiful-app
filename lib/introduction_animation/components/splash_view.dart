import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key, required this.animationController})
      : super(key: key);

  final AnimationController animationController;

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    final _introductionAnimation =
        Tween<Offset>(begin: Offset.zero, end: const Offset(0, -1)).animate(
            CurvedAnimation(
                parent: widget.animationController,
                curve: const Interval(0, 0.2, curve: Curves.fastOutSlowIn)));
    return SlideTransition(
      position: _introductionAnimation,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                'assets/introduction_animation/introduction_image.png',
                fit: BoxFit.cover,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                "Clearhead",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 64),
              child: Text(
                "Lorem ipsum dolor sit amet,consectetur adipiscing elit,sed do eiusmod tempor incididunt ut labore",
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 48,
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom + 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(38),
                child: TextButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              horizontal: 56, vertical: 16)),
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xFF132137))),
                  onPressed: () => widget.animationController.animateTo(0.2),
                  child: const Text("Let's begin",
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
