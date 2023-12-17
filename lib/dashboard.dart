import 'dart:math';

import 'package:app_kepin/constant.dart';
import 'package:app_kepin/sql_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool _isLoading = true;

  void _refreshJournals() async {
    final data = await SQFHelper.getUsers();
    for (int a = 0; a < data.length; a++) {
      print(data[a]);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _refreshJournals2() async {
    final data = await SQFHelper.getBarangs();
    for (int a = 0; a < data.length; a++) {
      print(data[a]);
    }
    // print(data);
    setState(() {
      _isLoading = false;
    });
  }

  void _refreshJournals3() async {
    final data = await SQFHelper.getRiwayats();
    for (int a = 0; a < data.length; a++) {
      print(data[a]);
    }
    // print(data);
    setState(() {
      _isLoading = false;
    });
  }

  void update() async {
    // await SQFHelper.deleteUser(2);
    _refreshJournals();
  }

  TextEditingController txtSearch = TextEditingController();

  @override
  void initState() {
    super.initState();
    // _refreshJournals();
    // _refreshJournals2();
    // _refreshJournals3();
    // update();
    // final now = DateTime.now();
    // DateTime newTime = now.add(Duration(hours: 34, minutes: 49));
    // // String tanggal = DateFormat('dd MMMM yyyy').format(now);
    // print(newTime);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: BottomNavigation(initialIndex: 0),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Center(
                child: Image.asset(
                  'images/logo.png',
                  width: 200,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(20),
                // height: 300,
                width: width - 60,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 30,
                      padding: EdgeInsets.only(left: 50, right: 50),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueGrey),
                      ),
                      child: IntrinsicWidth(
                        child: TextFormField(
                          textAlignVertical: TextAlignVertical.center,
                          controller: txtSearch,
                          decoration: InputDecoration(
                              // prefixIcon: Icon(Icons.search),
                              hintStyle: TextStyle(fontSize: 14),
                              hintText: 'Cari di Sip Bengkel',
                              icon: Icon(
                                Icons.search,
                                color: Colors.black,
                                size: 20,
                              ),
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/susp');
                                },
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'images/suspension.png',
                                      fit: BoxFit.cover,
                                      width: 90,
                                      height: 60,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Suspension',
                                      style: TextStyle(fontSize: 12),
                                    )
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/tire');
                                },
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'images/tire.png',
                                      fit: BoxFit.cover,
                                      width: 90,
                                      height: 60,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Ban',
                                      style: TextStyle(fontSize: 12),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/brake');
                                },
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'images/brake.png',
                                      fit: BoxFit.cover,
                                      width: 90,
                                      height: 60,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Brake',
                                      style: TextStyle(fontSize: 12),
                                    )
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/exh');
                                },
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'images/exhaust.png',
                                      fit: BoxFit.cover,
                                      width: 90,
                                      height: 60,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Exhaust',
                                      style: TextStyle(fontSize: 12),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
