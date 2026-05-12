import 'package:flutter/material.dart';

import 'api_services.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final nimController = TextEditingController();

  final passwordController = TextEditingController();

  bool isLoading = false;

  Future login() async {
    setState(() {
      isLoading = true;
    });

    bool success = await ApiService.login(
      nimController.text,
      passwordController.text,
    );

    setState(() {
      isLoading = false;
    });

    if (success) {
      Navigator.pushReplacement(
        context,

        MaterialPageRoute(builder: (_) => HomePage()),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Login gagal')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF7F1E5),

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Container(
                  height: 120,
                  width: 120,

                  decoration: BoxDecoration(
                    color: Color(0xff8B5E3C),

                    borderRadius: BorderRadius.circular(30),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,

                        blurRadius: 15,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),

                  child: Icon(Icons.restaurant, size: 60, color: Colors.white),
                ),

                SizedBox(height: 25),

                Text(
                  'CukoTime',

                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff5C3B28),
                    letterSpacing: 1,
                  ),
                ),

                SizedBox(height: 10),

                Text(
                  'Katalog pempek modern khas Palembang',

                  textAlign: TextAlign.center,

                  style: TextStyle(fontSize: 16, color: Colors.brown.shade400),
                ),

                SizedBox(height: 40),

                Container(
                  padding: EdgeInsets.all(24),

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius: BorderRadius.circular(25),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,

                        blurRadius: 15,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),

                  child: Column(
                    children: [
                      TextField(
                        controller: nimController,

                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.person,
                            color: Color(0xff8B5E3C),
                          ),

                          hintText: 'Username / NIM',

                          hintStyle: TextStyle(color: Colors.brown.shade300),

                          filled: true,

                          fillColor: Color(0xffF7F1E5),

                          contentPadding: EdgeInsets.symmetric(vertical: 18),

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),

                            borderSide: BorderSide.none,
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),

                            borderSide: BorderSide(
                              color: Color(0xff8B5E3C),
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 20),

                      TextField(
                        controller: passwordController,

                        obscureText: true,

                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Color(0xff8B5E3C),
                          ),

                          hintText: 'Password',

                          hintStyle: TextStyle(color: Colors.brown.shade300),
                          filled: true,

                          fillColor: Color(0xffF7F1E5),

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),

                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),

                      SizedBox(height: 30),

                      SizedBox(
                        width: double.infinity,
                        height: 55,

                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff8B5E3C),

                            elevation: 0,

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),

                          onPressed: isLoading ? null : login,

                          child: isLoading
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text(
                                  'LOGIN',

                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 30),

                Text(
                  'Authentic Pempek Experience',

                  style: TextStyle(color: Colors.brown.shade400, fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
