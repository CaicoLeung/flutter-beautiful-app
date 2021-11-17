import 'package:flutter/cupertino.dart' hide Router;
import 'package:flutter/material.dart' hide Router, Navigator;

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  static const _decoration = BoxDecoration(color: Colors.white);

  Widget _buildAppBar(BuildContext context, String title) {
    final _decoration = BoxDecoration(color: Colors.blue[500]);
    const _whiteColor = Color(0xffffffff);

    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).padding.top,
          decoration: _decoration,
        ),
        Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: _decoration,
          child: Row(
            children: [
               CupertinoButton(
                child: const Icon(Icons.arrow_back, color: _whiteColor,),
                onPressed: () => Navigator.pop(context),
              ),
              Expanded(
                  child: Text(
                title,
                style: const TextStyle(color: _whiteColor),
              )),
              const CupertinoButton(
                onPressed: null,
                child: Icon(Icons.search, color: _whiteColor,),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _decoration,
      child: Column(
        children: [_buildAppBar(context, "详情页")],
      ),
    );
  }
}
