import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_bar.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/constants.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../constants/fonts.dart';
import 'friend_requests_tab_widget.dart';
import 'friends_tab_widget.dart';

class FriendsPage extends StatefulWidget {
  const FriendsPage({Key? key}) : super(key: key);

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage>
    with SingleTickerProviderStateMixin {
  // Controllers
  late final TabController _tabController;

  // Variables
  int _tabIndex = 0;

  @override
  void initState() {
    super.initState();

    _tabController =
        TabController(initialIndex: _tabIndex, length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.index != _tabIndex) {
        setState(() {
          _tabIndex = _tabController.index;
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SchejAppBar(titleString: 'Friends', isRoot: true),
      floatingActionButton: FloatingActionButton(
        backgroundColor: SchejColors.darkGreen,
        onPressed: () {},
        child: const Icon(MdiIcons.accountPlus),
      ),
      body: Container(
        color: SchejColors.white,
        child: Column(
          children: [
            Padding(
              padding: SchejConstants.pagePadding.copyWith(bottom: 32),
              child: _buildTabBar(),
            ),
            Expanded(child: _buildTabBarView()),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      height: 42,
      decoration: BoxDecoration(
        color: SchejColors.white,
        borderRadius: SchejConstants.borderRadius,
        border: Border.all(
          color: SchejColors.lightGray,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: SchejColors.pureBlack.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          borderRadius: SchejConstants.borderRadius,
          color: SchejColors.green,
        ),
        labelColor: SchejColors.white,
        labelStyle: SchejFonts.body,
        unselectedLabelColor: SchejColors.pureBlack,
        unselectedLabelStyle: SchejFonts.body,
        tabs: [
          _buildTab(
            name: 'Friends',
            // badgeCount: 4,
            active: _tabIndex == 0,
          ),
          _buildTab(
            name: 'Requests',
            badgeCount: 3,
            active: _tabIndex == 1,
          ),
          // _buildTab(
          //   name: 'Groups',
          //   // badgeCount: 1,
          //   active: _tabIndex == 2,
          // ),
        ],
      ),
    );
  }

  Widget _buildTab(
      {required String name, int badgeCount = 0, bool active = false}) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(name),
          if (badgeCount > 0)
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.only(left: 4),
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: active ? SchejColors.white : SchejColors.fadedGreen,
              ),
              child: Center(
                child: AnimatedDefaultTextStyle(
                  style: SchejFonts.small.copyWith(
                    color: active ? SchejColors.green : SchejColors.pureBlack,
                    height: null,
                  ),
                  duration: const Duration(milliseconds: 300),
                  child: Text(
                    badgeCount.toString(),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTabBarView() {
    return TabBarView(
      controller: _tabController,
      children: const [
        FriendsTabWidget(),
        FriendRequestsTabWidget(),
      ],
    );
  }
}