import 'package:flutter/material.dart';
import 'package:flutter_back_php/pages/loading.dart';
import 'package:flutter_back_php/pages/welcome.dart';
import 'package:flutter_back_php/pages/profile.dart';
import 'package:flutter_back_php/pages/historique.dart';



class Home extends StatefulWidget {
	const Home({ Key? key }) : super(key: key);

	@override
	State<Home> createState() => _HomeState();
}


class _HomeState extends State<Home> {

  int _current = 0;
  final tabs = [
    Welcome(),
    History(),
    Profile(),
  ];

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: tabs[_current],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _current,
        type: BottomNavigationBarType.fixed,
        iconSize: 25,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
            backgroundColor: Colors.blue,

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: '',
            backgroundColor: Colors.blue,

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
            backgroundColor: Colors.blue,

          ),
        ],
        onTap: (index){
          setState(() {
            _current = index;
          });
        },
      )
		);
	}
}