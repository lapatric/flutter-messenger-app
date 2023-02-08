import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messenger_app/pages/calls_page.dart';
import 'package:messenger_app/pages/contacts_page.dart';
import 'package:messenger_app/pages/messages_page.dart';
import 'package:messenger_app/pages/notifications_page.dart';
import 'package:messenger_app/theme.dart';
import 'package:messenger_app/widgets/widgets.dart';

import '../helpers.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final ValueNotifier<int> pageIndex = ValueNotifier(0);
  final ValueNotifier<String> pageTitle = ValueNotifier('Messages');

  final pages = const [
    MessagesPage(),
    NotificationsPage(),
    CallsPage(),
    ContactsPage(),
  ];

  final pageTitles = const [
    'Messages',
    'Notification',
    'Calls',
    'Contacts',
  ];

  void _onNavigationItemSelected(int value) {
    pageTitle.value = pageTitles[value];
    pageIndex.value = value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0, // removes visible shadow even when transparent background
        title: ValueListenableBuilder(
          valueListenable: pageTitle,
          builder: (BuildContext context, String value, _) {
            return Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            );
          },
        ),
        leadingWidth:
            54, // we reduce width of leading a bit to move the icon to the left a bit
        leading: Align(
          // inside the parent (space given to leading), we align it center-right
          alignment: Alignment.centerRight,
          child: IconBackground(
            icon: Icons.search,
            onTap: () {
              debugPrint('TODO search');
            },
          ),
        ),
        actions: [
          // actions are at the complete right in the appBar. It takes a list of items
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: Avatar.small(
                url: Helpers
                    .randomPictureUrl()), // we wrap Avatar in a padding widget to add padding
          ),
        ],
      ),
      body: ValueListenableBuilder(
        // With this ValueListenableBuilder we avoid rebuilding the Scaffold Widget (parent) and the bottomNavigationBar.
        // If we made HomeScreen a stateful widget to use setState(), it would rebuild all widgets!
        valueListenable: pageIndex,
        builder: (BuildContext context, int value, _) {
          return pages[value];
        },
      ),
      bottomNavigationBar: _BottomNavigationBar(
        onItemSelected: _onNavigationItemSelected,
      ), // bottomNavigationBar expects a widget -> good practice to seperate these for performance
    );
  }
}

class _BottomNavigationBar extends StatefulWidget {
  const _BottomNavigationBar({
    super.key,
    required this.onItemSelected,
  });

  final ValueChanged<int> onItemSelected;

  @override
  State<_BottomNavigationBar> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<_BottomNavigationBar> {
  var selectedIndex = 0;

  void handleItemSelected(int index) {
    setState(
      () {
        selectedIndex = index;
      },
    );
    widget.onItemSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // wraps widget in safe area, e.g. avoid cutoff due to notches etc.
      top: false,
      bottom: true,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavigationBarItem(
            index: 0,
            label: 'Messages',
            icon: CupertinoIcons.bubble_left_bubble_right_fill,
            isSelected: (selectedIndex == 0),
            onTap: handleItemSelected,
          ),
          _NavigationBarItem(
            index: 1,
            label: 'Notifications',
            icon: CupertinoIcons.bell_solid,
            isSelected: (selectedIndex == 1),
            onTap: handleItemSelected,
          ),
          _NavigationBarItem(
            index: 2,
            label: 'Calls',
            icon: CupertinoIcons.phone_fill,
            isSelected: (selectedIndex == 2),
            onTap: handleItemSelected,
          ),
          _NavigationBarItem(
            index: 3,
            label: 'Contacts',
            icon: CupertinoIcons.person_2_fill,
            isSelected: (selectedIndex == 3),
            onTap: handleItemSelected,
          ),
        ],
      ),
    );
  }
}

class _NavigationBarItem extends StatelessWidget {
  const _NavigationBarItem(
      {super.key,
      required this.label,
      required this.icon,
      required this.index,
      this.isSelected = false,
      required this.onTap});

  final String label;
  final IconData icon;
  final int index;
  final bool isSelected;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // we wrap SizedBox in GestureDetector in order to make it clickable
      behavior: HitTestBehavior
          .opaque, // makes immediate area around widget clickable too
      onTap: () {
        onTap(index);
      },
      child: SizedBox(
        height: 70,
        child: Column(
          mainAxisSize: MainAxisSize
              .min, // if we do not specify this the column will be the full height of the screen / parent
          children: [
            Icon(icon,
                size: 20, color: isSelected ? AppColors.secondary : null),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                  fontSize: 11,
                  color: isSelected ? AppColors.secondary : null,
                  fontWeight: isSelected ? FontWeight.bold : null),
            ),
          ],
        ),
      ),
    );
  }
}
