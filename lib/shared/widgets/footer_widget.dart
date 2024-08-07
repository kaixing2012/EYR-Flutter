import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FooterBar extends StatelessWidget {
  final int selectedItem;
  final Function(int index) onNavBarTapped;

  const FooterBar({
    required this.selectedItem,
    required this.onNavBarTapped,
    super.key,
  });

  List<BottomNavigationBarItem> get _barItems => [
        const BottomNavigationBarItem(
          icon: Icon(Icons.network_check),
          label: 'Network',
          tooltip: '/network',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
          tooltip: '/',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.widgets),
          label: 'Component',
          tooltip: '/component',
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      iconSize: 36,
      backgroundColor: Colors.black,
      showUnselectedLabels: false,
      selectedFontSize: 16,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.blueGrey,
      items: _barItems,
      currentIndex: selectedItem,
      onTap: (index) => onNavBarTapped,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IntProperty('selectedItem', selectedItem))
      ..add(
        ObjectFlagProperty<Function(int index)>.has(
          'onNavBarTapped',
          onNavBarTapped,
        ),
      );
  }
}
