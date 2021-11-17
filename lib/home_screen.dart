import 'package:flutter/material.dart';
import 'package:startup_namer/model/home_list.dart';
import 'app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  List<HomeList> homeList = HomeList.homeList;
  AnimationController? animationController;
  final double _appBarHeight = AppBar().preferredSize.height;
  final _containerSize = AppBar().preferredSize.height - 8;
  bool multiple = true;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  Future<bool> getData() async {
    await Future.delayed(Duration.zero);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        backgroundColor: AppTheme.white,
        body: FutureBuilder<bool>(
          future: getData(),
          builder: (context, snapshot) {
            return Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAppBar(),
                  if (!snapshot.hasData)
                    const SizedBox()
                  else
                    Expanded(
                      child: FutureBuilder<bool>(
                        future: getData(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const SizedBox();
                          }
                          return GridView(
                            padding: EdgeInsets.only(
                                left: 12,
                                right: 12,
                                bottom: MediaQuery.of(context).padding.bottom),
                            physics: const BouncingScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: multiple ? 2 : 1,
                                    mainAxisSpacing: 12,
                                    crossAxisSpacing: 12,
                                    childAspectRatio: 1.5),
                            children: List.generate(homeList.length, (index) {
                              final int count = homeList.length;
                              final Animation<double> animation =
                                  Tween<double>(begin: 0, end: 1).animate(
                                      CurvedAnimation(
                                          parent: animationController!,
                                          curve: Interval(
                                              (1 / count) * index, 1,
                                              curve: Curves.fastOutSlowIn)));
                              animationController?.forward();
                              return HomeListView(
                                animation: animation,
                                animationController: animationController,
                                listData: homeList[index],
                                callback: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              homeList[index].navigateScreen!));
                                },
                              );
                            }),
                          );
                        },
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return SizedBox(
      height: AppBar().preferredSize.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 8),
            child: SizedBox(
              width: _containerSize,
              height: _containerSize,
            ),
          ),
          const Expanded(
              child: Center(
            child: Padding(
              padding: EdgeInsets.only(top: 4),
              child: Text(
                "Flutter Ui",
                style: TextStyle(
                    fontSize: 22,
                    color: AppTheme.darkerText,
                    fontWeight: FontWeight.w700),
              ),
            ),
          )),
          Padding(
            padding: const EdgeInsets.only(top: 8, right: 8),
            child: Container(
              width: _containerSize,
              height: _containerSize,
              color: Colors.white,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(_appBarHeight),
                  child: Icon(
                    multiple ? Icons.dashboard : Icons.view_agenda,
                    color: AppTheme.darkGrey,
                  ),
                  onTap: () {
                    setState(() {
                      multiple = !multiple;
                      animationController!.reset();
                    });
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class HomeListView extends StatelessWidget {
  const HomeListView(
      {Key? key,
      this.listData,
      this.callback,
      this.animationController,
      this.animation})
      : super(key: key);

  final HomeList? listData;
  final VoidCallback? callback;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animationController!,
        builder: (context, child) {
          return FadeTransition(
            opacity: animation!,
            child: Transform(
              transform:
                  Matrix4.translationValues(0, 50 * (1 - animation!.value), 0),
              child: AspectRatio(
                aspectRatio: 1.5,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: <Widget>[
                      Positioned.fill(
                          child: Image.asset(
                        listData!.imagePath,
                        fit: BoxFit.cover,
                      )),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Colors.grey.withOpacity(0.2),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4)),
                          onTap: callback,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
