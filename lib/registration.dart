import 'package:app_kepin/sql_helper.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtPasswordConfirm = TextEditingController();
  bool isSeen1 = false;
  bool isSeen2 = false;

  Future<void> _addItem() async {
    if (txtPassword.text == txtPasswordConfirm.text) {
      await SQFHelper.createUser(txtEmail.text, txtPassword.text);
    }
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
                    obscureText: isSeen1 ? false : true,
                    controller: txtPassword,
                    decoration: InputDecoration(
                        suffixIconConstraints: BoxConstraints(maxHeight: 30),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isSeen1 = !isSeen1;
                              });
                            },
                            icon: isSeen1
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
                  height: 20,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Password Confirmation',
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
                    obscureText: isSeen2 ? false : true,
                    controller: txtPasswordConfirm,
                    decoration: InputDecoration(
                        suffixIconConstraints: BoxConstraints(maxHeight: 30),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isSeen2 = !isSeen2;
                              });
                            },
                            icon: isSeen2
                                ? Icon(
                                    Icons.visibility,
                                    size: 18,
                                  )
                                : Icon(
                                    Icons.visibility_off,
                                    size: 18,
                                  )),
                        hintText: 'Password Confirmation',
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
                          if (txtEmail.text != '' &&
                              txtPassword.text != '' &&
                              txtPasswordConfirm.text != '') {
                            _addItem();
                            Navigator.pushNamed(context, '/login');
                          }
                        },
                        child: Text(
                          'Register',
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
                          Text("Already have an account? "),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/login');
                            },
                            child: Text(
                              'Login',
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
