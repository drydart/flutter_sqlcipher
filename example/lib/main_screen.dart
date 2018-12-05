/* This is free and unencumbered software released into the public domain. */

import 'package:flutter/material.dart';

import 'info_tab.dart';
import 'query_tab.dart';

////////////////////////////////////////////////////////////////////////////////

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainState();
}

////////////////////////////////////////////////////////////////////////////////

class _MainState extends State<MainScreen> {
  final List<Widget> _tabs;
  int _tabIndex = 0;

  _MainState()
    : _tabs = [
        InfoTab(),
        QueryTab(),
      ],
      super();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SQLCipher for Flutter"),
      ),
      body: _tabs[_tabIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: _onTabTapped,
        currentIndex: _tabIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            title: Text("Info"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.query_builder),
            title: Text("Query"),
          ),
        ],
      ),
    );
  }

  void _onTabTapped(final int index) {
    setState(() { _tabIndex = index; });
  }
}
