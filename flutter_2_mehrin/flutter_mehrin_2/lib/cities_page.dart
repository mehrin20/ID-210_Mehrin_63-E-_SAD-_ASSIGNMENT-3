import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SavedCitiesPage extends StatefulWidget {
  const SavedCitiesPage({super.key});

  @override
  State<SavedCitiesPage> createState() {
    return _SavedCitiesPageState();
  }
}

class _SavedCitiesPageState extends State<SavedCitiesPage> {
  final _supabase = Supabase.instance.client;
  List<Map<String, dynamic>> _cities = [];

  @override
  void initState() {
    super.initState();
    _loadCities();
  } //initState

  // READ
  void _loadCities() async {
    final userId = _supabase.auth.currentUser!.id;
    final data = await _supabase
        .from('favorite_cities')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);
    setState(() {
      _cities = List<Map<String, dynamic>>.from(data);
    });
  } //loadCities

  // DELETE
  void _deleteCity(String id, String name) async {
    await _supabase.from('favorite_cities').delete().eq('id', id);
    _loadCities();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('$name removed!')));
  } //deleteCity

  // UPDATE
  void _editCity(String id, String currentName) {
    TextEditingController editController = TextEditingController(
      text: currentName,
    );
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.pink.shade50,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            "Edit City",
            style: TextStyle(
              color: Colors.pink.shade700,
              fontWeight: FontWeight.bold,
            ),
          ), //Text
          content: TextField(
            controller: editController,
            decoration: InputDecoration(
              hintText: 'Enter new city name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ), //TextField
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.pink.shade400),
              ),
            ), //TextButton
            ElevatedButton(
              onPressed: () async {
                String newName = editController.text.trim();
                if (newName.isEmpty) return;
                await _supabase
                    .from('favorite_cities')
                    .update({'city_name': newName})
                    .eq('id', id);
                Navigator.pop(context);
                _loadCities();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink.shade400,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text("Save"),
            ), //ElevatedButton
          ],
        ); //AlertDialog
      },
    );
  } //editCity

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade100,
      appBar: AppBar(
        title: Text("Saved Cities"),
        backgroundColor: Colors.pink.shade200,
        foregroundColor: Colors.pink.shade900,
      ), //AppBar

      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Saved Cities ",
                  style: TextStyle(
                    color: Colors.pink.shade700,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ), //Padding

            if (_cities.isEmpty)
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  width: double.infinity,
                  height: 80,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.pink.shade200,
                    border: Border.all(color: Colors.pink.shade400, width: 3),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Center(
                    child: Text(
                      "No saved cities yet!",
                      style: TextStyle(
                        color: Colors.pink.shade700,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),

            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _cities.length,
              itemBuilder: (context, index) {
                final city = _cities[index];
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.pink.shade200,
                      border: Border.all(color: Colors.pink.shade900, width: 3),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          city['city_name'],
                          style: TextStyle(
                            color: Colors.pink.shade900,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 10),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () => _editCity(
                                city['id'].toString(),
                                city['city_name'],
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.pink.shade400,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  side: BorderSide(
                                    color: Colors.pink.shade900,
                                    width: 2,
                                  ),
                                ),
                              ),
                              child: Text(
                                "Edit",
                                style: TextStyle(
                                  color: Colors.pink.shade100,
                                  fontSize: 16,
                                ),
                              ),
                            ),

                            SizedBox(width: 10),

                            ElevatedButton(
                              onPressed: () => _deleteCity(
                                city['id'].toString(),
                                city['city_name'],
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red.shade300,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  side: BorderSide(
                                    color: Colors.red.shade900,
                                    width: 2,
                                  ),
                                ),
                              ),
                              child: Text(
                                "Delete",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
      //SingleChildScrollView
    );
  }
}
