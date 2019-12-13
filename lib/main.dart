import 'package:flutter/material.dart';

import 'package:chatarrera_flutter/tabs/salidas/salidas.dart';
import 'package:chatarrera_flutter/tabs/materiales/materiales.dart';
import 'package:chatarrera_flutter/tabs/entradas/entradas.dart';

void main() {
  runApp(MaterialApp(
      // Title
      title: "Using Tabs",
      // Home
      home: MyHome()));
}

class MyHome extends StatefulWidget {
  @override
  MyHomeState createState() => MyHomeState();
}

class MyHomeState extends State<MyHome> {

  int currentIndex = 0;
  final List<Widget> children = [MaterialesWidget(), EntradasWidget(), SalidasWidget()];

  final pageController = PageController();
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Using Tabs"),
        backgroundColor: Colors.grey,
      ),
      body: PageView(
        children: this.children,
        controller: this.pageController,
        onPageChanged: this.onPageChanged,
      ),
      bottomNavigationBar: getNavBar(),
    );
  }  

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void onTabTapped(int index) {
    pageController.jumpToPage(index);
  }

  BottomNavigationBar getNavBar() {
    return BottomNavigationBar(
      onTap: onTabTapped, //manda a llamar funcion
      currentIndex: currentIndex,
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.work),
            title: new Text('Materiales')),
        BottomNavigationBarItem(
            icon: Icon(Icons.trending_down),
            title: new Text('Entradas')),
        BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            title: new Text('Salidas')),
      ],
    );
  }

}
