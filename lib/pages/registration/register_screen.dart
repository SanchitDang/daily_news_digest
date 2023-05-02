import 'package:daily_news_digest/pages/registration/register_screen_app_bar.dart';
import 'package:daily_news_digest/pages/registration/signup.dart';
import 'package:flutter/material.dart';
import 'login.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {

  final color = const Color(0xffFE0000);

  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
            headerSliverBuilder: (context, value) {
              return [
                SliverOverlapAbsorber(
                  handle:
                  NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: RegisterScreenAppBar(_tabController),
                )
              ];
            },
            body: TabBarView(
              controller: _tabController,
              children: [SigninForm(tabController: _tabController,), SignupForm(tabController: _tabController,)],
            ),
        ),
      ),
    );
  }
}
