import 'package:literaphile/menu.dart';
import 'package:literaphile/screens/admin_page/admin_main.dart';
import 'package:flutter/material.dart';
import 'package:literaphile/menu.dart';
import 'package:literaphile/screens/landingPage/landing.dart';
import 'package:literaphile/screens/register.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const LoginApp());
}

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        titleSpacing: 0.0,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            SizedBox(width: 10.0),

            Icon(
              Icons.book,
              size: 32.0,
              color: Colors.white,
            ),

            SizedBox(width: 10.0),

            Text(
              'LiteraPhile',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),

      body: Container(
        padding: const EdgeInsets.all(16.0),

        // decoration: const BoxDecoration(
        //   gradient: LinearGradient(
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter,
        //     colors: [Color(0xFF04BADE), Color(0xFF55E2E9)],
        //     stops: [0.3, 0.7],
        //   ),
        // ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Text(
              'Literasi untuk Indonesia.',
              style: TextStyle(
                fontSize: 25.0,
              ),
            ),

            const Text(
              'Selamat Datang!',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),

            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
              ),
            ),

            const SizedBox(height: 12.0),

            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),

            const SizedBox(height: 24.0),

            ElevatedButton(
              onPressed: () async {
                String username = _usernameController.text;
                String password = _passwordController.text;

                // Cek kredensial
                // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
                // Untuk menyambungkan Android emulator dengan Django pada localhost,
                // gunakan URL http://10.0.2.2/
                // final response = await request.login("http://localhost:8000/login/", {
                // 'username': username,
                // 'password': password,
                // });

                                final response = await request.login("https://literaphile-f07-tk.pbp.cs.ui.ac.id/login/", {
                                'username': username,
                                'password': password,
                                });


                // username: test_user_vinc, password: HelloWorld123
                if (request.loggedIn) {
                  String message = response['message'];
                  String uname = response['username'];
                  String group = response['group'];

                  if (group == 'admin') {
                    // ignore: use_build_context_synchronously
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const AdminPage()),
                    );
                  } else {
                    // ignore: use_build_context_synchronously
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LandingPage()),
                    );
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(SnackBar(
                          content: Text("$message Selamat datang, $uname.")));
                  }
                } else {
                  // ignore: use_build_context_synchronously
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Login Gagal'),
                      content: Text(response['message']),
                      actions: [
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                }
              },
              child: const Text('Login'),
            ),

            const SizedBox(height: 16.0),

            ElevatedButton(
              onPressed: () {
                // Navigate to register page when 'Register' button is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterPage()),
                );
              },
              child: const Text('Register'),
            ),
            
          ],
        ),
      ),
    );
  }
}
