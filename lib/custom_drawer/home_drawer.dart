import 'package:flutter/material.dart';
import 'package:startup_namer/custom_drawer/helper.dart';
import '../app_theme.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer(
      {Key? key,
      this.iconAnimationController,
      this.screenIndex,
      this.callBackIndex})
      : super(key: key);

  final AnimationController? iconAnimationController;
  final DrawerIndex? screenIndex;
  final Function(DrawerIndex)? callBackIndex;

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  List<DrawerList>? drawerList;

  @override
  void initState() {
    setDrawerListArray();
    super.initState();
  }

  void setDrawerListArray() {
    drawerList = <DrawerList>[
      DrawerList(
          index: DrawerIndex.home,
          labelName: "Home",
          icon: const Icon(Icons.home)),
      DrawerList(
          index: DrawerIndex.help,
          labelName: "Help",
          isAssetsImage: true,
          imageName: "assets/images/supportIcon.png"),
      DrawerList(
          index: DrawerIndex.feedBack,
          labelName: "FeedBack",
          icon: const Icon(Icons.help)),
      DrawerList(
          index: DrawerIndex.invite,
          labelName: "Invite Friend",
          icon: const Icon(Icons.group)),
      DrawerList(
          index: DrawerIndex.share,
          labelName: "Rate the app",
          icon: const Icon(Icons.share)),
      DrawerList(
          index: DrawerIndex.about,
          labelName: "About Us",
          icon: const Icon(Icons.info)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.notWhite.withOpacity(0.5),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 40),
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AnimatedBuilder(
                      animation: widget.iconAnimationController!,
                      builder: (context, child) {
                        return ScaleTransition(
                          scale: AlwaysStoppedAnimation<double>(1 -
                              (widget.iconAnimationController!.value * 0.2)),
                          child: RotationTransition(
                            turns: AlwaysStoppedAnimation<double>(Tween<double>(
                                        begin: 0.0, end: 24.0)
                                    .animate(CurvedAnimation(
                                        parent: widget.iconAnimationController!,
                                        curve: Curves.fastOutSlowIn))
                                    .value /
                                360),
                            child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                        color: AppTheme.grey.withOpacity(0.6),
                                        offset: const Offset(2, 4),
                                        blurRadius: 8)
                                  ]),
                              child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(60)),
                                child:
                                    Image.asset("assets/images/userImage.png"),
                              ),
                            ),
                          ),
                        );
                      }),
                  const Padding(
                    padding: EdgeInsets.only(top: 8, left: 4),
                    child: Text(
                      "Caico Leung",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppTheme.grey,
                          fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Divider(
            height: 1,
            color: AppTheme.grey.withOpacity(0.6),
          ),
          Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(0),
                itemCount: drawerList?.length,
                itemBuilder: (context, index) => inkwell(drawerList![index]),
              )),
          Divider(height: 1,color: AppTheme.grey.withOpacity(0.6),)
        ],
      ),
    );
  }

  void navigationtoScreen(DrawerIndex indexScreen) {
     widget.callBackIndex!(indexScreen);
  }

  Widget inkwell(DrawerList listDate) {
    final color = widget.screenIndex == listDate.index ? Colors.blue : AppTheme.nearlyBlack;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.grey.withOpacity(0.1),
        highlightColor: Colors.transparent,
        onTap: () => navigationtoScreen(listDate.index ?? DrawerIndex.home),
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Row(
                children: [
                  const SizedBox(
                    width: 6,
                    height: 46,
                  ),
                  const Padding(padding: EdgeInsets.all(4)),
                  listDate.isAssetsImage ? SizedBox(
                    width: 24,
                    height: 24,
                    child: Image.asset(listDate.imageName, color: color,),
                  ) : Icon(listDate.icon?.icon, color: color,),
                  const Padding(padding: EdgeInsets.all(4)),
                  Text(
                    listDate.labelName,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: color),
                    textAlign: TextAlign.left,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
