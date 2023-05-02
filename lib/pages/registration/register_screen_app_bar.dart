import 'package:flutter/material.dart';

class RegisterScreenAppBar extends StatelessWidget {
  final TabController? _tabController;

  final color = const Color(0xffFE0000);

  RegisterScreenAppBar(this._tabController);

  @override
  Widget build(BuildContext context) {

    return SliverAppBar(
      backgroundColor: Colors.grey,
      expandedHeight: 96, // set the height of the SliverAppBar
      flexibleSpace: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                color: color,
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(30, 10, 0, 0),
                  child: Text(
                    "Social",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: AppBar(
                backgroundColor: color,
                brightness: Brightness.dark,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(30),
                  ),
                ),
                bottom: TabBar(
                  controller: _tabController,
                  // give the indicator a decoration (color and border radius)
                  indicator: const UnderlineTabIndicator(
                    borderSide: BorderSide(color: Colors.white, width: 4.0),
                    insets: EdgeInsets.symmetric(horizontal: 20.0),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white,
                  tabs: const [
                    // first tab [you can add an icon using the icon property]
                    Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "LOGIN",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    // second tab [you can add an icon using the icon property]
                    Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "SIGN UP",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }
}
