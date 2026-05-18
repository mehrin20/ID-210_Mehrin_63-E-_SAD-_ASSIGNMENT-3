import 'package:flutter/material.dart';
import 'package:flutter_mehrin_2/weather_page.dart';
import 'package:flutter_mehrin_2/cities_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade100,
      appBar: AppBar(
        title: Text("Homepage"),
        backgroundColor: Colors.pink.shade200,
        foregroundColor: Colors.pink.shade900,
        actions: [
          IconButton(
            onPressed: () async {
              await Supabase.instance.client.auth.signOut();
            },
            icon: Icon(Icons.logout),
          ), //IconButton
        ],
      ), //AppBar

      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Weather  App",
                  style: TextStyle(
                    color: Colors.pink.shade700,
                    fontSize: 100,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ), //Padding

            Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Check your weather ",
                  style: TextStyle(color: Colors.pink.shade800, fontSize: 40),
                ),
              ),
            ), //Padding

            Padding(
              padding: const EdgeInsets.all(30),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return WeatherPage();
                      },
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink.shade400,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(70),
                    side: BorderSide(color: Colors.pink.shade900, width: 5),
                  ),
                ),
                child: Text(
                  "Check Weather",
                  style: TextStyle(color: Colors.pink.shade100, fontSize: 20),
                ),
              ), //ElevatedButton
            ), //Padding

            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SavedCitiesPage();
                      },
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink.shade400,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(70),
                    side: BorderSide(color: Colors.pink.shade900, width: 5),
                  ),
                ),
                child: Text(
                  "Saved Cities",
                  style: TextStyle(color: Colors.pink.shade100, fontSize: 20),
                ),
              ), //ElevatedButton
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
                  "Weather Portal",
                  style: TextStyle(
                    color: Colors.pink.shade50,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ), //Text
              ),
            ), //Container

            Container(
              width: 800,
              height: 100,
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.pink.shade400,
                border: Border.all(color: Colors.pink.shade900, width: 5),
                borderRadius: BorderRadius.all(Radius.circular(70)),
              ),
              child: Center(
                child: Text(
                  "Search Any City ",
                  style: TextStyle(
                    color: Colors.pink.shade50,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ), //Text
              ),
            ), //Container

            Container(
              width: 800,
              height: 100,
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.pink.shade400,
                border: Border.all(color: Colors.pink.shade900, width: 5),
                borderRadius: BorderRadius.all(Radius.circular(200)),
              ),
              child: Center(
                child: Text(
                  "Save Favourite Cities ",
                  style: TextStyle(
                    color: Colors.pink.shade50,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ), //Text
              ),
            ), //Container
          ],
        ), //Column
      ), //SingleChildScrollView

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink.shade900,
        foregroundColor: Colors.pink.shade100,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return WeatherPage();
              },
            ),
          );
        },
        child: Icon(Icons.search),
      ), //FloatingActionButton

      endDrawer: NavigationDrawer(
        backgroundColor: Colors.pink.shade50,
        children: [
          ListTile(
            leading: Icon(Icons.home, color: Colors.pink.shade900),
            title: Text("Home"),
            onTap: () {},
          ), //ListTile
          ListTile(
            leading: Icon(Icons.cloud, color: Colors.pink.shade900),
            title: Text("Check Weather"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return WeatherPage();
                  },
                ),
              );
            },
          ), //ListTile
          ListTile(
            leading: Icon(Icons.bookmark, color: Colors.pink.shade900),
            title: Text("Saved Cities"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SavedCitiesPage();
                  },
                ),
              );
            },
          ), //ListTile
          ListTile(
            leading: Icon(Icons.logout, color: Colors.pink.shade900),
            title: Text("Logout"),
            onTap: () async {
              await Supabase.instance.client.auth.signOut();
            },
          ), //ListTile
        ],
      ), //NavigationDrawer
    ); //Scaffold
  }
}
