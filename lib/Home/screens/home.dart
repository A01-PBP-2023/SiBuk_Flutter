import 'package:flutter/material.dart';
import 'package:sibuk_mobile/Home/widgets/recommended_list.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:sibuk_mobile/Home/screens/login.dart';
import 'package:sibuk_mobile/main.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key, this.name, this.onChangeScreen});

  final Function? onChangeScreen;
  final String? name;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(0, 134, 47, 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Row(
                children: [
                  Image.asset(
                    "assets/images/profile.png",
                    width: 100,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hi, ${widget.name}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text("Let's grab your takjil!")
                    ],
                  ),
                  Expanded(
                    child: TextButton(
                      style:
                          TextButton.styleFrom(foregroundColor: Colors.black),
                      onPressed: () async {
                        final response = await request.logout(
                          "http://10.0.2.2:8000/user_auth/logout-flutter/",
                        );
                        String message = response["message"];
                        if (context.mounted) {
                          if (response['status']) {
                            UserInfo.logout();
                            String uname = response["username"];
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("$message Sampai jumpa, $uname."),
                            ));
                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const LoginPage()), (route) => false);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(message),
                              ),
                            );
                          }
                        }
                      },
                      child: const Icon(Icons.logout),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Explore Catalogue",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () => {widget.onChangeScreen!(0)},
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: const Color.fromRGBO(
                                          241, 243, 247, 1),
                                    ),
                                    child: Image.asset(
                                      "assets/images/food-icon.png",
                                      width: 65,
                                    ),
                                  ),
                                  const Text("Food")
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            InkWell(
                              onTap: () => {widget.onChangeScreen!(1)},
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: const Color.fromRGBO(
                                          241, 243, 247, 1),
                                    ),
                                    child: Image.asset(
                                      "assets/images/drink-icon.png",
                                      width: 65,
                                    ),
                                  ),
                                  const Text("Drink")
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            InkWell(
                              onTap: () => {widget.onChangeScreen!(3)},
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: const Color.fromRGBO(
                                          241, 243, 247, 1),
                                    ),
                                    child: Image.asset(
                                      "assets/images/favorite-icon.png",
                                      width: 65,
                                    ),
                                  ),
                                  const Text("Reviews")
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            InkWell(
                              onTap: () => {widget.onChangeScreen!(4)},
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: const Color.fromRGBO(
                                          241, 243, 247, 1),
                                    ),
                                    child: Image.asset(
                                      "assets/images/review-icon.png",
                                      width: 65,
                                    ),
                                  ),
                                  const Text("Reviews")
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(left: 30, top: 30, bottom: 15),
                      width: double.infinity,
                      child: const Text(
                        "Recomendation",
                        textAlign: TextAlign.start,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 40, right: 40),
                      child: const Align(
                          alignment: Alignment.centerLeft,
                          child: RecommendedList()),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
