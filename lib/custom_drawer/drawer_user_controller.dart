import 'package:flutter/material.dart';
import 'package:startup_namer/app_theme.dart';
import 'package:startup_namer/custom_drawer/home_drawer.dart';

import 'helper.dart';

class DrawerUserController extends StatefulWidget {
  const DrawerUserController({
    Key? key,
    this.drawerWidth = 250,
    this.screenIndex,
    this.onDrawerCall,
    this.screenView,
    this.menuView,
    this.animatedIconData = AnimatedIcons.arrow_menu,
    this.onDrawerOpen,
  }) : super(key: key);

  final double drawerWidth;
  final DrawerIndex? screenIndex;
  final Function(DrawerIndex)? onDrawerCall;
  final Function(bool)? onDrawerOpen;
  final Widget? screenView;
  final Widget? menuView;
  final AnimatedIconData? animatedIconData;

  @override
  _DrawerUserControllerState createState() => _DrawerUserControllerState();
}

class _DrawerUserControllerState extends State<DrawerUserController>
    with TickerProviderStateMixin {
  ScrollController? scrollController;
  AnimationController? iconAnimationController;
  AnimationController? animationController;
  double scrolloffset = 0;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
    iconAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 0));
    iconAnimationController?.animateTo(1,
        duration: const Duration(milliseconds: 0), curve: Curves.fastOutSlowIn);
    scrollController =
        ScrollController(initialScrollOffset: widget.drawerWidth);
    scrollController?.addListener(() {
      if (scrollController!.offset <= 0) {
        // 抽屉完全打开
        if (scrolloffset != 1) {
          setState(() {
            scrolloffset = 1;
            if (widget.onDrawerOpen != null) {
              widget.onDrawerOpen!(true);
            }
          });
        }
        iconAnimationController?.animateTo(0,
            duration: const Duration(milliseconds: 0),
            curve: Curves.fastOutSlowIn);
      } else if (scrollController!.offset > 0 &&
          scrollController!.offset < widget.drawerWidth) {
        // 抽屉正在关闭
        iconAnimationController?.animateTo(
            (scrollController!.offset * 100 / widget.drawerWidth) / 100,
            duration: const Duration(milliseconds: 0),
            curve: Curves.fastOutSlowIn);
      } else {
        // 抽屉完全关闭
        if (scrolloffset != 0) {
          setState(() {
            scrolloffset = 0;
            if (widget.onDrawerOpen != null) {
              widget.onDrawerOpen!(false);
            }
          });
        }
        iconAnimationController?.animateTo(1,
            duration: const Duration(milliseconds: 0),
            curve: Curves.fastOutSlowIn);
      }
    });
    // 这个方法在一帧的最后调用，并且只调用一次,使用这个方法就可以在判断渲染完成，并获取到元素的大小。
    WidgetsBinding.instance?.addPostFrameCallback((_) => getInitState());
    super.initState();
  }

  bool getInitState() {
    scrollController?.jumpTo(widget.drawerWidth);
    return true;
  }

  void onDrawerClick() {
    if (scrollController!.offset != 0) {
      scrollController?.animateTo(0,
          duration: const Duration(milliseconds: 400),
          curve: Curves.fastOutSlowIn);
    } else {
      scrollController?.animateTo(widget.drawerWidth,
          duration: const Duration(milliseconds: 400),
          curve: Curves.fastOutSlowIn);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _contextWidth = MediaQuery.of(context).size.width;
    final _contextHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppTheme.white,
      body: SingleChildScrollView(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        physics: const PageScrollPhysics(parent: ClampingScrollPhysics()),
        child: SizedBox(
          width: _contextWidth + widget.drawerWidth,
          height: _contextHeight,
          child: Row(
            children: [
              SizedBox(
                width: widget.drawerWidth,
                height: _contextHeight,
                child: AnimatedBuilder(
                  animation: iconAnimationController!,
                  builder: (context, child) {
                    return Transform(
                      transform: Matrix4.translationValues(
                          scrollController?.offset ?? 0, 0, 0),
                      child: HomeDrawer(
                        screenIndex: widget.screenIndex ?? DrawerIndex.home,
                        iconAnimationController: iconAnimationController,
                        callBackIndex: (index) {
                          onDrawerClick();
                          if (widget.onDrawerCall != null) {
                            widget.onDrawerCall!(index);
                          }
                        },
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                width: _contextWidth,
                height: _contextHeight,
                child: Container(
                  decoration: BoxDecoration(color: AppTheme.white, boxShadow: [
                    BoxShadow(
                        color: AppTheme.grey.withOpacity(0.6), blurRadius: 24)
                  ]),
                  child: Stack(
                    children: <Widget>[
                      // scrolloffset == 1表示抽屉已关闭, 只允许在childt上touch交互
                      IgnorePointer(
                        ignoring: scrolloffset == 1,
                        child: widget.screenView,
                      ),
                      if (scrolloffset == 1)
                        (InkWell(
                          onTap: onDrawerClick,
                        )),
                      Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).padding.top + 8,
                            left: 8),
                        child: SizedBox(
                          width: AppBar().preferredSize.height - 8,
                          height: AppBar().preferredSize.height - 8,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(
                                  AppBar().preferredSize.height),
                              child: Center(
                                child: widget.menuView ?? AnimatedIcon(
                                        icon: widget.animatedIconData ??
                                            AnimatedIcons.arrow_menu,
                                        progress: iconAnimationController!),
                              ),
                              onTap: () {
                                FocusScope.of(context).requestFocus(FocusNode());
                                onDrawerClick();
                              },
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
      ),
    );
  }
}
