import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:notes/pages/taskpage.dart';
import 'package:notes/pages/homepage.dart';

class DotNav extends StatefulWidget {
  const DotNav({Key? key}) : super(key: key);

  @override
  State<DotNav> createState() => _DotNavState();
}

class _DotNavState extends State<DotNav> {
  int _selectedIndex = 0; // Cambiado a 0 para que comience en la página "Home"
  final List<Widget> _widgetOptions = [
    HomePage(), // Agrega tus páginas aquí
    TaskPage(), // Agrega tus páginas aquí
    // Agrega más páginas si es necesario
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white70,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              mainAxisAlignment: MainAxisAlignment.center, // Centra los botones horizontalmente
              tabs: const [
                GButton(
                  icon: Icons.notes_outlined,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.task_alt_outlined,
                  text: 'Task',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
