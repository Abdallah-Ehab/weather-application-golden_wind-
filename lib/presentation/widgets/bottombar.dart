import 'package:flutter/material.dart';

class CustomBottomAppBarItem {
  CustomBottomAppBarItem({required this.icon,required this.activeIcon});
  Icon icon;
  Icon activeIcon;
  String text='';
}

class CustomBottomAppBar extends StatefulWidget {

  const CustomBottomAppBar({super.key, 
    required this.items,
    required this.backgroundColor,
    required this.selectedColor,
    required this.unSelectedColor,
    required this.onTabSelected,
  });

  final List<CustomBottomAppBarItem> items;
  final Color backgroundColor;
  final Color selectedColor;
  final Color unSelectedColor;
  final ValueChanged<int> onTabSelected;

  @override
  State<CustomBottomAppBar> createState() => _CustomBottomAppBarState();
}

class _CustomBottomAppBarState extends State<CustomBottomAppBar> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (index) {
        widget.onTabSelected(index);
        setState(() {
          currentIndex = index;
        });
      },
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        backgroundColor:widget.backgroundColor,
        selectedItemColor: widget.selectedColor,
        unselectedItemColor: widget.unSelectedColor,
        items: widget.items.map(
          (item) => BottomNavigationBarItem(
            icon: item.icon,
            activeIcon: item.activeIcon,
            label: item.text,
          ))
          .toList(),
    );
  }
}


