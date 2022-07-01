import 'package:flutter/material.dart';
import 'package:flutter_ig_clone/src/routes/app_route.dart';

import 'page_view/page_view_favourite.dart';
import 'page_view/page_view_home.dart';
import 'page_view/page_view_seacrh.dart';
import 'page_view/page_view_sub.dart';
import 'page_view/page_view_user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void pageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void bottomTapped(int index) {
    setState(() {
      _selectedIndex = index;
      pageController.animateToPage(index,
          duration: const Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  Widget buildPageView() {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: const <Widget>[
        PageViewHome(),
        PageViewSearch(),
        PageViewSub(),
        PageViewFavourite(),
        PageViewUser()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: const Text("Instagram Clone"),
        actions: [
          IconButton(
              onPressed: () =>
                  {Navigator.pushNamed(context, AppRoute.pickerImage)},
              icon: const Icon(Icons.add_circle_outline)),
          IconButton(onPressed: () => {}, icon: const Icon(Icons.messenger))
        ],
      ),
      backgroundColor: Colors.white,
      body: buildPageView(),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: _selectedIndex,
          onTap: bottomTapped,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "search"),
            BottomNavigationBarItem(
                icon: Icon(Icons.video_library_outlined), label: "video"),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border), label: "favourite"),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle), label: "account")
          ]),
    );
  }
}
