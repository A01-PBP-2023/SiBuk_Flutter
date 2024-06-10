import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:sibuk_mobile/Home/screens/sibuk_app.dart';
import 'package:sibuk_mobile/main.dart';

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
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Color.fromRGBO(0, 134, 47, 1)),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                padding: const EdgeInsets.only(
                    top: 50, left: 30, right: 30, bottom: 50),
                margin: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        'assets/images/icon.png',
                        width: 100,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                          icon: Icon(
                            Icons.people,
                            color: Color.fromRGBO(1, 77, 47, 1),
                          ),
                          hintText: "Username"),
                    ),
                    const SizedBox(height: 12.0),
                    TextField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                          icon: Icon(
                            Icons.key,
                            color: Color.fromRGBO(1, 77, 47, 1),
                          ),
                          hintText: "Password"),
                      obscureText: true,
                    ),
                    const SizedBox(height: 50.0),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromRGBO(1, 77, 47, 1),
                            foregroundColor: Colors.white),
                        onPressed: () async {
                          FocusManager.instance.primaryFocus?.unfocus();
                          String username = _usernameController.text;
                          String password = _passwordController.text;

                          final response = await request.login(
                              "http://10.0.2.2:8000/user_auth/login-flutter/",
                              {
                                'username': username,
                                'password': password,
                              });
                          if (kDebugMode) {
                            print("Login response: $response");
                          }
                          if (request.loggedIn) {
                            String uname = response['username'];
                            Map<String, dynamic> data = {
                              "username": response["username"],
                              "id": response["id"],
                              "type": response["type"],
                            };
                            UserInfo.login(data);
                            if (context.mounted) {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SibukPage(
                                          name: uname,
                                        )),
                                (route) => false,
                              );
                            }
                          } else {
                            if (context.mounted) {
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
                          }
                        },
                        child: const Text('Login'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
