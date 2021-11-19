import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:startup_namer/app_theme.dart';

class MusicScreen extends StatefulWidget {
  const MusicScreen({
    Key? key,
  }) : super(key: key);

  @override
  _MusicScreenState createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen>
    with TickerProviderStateMixin {
  AnimationController? rotationAnimationController;
  Animation<double>? rotationAnimation;
  AnimationController? iconAnimationController;

  bool isPause = false;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    iconAnimationController =
        AnimationController(vsync: this, duration: Duration.zero);
    rotationAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 10));
    rotationAnimation =
        Tween<double>(begin: 1, end: 3).animate(rotationAnimationController!)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              rotationAnimationController!.reset();
              rotationAnimationController!.forward();
            } else if (status == AnimationStatus.dismissed) {
              rotationAnimationController!.forward();
            }
          });
    rotationAnimationController!.forward();
    super.initState();
  }

  @override
  void dispose() {
    iconAnimationController?.dispose();
    rotationAnimationController?.dispose();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isPause == true) {
      rotationAnimationController?.stop();
      iconAnimationController?.animateTo(0,
          duration: const Duration(milliseconds: 250));
    } else {
      rotationAnimationController?.forward();
      iconAnimationController?.animateTo(1,
          duration: const Duration(milliseconds: 250));
    }

    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: ExactAssetImage("assets/images/userImage.png"),
              fit: BoxFit.cover)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black, Colors.transparent])),
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                height: AppBar().preferredSize.height,
                child: Material(
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.white,
                            size: 32,
                          )),
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "取什么歌名好呢",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          Text(
                            "Caico",
                            style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w300),
                          )
                        ],
                      )),
                      GestureDetector(
                          child: const Icon(
                            Icons.ios_share,
                            color: Colors.white,
                            size: 32,
                          ))
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
                child: Center(
              child: Hero(
                tag: "poster",
                child: RotationTransition(
                  turns: rotationAnimation!,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(120)),
                      child: Image.asset("assets/images/userImage.png"),
                    ),
                  ),
                ),
              ),
            )),
            Padding(
              padding: EdgeInsets.only(
                  bottom: 8 + MediaQuery.of(context).padding.bottom),
              child: SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isPause = !isPause;
                          });
                        },
                        child: Center(
                          child: AnimatedIcon(
                            progress: iconAnimationController!,
                            icon: AnimatedIcons.play_pause,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
