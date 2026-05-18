import 'package:flutter/material.dart';
import 'package:flutter_mehrin_2/widgets/input_field.dart';
import 'package:flutter_mehrin_2/register_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  bool _isLoading = false;
  final _supabase = Supabase.instance.client;

  Future<void> login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    setState(() {
      _isLoading = true;
    });
    try {
      await _supabase.auth.signInWithPassword(email: email, password: password);
    } on AuthApiException catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message)));
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("An error occurred: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"),
        backgroundColor: Colors.pink.shade50,
        foregroundColor: Colors.pink.shade200,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 244, 165, 199),
              Color.fromARGB(255, 180, 50, 100),
            ],
          ),
        ),
        child: Center(
          child: SizedBox(
            height: 600,
            width: 700,
            child: Card(
              elevation: 30,
              color: const Color.fromARGB(255, 240, 153, 202),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(
                  color: Color.fromARGB(255, 147, 60, 89),
                  width: 5,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Login ",
                        style: TextStyle(
                          color: Color.fromARGB(255, 128, 19, 55),
                          fontSize: 39,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30),
                      InputField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email is required!";
                          }
                          return null;
                        },
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                        hintText: "@",
                        labelText: "Enter Email",
                        labelStyle: const TextStyle(
                          color: Color.fromARGB(255, 158, 74, 98),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      const SizedBox(height: 40),
                      InputField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Phone number is required!";
                          }
                          if (value.length < 11) {
                            return "Enter a valid phone number!";
                          }
                          return null;
                        },
                        prefixIcon: const Icon(
                          Icons.phone,
                          color: Colors.white,
                        ),
                        hintText: "+880",
                        labelText: "Enter Phone Number",
                        labelStyle: const TextStyle(
                          color: Color.fromARGB(255, 158, 74, 98),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      const SizedBox(height: 40),
                      InputField(
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password is required!";
                          }
                          if (value.length < 6) {
                            return "Password must be at least 6 characters!";
                          }
                          return null;
                        },
                        prefixIcon: const Icon(Icons.lock, color: Colors.white),
                        hintText: "Enter Password",
                        labelText: "Password",
                        labelStyle: const TextStyle(
                          color: Color.fromARGB(255, 158, 74, 98),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: _isLoading
                            ? null
                            : () async {
                                if (_formKey.currentState!.validate()) {
                                  await login();
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          side: const BorderSide(
                            color: Color.fromARGB(255, 147, 61, 90),
                            width: 3,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 15,
                          ),
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator()
                            : Text(
                                "Login",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.pink.shade700,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                      const SizedBox(height: 35),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterPage(),
                          ),
                        ),
                        child: Text(
                          "Don't have an account? Register",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 231, 95, 145),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
