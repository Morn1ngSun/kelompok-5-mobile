import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  final int initialIndex;

  const BottomNavigation({Key? key, required this.initialIndex})
      : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;
  bool home = false;
  bool add = false;
  bool hist = false;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        Navigator.pushNamed(context, '/dashboard');
      } else if (index == 1) {
        Navigator.pushNamed(context, '/product');
      } else if (index == 2) {
        Navigator.pushNamed(context, '/hist');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print(_selectedIndex);
    if (_selectedIndex == 0) {
      home = true;
      add = false;
      hist = false;
    } else if (_selectedIndex != 0) {
      home = false;
    }
    if (_selectedIndex == 1) {
      add = true;
      home = false;
      hist = false;
    } else if (_selectedIndex != 1) {
      add = false;
    }
    if (_selectedIndex == 2) {
      hist = true;
      home = false;
      add = false;
    } else if (_selectedIndex != 2) {
      hist = false;
    }
    return Container(
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 0.5,
            blurRadius: 2,
          ),
        ],
      ),
      child: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(home ? Icons.home : Icons.home_outlined), label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                add ? Icons.add_circle : Icons.add_circle_outline,
                // Icons.add_circle
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: hist
                  ? Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20)),
                      child: Icon(
                        Icons.history,
                        color: Colors.white,
                        size: 18,
                      ),
                    )
                  : Icon(
                      Icons.history,
                      // size: 8,
                    ),
              // Icon(
              //   hist ? Icons.history : Icons.history,
              // ),
              label: ''),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        // selectedIconTheme: IconThemeData(size: 28),
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 0),
        unselectedItemColor: Colors.black,
        unselectedFontSize: 0,
        onTap: _onItemTapped,
      ),
    );
  }
}
