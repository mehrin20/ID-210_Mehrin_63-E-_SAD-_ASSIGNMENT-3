import 'package:flutter/material.dart';
import 'package:flutter_mehrin_2/Login_page.dart';
import 'package:flutter_mehrin_2/.homepage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        final session = snapshot.hasData ? snapshot.data!.session : null;
        if (session != null) {
          return HomePage();
        } else {
          return LoginPage();
        }
      },
    );
  }
}
