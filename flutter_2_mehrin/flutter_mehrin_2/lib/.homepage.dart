import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        title: Text("Home 🌸"), //Text
        backgroundColor: Colors.pink.shade200,
        foregroundColor: Colors.pink.shade100,
        // leading: Icon(Icons.home, color: Colors.amber),
        // actions: [
        //   IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
        //   IconButton(onPressed: () {}, icon: Icon(Icons.person)),
        // ],
      ), //AppBar
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              "Leading  University ",
              style: TextStyle(color: Colors.pink.shade700, fontSize: 90),
            ),
          ), //Padding
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Batch - 63",
              style: TextStyle(color: Colors.pink.shade800, fontSize: 70),
            ),
          ), //Padding

          Container(
            width: 800,
            height: 100,
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.all(30),
            decoration: BoxDecoration(color: Colors.pink.shade200),
            child: Text(
              "Student Portal                             >",
              style: TextStyle(color: Colors.pink.shade50, fontSize: 50),
            ), //Text
          ), //Container
          Container(
            width: 800,
            height: 70,
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.all(30),
            decoration: BoxDecoration(color: Colors.pink.shade400),
            child: Text(
              "Sections",
              style: TextStyle(color: Colors.pink.shade50, fontSize: 25),
            ), //Text
          ), //Container
          Container(
            width: 800,
            height: 70,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(30),
            decoration: BoxDecoration(color: Colors.pink.shade400),
            child: Text(
              "Students List",
              style: TextStyle(color: Colors.pink.shade50, fontSize: 25),
            ), //Text
          ), //Container
        ],
      ), //Column
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink.shade900,
        foregroundColor: Colors.pink.shade100,
        onPressed: () {},
        child: Icon(Icons.admin_panel_settings_sharp),
      ), //FloatingActionButton
      endDrawer: NavigationDrawer(
        backgroundColor: Colors.pink.shade50,
        children: [
          ListTile(
            //ListTile
            leading: Icon(Icons.home, color: Colors.pink.shade900),
            title: Text("HomePage"),
            onTap: () {},
          ), //ListTile
          ListTile(
            //ListTile
            leading: Icon(Icons.settings, color: Colors.pink.shade900),
            title: Text("Settings"),
            onTap: () {},
          ), //ListTile
          ListTile(
            //ListTile
            leading: Icon(Icons.person, color: Colors.pink.shade900),
            title: Text("Profile"),
            onTap: () {},
          ), //ListTile
        ],
      ), //NavigationDrawer
    ); //Scaffold
  }
}
