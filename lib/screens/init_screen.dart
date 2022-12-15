import 'package:anda_chill/screens/maps_screen.dart';
import 'package:anda_chill/screens/screens.dart';
import 'package:flutter/material.dart';

class initScreen extends StatefulWidget {
  const initScreen({super.key});

  @override
  State<initScreen> createState() => _initScreenState();
}

class _initScreenState extends State<initScreen> {
  int selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    LoginScreen(),
    HomeScreen(),
    MapsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (value) => {
          setState(() {
            selectedIndex = value;
          })
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Posts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Mapas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
        ],
      ),
    );
  }
}
