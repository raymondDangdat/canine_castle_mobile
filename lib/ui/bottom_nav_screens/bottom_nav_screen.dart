import 'package:canine_castle_mobile/ui/bottom_nav_screens/profile/pet_breeder/pet_breeder_screen.dart';
import 'package:canine_castle_mobile/ui/bottom_nav_screens/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../resources/constants/font_constants.dart';
import '../../resources/constants/image_constant.dart';
import '../../resources/styles_manager.dart';
import 'home/home_screen.dart';
import 'inbox/inbox_screen.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    SearchScreen(),
    InboxScreen(),
    PetBreederScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        selectedFontSize: 12,
        enableFeedback: false,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        unselectedLabelStyle: getCustomTextStyle(
            fontSize: 12,
            textColor: const Color(0xFF626262),
            fontWeight: mediumFont),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(homeInactiveIcon),
            activeIcon: SvgPicture.asset(homeActiveIcon),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(searchInActiveIcon),
            activeIcon: SvgPicture.asset(searchActiveIcon),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(messagesInActiveIcon),
            activeIcon: SvgPicture.asset(messagesActiveIcon),
            label: 'Inbox',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(profileInActiveIcon),
            activeIcon: SvgPicture.asset(profileActiveIcon),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFFD89B65),
        unselectedItemColor: const Color(0xFF626262),
        onTap: _onItemTapped,
      ),
    );
  }
}
