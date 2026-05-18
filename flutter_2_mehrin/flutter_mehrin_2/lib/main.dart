import 'package:flutter/material.dart';

import 'package:flutter_mehrin_2/.homepage.dart';
import 'package:flutter_mehrin_2/auth_gate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://ufjsfidcaujronrpveck.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVmanNmaWRjYXVqcm9ucnB2ZWNrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Nzg5MjQ0MTcsImV4cCI6MjA5NDUwMDQxN30.E-jrhnH4EFmED70jMCzi0wwBG_6_y-S9QMWEK037S4Q',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(textTheme: GoogleFonts.pacificoTextTheme()),

      debugShowCheckedModeBanner: false,

      home: const AuthGate(),
    );
  }
}
