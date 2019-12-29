import 'package:chatarrera_flutter/services/firestore_materiales.dart';
import 'package:flutter/material.dart';

import 'package:chatarrera_flutter/tabs/salidas/salidas.dart';
import 'package:chatarrera_flutter/tabs/materiales/materiales.dart';
import 'package:chatarrera_flutter/tabs/entradas/entradas.dart';

void main() {
  runApp(
    MaterialApp(
      title: "Chatarrera app",
      home: MyHome(),
      // TODO: Definir colores propios
      theme: ThemeData.dark().copyWith(),
    ),
  );
}

class MyHome extends StatefulWidget {
  @override
  MyHomeState createState() => MyHomeState();
}

class MyHomeState extends State<MyHome> {
  int currentIndex = 0;

  final List<Widget> children = [
    MaterialesWidget(),
    EntradasWidget(),
    SalidasWidget()
  ];

  final pageController = PageController();

  @override
  void initState() {
    FirestoreMateriales.obtenerMateriales().then((_) => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (FirestoreMateriales.materiales != null) {
      return Scaffold(
        body: PageView(
          children: this.children,
          controller: this.pageController,
          onPageChanged: this.onPageChanged,
        ),
        bottomNavigationBar: getNavBar(),
      );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
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
          title: new Text('Materiales'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.trending_down),
          title: new Text('Entradas'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.trending_up),
          title: new Text('Salidas'),
        ),
      ],
    );
  }
}
