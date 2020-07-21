import 'package:flutter/material.dart';
import 'package:christianBooks/Utils/dialogs.dart';
import 'package:christianBooks/Screens/Store/explore.dart';
import 'package:christianBooks/Screens/Home/index.dart';
import 'package:christianBooks/Screens/More/more.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:christianBooks/Screens/Middle/index.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController _pageController;
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Dialogs().showExitDialog(context),
      child: Scaffold(
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: onPageChanged,
          children: <Widget>[
            Home(),
            Explore(),
            Middle(),
            Profile(),
            Profile()
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).primaryColor,
          selectedItemColor: Theme.of(context).accentColor,
          unselectedItemColor: Colors.grey[500],
          elevation: 20,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Feather.home,
              ),
              title: Text(
                'Home',
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Feather.book,
              ),
              title: Text(
                'Library',
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Feather.minus_circle,
              ),
              title: Text(
                '',
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Feather.shopping_cart,
              ),
              title: Text(
                'Store',
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Feather.menu,
              ),
              title: Text(
                'More',
              ),
            ),
          ],
          onTap: navigationTapped,
          currentIndex: _page,
        ),
      ),
    );
  }

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }
}
