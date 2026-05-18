import 'package:flutter/material.dart';
import 'package:flutter_mehrin_2/login_page.dart';
import 'package:flutter_mehrin_2/widgets/input_field.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cPasswordController = TextEditingController();
  bool _isLoading = false;
  final _supabase = Supabase.instance.client;

  void register() async {
    String name = _nameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    setState(() {
      _isLoading = true;
    });
    try {
      final authResponse = await _supabase.auth.signUp(
        email: email,
        password: password,
      );
      final user = authResponse.user;
      if (user != null) {
        try {
          await _supabase.from('profiles').insert({
            'id': user.id,
            'name': name,
            'email': email,
          }).select();
        } catch (e) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Insert failed: $e')));
        }
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Registered Successfully!!")));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } on AuthApiException catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message)));
    }
    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _cPasswordController.clear();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register Page"),

        backgroundColor: Colors.pink.shade50,
        foregroundColor: Colors.pink.shade300,
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
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: _formKey,

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Register ",
                        style: TextStyle(
                          color: Color.fromARGB(255, 128, 19, 55),
                          fontSize: 39,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30),
                      InputField(
                        controller: _nameController,
                        keyboardType: TextInputType.text,
                        labelText: "Name",
                        hintText: "Enter Name",
                        prefixIcon: Icon(Icons.person, color: Colors.white),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter name";
                          }
                          if (!RegExp(r'^[a-zA-Z .]+$').hasMatch(value)) {
                            return "Please a valid name!!";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),

                      InputField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        labelText: "Email",
                        hintText: "@",
                        prefixIcon: Icon(Icons.email, color: Colors.white),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter email";
                          }
                          if (!RegExp(
                            r'^[\w\.-]+@[\w\.-]+\.\w{2,4}$',
                          ).hasMatch(value)) {
                            return "Please enter your institutional email!!";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      InputField(
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,

                        labelText: "Password",
                        hintText: "Enter Password",
                        prefixIcon: Icon(Icons.lock, color: Colors.white),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter password";
                          }
                          if (value.length < 8) {
                            return "Length must be more then 8";
                          }
                          if (!RegExp(
                            r'^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=])(?=\S+$).{8,}$',
                          ).hasMatch(value)) {
                            return "Enter a strong password!!";
                          }
                          if (_passwordController.text !=
                              _cPasswordController.text) {
                            return "password and confirm password does't match";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),

                      InputField(
                        controller: _cPasswordController,
                        keyboardType: TextInputType.visiblePassword,

                        labelText: "Confirm Password",
                        hintText: "Enter Confirm Password",
                        prefixIcon: Icon(Icons.lock, color: Colors.white),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter confirm password";
                          }
                          if (value.length < 8) {
                            return "Length must be more then 8";
                          }
                          if (!RegExp(
                            r'^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=])(?=\S+$).{8,}$',
                          ).hasMatch(value)) {
                            return "Enter a strong password!!";
                          }
                          if (_passwordController.text !=
                              _cPasswordController.text) {
                            return "password and confirm password does't match";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            register();
                          }
                        },
                        child: _isLoading
                            ? CircularProgressIndicator()
                            : Text("Register"),
                      ),
                      SizedBox(height: 20),

                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        ),
                        child: Text("Already have an account? Login"),
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
