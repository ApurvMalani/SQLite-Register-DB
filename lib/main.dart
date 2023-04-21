import 'package:basic/second_page.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'errorpage.dart';
import 'third_page.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      '/': (context) => const MyApp(),
      '2nd': (context) => const HomePage(),
      '/3rd': (context) => const ThirdClass(false),
      '/4th' :  (context) => const ErrorPage(),
    },
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void display() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  //   BOX - CONTAINER.......(1).
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 360,
          height: 600,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: Colors.black, width: 5),
            boxShadow: const [
              BoxShadow(
                color: Colors.lightGreen,
                offset: Offset(4.0, 4.0),
                blurRadius: 15.0,
                spreadRadius: 2.0,
              ),
              BoxShadow(
                color: Colors.lightGreen,
                offset: Offset(-4.0, -4.0),
                blurRadius: 15.0,
                spreadRadius: 2.0,
              ),
            ],
            color: Colors.lightGreen.shade400,
          ),



          // EMAIL  & PASS-WORD  TEXT-FIELDS.....(2)

          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: const Text(
                    'LOGIN',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: const Icon(Icons.email),
                    labelStyle: TextStyle(color: Colors.grey.shade700),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 3.5),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                  ),
                ),
              ),
              const SizedBox(height: 1),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.password),
                    labelStyle: TextStyle(color: Colors.grey.shade700),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 3.5),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                  ),
                ),
              ),

              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/');
                },
                child: const Text(
                  'Create-New-Account',
                  style: TextStyle(
                    fontSize: 19,
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),

              // size  of  distance e-mail-pass & submit  button
              const SizedBox(height: 70),

              ElevatedButton(
                onPressed: () {
                  // Check if email and password fields are empty
                  if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
                    Navigator.pushNamed(context, '/4th'); // Navigate to ErrorPage
                  } else {
                    Navigator.pushNamed(context, '/3rd'); // Navigate to Register page
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  textStyle: const TextStyle(fontSize: 25),
                ),
                child: const Text('Submit'),
              ),

            ],
          ),
        ),
      ),

      //   BOTTOM -  NAVIGATION-BAR...... (3)

      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
            child: GNav(
              backgroundColor: Colors.black,
              color: Colors.white,
              activeColor: Colors.white,
              tabBackgroundColor: Colors.grey.shade800,
              onTabChange: (index) {},
              padding: const EdgeInsets.all(16),
              tabs: [
                GButton(
                  icon: Icons.looks_one_outlined,
                  text: 'First-Screen',
                  onPressed: () {
                    Navigator.pushNamed(context, '/');
                  },
                ),
                GButton(
                  icon: Icons.looks_two_outlined,
                  text: 'Second-Screen',
                  onPressed: () {},
                ),
                GButton(
                  icon: Icons.looks_3_outlined,
                  text: 'Third-Screen',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
