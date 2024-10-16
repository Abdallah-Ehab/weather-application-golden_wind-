import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        width: double.infinity,
        height: 50,
        color: Colors.amber,
      ),
      bottomNavigationBar: BottomNavigationBar(showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        fixedColor: Colors.transparent,
        type: BottomNavigationBarType.fixed,
        currentIndex: 0, // Set the current active index
        // selectedItemColor: Colors.black, // Color for the selected icon
        unselectedItemColor: Colors.black, // Color for the unselected icons
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home", // Added labels for accessibility
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_city),
            label: "Cities",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],),
    );
  }
}