// ignore_for_file: constant_identifier_names, use_build_context_synchronously
import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:literaphile/widgets/register_appbar.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:flutter/material.dart';
import 'package:literaphile/screens/login.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  static const ROUTE_NAME = '/register';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  String username = "";
  String password1 = "";
  String password2 = "";

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    Size size = MediaQuery.of(context).size;

    return Form(
      key: _formKey,
      child: Stack(
        children: [
          Scaffold(

            appBar: const CustomAppBar(title: 'LiteraPhile'),

            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: size.width * 0.1,
                  ),
                  const Stack(
                    children: [
                      Center(
                        child: Text('Register Account',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 55,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.width * 0.1,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 10.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "contoh: Dummy123",
                            labelText: "Username",
                            icon: const Icon(Icons.people),
                            border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              username = value!;
                            });
                          },
                          onSaved: (String? value) {
                            setState(() {
                              username = value!;
                            });
                          },
                          autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Username tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 10.0),
                        child: TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "Masukkan Password",
                            labelText: "Password",
                            icon: const Icon(
                              Icons.lock_outline,
                            ),
                            border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              password1 = value!;
                            });
                          },
                          onSaved: (String? value) {
                            setState(() {
                              password1 = value!;
                            });
                          },
                          autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 10.0),
                        child: TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "Konfirmasi Password",
                            labelText: "Konfirmasi Password",
                            icon: const Icon(Icons.lock_outline),
                            border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              password2 = value!;
                            });
                          },
                          onSaved: (String? value) {
                            setState(() {
                              password2 = value!;
                            });
                          },
                          autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                      ),

                      const SizedBox(
                        height: 25,
                      ),

                      Container(
                        height: size.height * 0.08,
                        width: size.width * 0.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: const Color(0xFF24262A),
                        ),
                        child: TextButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              // Submit to Django server and wait for response
                              final http.Response response = await http.post(
                                // Uri.parse("http://localhost:8000/register-mobile/"),
                                Uri.parse("https://literaphile-f07-tk.pbp.cs.ui.ac.id/register-mobile/"),
                                headers: <String, String>{
                                  'Content-Type': 'application/json',
                                },
                                body: jsonEncode(<String, String>{
                                  'username': username,
                                  'password1': password1,
                                  'password2': password2,
                                }),
                              );

                              if (response.statusCode == 200) {
                                // Successful response
                                final Map<String, dynamic> responseBody = jsonDecode(response.body);

                                if (responseBody['status'] == 'success') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Account has been successfully registered!"),
                                    ),
                                  );

                                  // Show a TextButton to navigate to the login page
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('Registration Successful'),
                                      content: const Text('Account has been successfully registered!'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            // Navigate to the LoginPage when the "Login here" button is pressed
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(builder: (context) => const LoginPage()),
                                              (route) => false,
                                            );
                                          },
                                          child: const Text('Login here'),
                                        ),
                                      ],
                                    ),
                                  );

                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("An error occurred. Please try again."),
                                    ),
                                  );
                                }

                              } else {
                                // Handle errors
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("HTTP ${response.statusCode}: There was an error on the server."),
                                  ),
                                );
                              }
                            }
                          },

                          child: const Text(
                            'Submit',
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                height: 1.5,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}