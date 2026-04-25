import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade100,
      appBar: AppBar(
        title: Text("Home "), //Text
        backgroundColor: Colors.pink.shade200,
        foregroundColor: Colors.pink.shade100,
        // leading: Icon(Icons.home, color: Colors.amber),
        // actions: [
        //   IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
        //   IconButton(onPressed: () {}, icon: Icon(Icons.person)),
        // ],
      ), //AppBar
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Leading  University ",
                  style: TextStyle(
                    color: Colors.pink.shade700,
                    fontSize: 90,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ), //Padding
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  "Batch - 63",
                  style: TextStyle(color: Colors.pink.shade800, fontSize: 70),
                ),
              ),
            ), //Padding
            Container(
              width: 800,
              height: 100,
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.pink.shade300,
                border: Border.all(color: Colors.pink.shade900, width: 5),
                borderRadius: BorderRadius.all(Radius.circular(70)),
              ),
              child: Center(
                child: Text(
                  "Student Portal ",
                  style: TextStyle(
                    color: Colors.pink.shade50,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ), //Text
              ),
            ), //Container
            Container(
              width: 800,
              height: 80,
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(30),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.pink.shade400,
                border: Border.all(color: Colors.pink.shade900, width: 5),
                borderRadius: BorderRadius.all(Radius.circular(70)),
              ),
              child: Center(
                child: Text(
                  "Sections",
                  style: TextStyle(
                    color: Colors.pink.shade50,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ), //Text
              ),
            ), //Container
            Container(
              width: 800,
              height: 80,
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(30),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.pink.shade400,
                border: Border.all(color: Colors.pink.shade900, width: 5),
                borderRadius: BorderRadius.all(Radius.circular(200)),
              ),
              child: Center(
                child: Text(
                  "Students List",
                  style: TextStyle(
                    color: Colors.pink.shade50,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ), //Text
              ),
            ), //Container
            SizedBox(
              height: 200,
              width: 600,

              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: Colors.pink.shade900, width: 5),
                ),
                color: Colors.pink.shade300,
                child: Center(
                  child: Image.asset(
                    "assets/images/flutter.png",
                    height: 200,
                    width: 180,
                  ),
                ),
              ), //Card
            ), //SizeBox
          ],
        ), //Column
      ),
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
            leading: Icon(Icons.home, color: Colors.pink.shade900),
            title: Text("HomePage"),
            onTap: () {},
          ), //ListTile
          ListTile(
            leading: Icon(Icons.settings, color: Colors.pink.shade900),
            title: Text("Settings"),
            onTap: () {},
          ), //ListTile
          ListTile(
            leading: Icon(Icons.person, color: Colors.pink.shade900),
            title: Text("Profile"),
            onTap: () {},
          ), //ListTile
        ],
      ), //NavigationDrawer
    ); //Scaffold
  }
}
