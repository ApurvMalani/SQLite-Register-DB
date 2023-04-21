import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:basic/sqlite_helper.dart';
import 'package:basic/user_model.dart';
import 'second_page.dart';


class ThirdClass extends StatefulWidget {
  final bool edit;
  final User? user;

  const ThirdClass(this.edit, {Key? key, this.user}) : super(key: key);

  @override
  State<ThirdClass> createState() => _ThirdClassState();
}

   class _ThirdClassState extends State<ThirdClass> {


  TextEditingController usernameEditingController = TextEditingController();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.edit == true) {
      usernameEditingController.text = widget.user!.username;
      emailEditingController.text = widget.user!.email;
      passwordEditingController.text = widget.user!.password;
    }
  }

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
              color: Colors.lightGreen.shade400),

          //  REGISTER, NAME  , EMAIL , PASSWORD.............(1)
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: const Text(
                    'Register',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextField(
                  controller: usernameEditingController,
                  decoration: InputDecoration(
                    labelText: 'User-Name',
                    prefixIcon: const Icon(Icons.person),
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
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextField(
                  controller: emailEditingController,
                  decoration: InputDecoration(
                    labelText: 'E-mail',
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
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextField(
                  controller: passwordEditingController,
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






              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () async  {

                  if (widget.edit == true) {
                    // Update user in database

                    await UsedataBaseProvider.db.updateUser(User(
                        username: usernameEditingController.text,
                        email: emailEditingController.text,
                        password: passwordEditingController.text,
                        id: widget.user!.id));
                  } else {
                    // Add user to database

                    await UsedataBaseProvider.db.addUserDataBase(User(
                      id: 0,
                      username: usernameEditingController.text,
                      email: emailEditingController.text,
                      password: passwordEditingController.text,


                    ));

                  }


                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const  HomePage()),

                  );

                  },

                  style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                   textStyle: const TextStyle(fontSize: 25),

                ),

                child: const Text('Submit'),

              )
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
                  onPressed: () {},
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
