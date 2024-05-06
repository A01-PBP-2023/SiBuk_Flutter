import 'package:flutter/material.dart';

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
    return Container(
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
                Container(
                  margin: const EdgeInsets.only(left: 50),
                  child: TextButton(
                    style: TextButton.styleFrom(foregroundColor: Colors.black),
                    onPressed: () {},
                    child: const Icon(Icons.logout),
                  ),
                )
              ],
            ),
          ),
          Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 10,),
                      const Text(
                        "Explore Catalogue",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () => {widget.onChangeScreen!(1)},
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color:
                                        const Color.fromRGBO(241, 243, 247, 1),
                                  ),
                                  child: Image.asset(
                                    "assets/images/food-icon.png",
                                    width: 75,
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
                            onTap: () => {widget.onChangeScreen!(2)},
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color:
                                        const Color.fromRGBO(241, 243, 247, 1),
                                  ),
                                  child: Image.asset(
                                    "assets/images/drink-icon.png",
                                    width: 75,
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
                                    color:
                                        const Color.fromRGBO(241, 243, 247, 1),
                                  ),
                                  child: Image.asset(
                                    "assets/images/review-icon.png",
                                    width: 75,
                                  ),
                                ),
                                const Text("Reviews")
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                
                ],
              )),
        ],
      ),
    );
  }
}
