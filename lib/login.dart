import 'dart:ffi';

import 'package:app_kepin/sql_helper.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  bool isSeen = false;

  bool _isLoading = true;

  void _refreshJournals() async {
    final data = await SQFHelper.getUsers();
    print(data[0]);
    setState(() {
      for (int a = 0; a < data.length; a++) {
        if (txtEmail.text == data[a]['username'] &&
            txtPassword.text == data[a]['password']) {
          print('akun benar');
          Navigator.pushNamed(context, '/dashboard');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              new SnackBar(content: new Text('Email atau Password salah')));
        }
      }
      _isLoading = false;
    });
    // Navigator.pushNamed(context, '/dashboard');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(30),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),
                Image.asset(
                  'images/logo.png',
                  width: 200,
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Email',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  padding: EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(30)),
                  child: TextFormField(
                    controller: txtEmail,
                    decoration: InputDecoration(
                        hintText: 'Email',
                        icon: Icon(
                          Icons.alternate_email,
                          size: 18,
                        ),
                        border: InputBorder.none),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Password',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  padding: EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(30)),
                  child: TextFormField(
                    obscureText: isSeen ? false : true,
                    controller: txtPassword,
                    decoration: InputDecoration(
                        suffixIconConstraints: BoxConstraints(maxHeight: 30),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isSeen = !isSeen;
                              });
                            },
                            icon: isSeen
                                ? Icon(
                                    Icons.visibility,
                                    size: 18,
                                  )
                                : Icon(
                                    Icons.visibility_off,
                                    size: 18,
                                  )),
                        hintText: 'Password',
                        icon: Icon(
                          Icons.key_rounded,
                          size: 18,
                        ),
                        border: InputBorder.none),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _refreshJournals();
                          });
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.only(
                                left: 50, right: 50, top: 10, bottom: 10),
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account? "),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/regis');
                            },
                            child: Text(
                              'Register',
                              style: TextStyle(color: Colors.blue),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
