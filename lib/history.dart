import 'dart:io';

import 'package:app_kepin/constant.dart';
import 'package:app_kepin/sql_helper.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  bool _isLoading = true;

  List<Map<String, dynamic>> data = [];

  void showHistory() async {
    data = await SQFHelper.getRiwayats();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showHistory();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: BottomNavigation(initialIndex: 2),
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
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                // height: 400,
                width: width - 60,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Text('Riwayat Produk'),
                    _isLoading
                        ? CircularProgressIndicator()
                        : ListView.builder(
                            reverse: true,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              bool isMasuk = false;
                              bool isGambar = false;
                              bool isBeli = false;
                              Map<String, dynamic> item = data[index];
                              if (item['ket'] == 'Masuk') {
                                isMasuk = true;
                              } else if (item['ket'] == 'Keluar') {
                                isMasuk = false;
                              }
                              if (item['gambar'] != '') {
                                isGambar = true;
                              } else if (item['gambar'] == '') {
                                isGambar = false;
                              }
                              if (item['nama_pembeli'] != '-') {
                                isBeli = true;
                              } else if (item['nama_pembeli'] == '-') {
                                isBeli = false;
                              }
                              return Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 15,
                                        right: 15,
                                        top: 15,
                                        bottom: 5),
                                    height: isBeli ? 190 : 155,
                                    width: width - 60,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(bottom: 5),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: Colors.grey))),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    item['jenis_produk'],
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Text(item['tanggal'],
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.grey))
                                                ],
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 5, vertical: 3),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7),
                                                    color: isMasuk
                                                        ? Colors
                                                            .greenAccent[100]
                                                        : Colors
                                                            .redAccent[100]),
                                                child: Text(item['ket'],
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all()),
                                              child: isGambar
                                                  ? Image.file(
                                                      File(item['gambar']),
                                                      width: 65,
                                                      height: 40,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : Image.asset(
                                                      'images/eror.png',
                                                      width: 65,
                                                      height: 40,
                                                      fit: BoxFit.cover,
                                                    ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Container(
                                              width: width - 210,
                                              child: Text(
                                                // overflow: TextOverflow.ellipsis,
                                                item['nama_produk'],
                                                maxLines: 3,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            isBeli
                                                ? Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Nama Pembeli : ${item['nama_pembeli']}',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 12),
                                                      ),
                                                      SizedBox(
                                                        height: 3,
                                                      ),
                                                      Text(
                                                        'No HP        : ${item['nohp']}',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 12),
                                                      ),
                                                      SizedBox(
                                                        height: 3,
                                                      ),
                                                    ],
                                                  )
                                                : Container(),
                                            Text(
                                              'Total Keluar:',
                                              style: TextStyle(fontSize: 12),
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              '${item['jumlah']} Produk',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  )
                                ],
                              );
                              // if (item['ket'] == 'Keluar') {
                              //   return Column(
                              //     children: [
                              //       Container(
                              //         padding: EdgeInsets.only(
                              //             left: 15,
                              //             right: 15,
                              //             top: 15,
                              //             bottom: 5),
                              //         height: 190,
                              //         width: width - 60,
                              //         decoration: BoxDecoration(
                              //           border: Border.all(color: Colors.grey),
                              //           borderRadius: BorderRadius.circular(10),
                              //         ),
                              //         child: Column(
                              //           crossAxisAlignment:
                              //               CrossAxisAlignment.start,
                              //           children: [
                              //             Container(
                              //               padding: EdgeInsets.only(bottom: 5),
                              //               decoration: BoxDecoration(
                              //                   border: Border(
                              //                       bottom: BorderSide(
                              //                           color: Colors.grey))),
                              //               child: Row(
                              //                 mainAxisAlignment:
                              //                     MainAxisAlignment
                              //                         .spaceBetween,
                              //                 children: [
                              //                   Column(
                              //                     crossAxisAlignment:
                              //                         CrossAxisAlignment.start,
                              //                     children: [
                              //                       Text(
                              //                         item['jenis_produk'],
                              //                         style: TextStyle(
                              //                             fontSize: 12,
                              //                             fontWeight:
                              //                                 FontWeight.bold),
                              //                       ),
                              //                       SizedBox(
                              //                         height: 3,
                              //                       ),
                              //                       Text(item['tanggal'],
                              //                           style: TextStyle(
                              //                               fontSize: 12,
                              //                               color: Colors.grey))
                              //                     ],
                              //                   ),
                              //                   Container(
                              //                     padding: EdgeInsets.symmetric(
                              //                         horizontal: 5,
                              //                         vertical: 3),
                              //                     decoration: BoxDecoration(
                              //                         borderRadius:
                              //                             BorderRadius.circular(
                              //                                 7),
                              //                         color: Colors
                              //                             .redAccent[100]),
                              //                     child: Text(item['ket'],
                              //                         style: TextStyle(
                              //                             fontSize: 12,
                              //                             fontWeight:
                              //                                 FontWeight.bold)),
                              //                   )
                              //                 ],
                              //               ),
                              //             ),
                              //             SizedBox(
                              //               height: 10,
                              //             ),
                              //             Row(
                              //               children: [
                              //                 Container(
                              //                   decoration: BoxDecoration(
                              //                       border: Border.all()),
                              //                   child: Image.asset(
                              //                     'images/eror.png',
                              //                     width: 65,
                              //                     height: 40,
                              //                     fit: BoxFit.cover,
                              //                   ),
                              //                 ),
                              //                 SizedBox(
                              //                   width: 5,
                              //                 ),
                              //                 Container(
                              //                   width: width - 210,
                              //                   child: Text(
                              //                     // overflow: TextOverflow.ellipsis,
                              //                     item['nama_produk'],
                              //                     maxLines: 3,
                              //                     style: TextStyle(
                              //                         fontWeight:
                              //                             FontWeight.bold,
                              //                         fontSize: 12),
                              //                   ),
                              //                 ),
                              //               ],
                              //             ),
                              //             SizedBox(
                              //               height: 10,
                              //             ),
                              //             Column(
                              //               crossAxisAlignment:
                              //                   CrossAxisAlignment.start,
                              //               children: [
                              //                 Text(
                              //                   'Nama Pembeli : ${item['nama_pembeli']}',
                              //                   style: TextStyle(
                              //                       fontWeight: FontWeight.bold,
                              //                       fontSize: 12),
                              //                 ),
                              //                 SizedBox(
                              //                   height: 3,
                              //                 ),
                              //                 Text(
                              //                   'No HP        : ${item['nohp']}',
                              //                   style: TextStyle(
                              //                       fontWeight: FontWeight.bold,
                              //                       fontSize: 12),
                              //                 ),
                              //                 SizedBox(
                              //                   height: 3,
                              //                 ),
                              //                 Text(
                              //                   'Total Keluar:',
                              //                   style: TextStyle(fontSize: 12),
                              //                 ),
                              //                 SizedBox(
                              //                   height: 3,
                              //                 ),
                              //                 Text(
                              //                   '${item['jumlah']} Produk',
                              //                   style: TextStyle(
                              //                       fontSize: 12,
                              //                       fontWeight:
                              //                           FontWeight.bold),
                              //                 )
                              //               ],
                              //             )
                              //           ],
                              //         ),
                              //       ),
                              //       SizedBox(
                              //         height: 20,
                              //       )
                              //     ],
                              //   );
                              // } else if (item['ket'] == 'Masuk') {
                              //   return Column(
                              //     children: [
                              //       Container(
                              //         padding: EdgeInsets.only(
                              //             left: 15,
                              //             right: 15,
                              //             top: 15,
                              //             bottom: 5),
                              //         height: 155,
                              //         width: width - 60,
                              //         decoration: BoxDecoration(
                              //           border: Border.all(color: Colors.grey),
                              //           borderRadius: BorderRadius.circular(10),
                              //         ),
                              //         child: Column(
                              //           crossAxisAlignment:
                              //               CrossAxisAlignment.start,
                              //           children: [
                              //             Container(
                              //               padding: EdgeInsets.only(bottom: 5),
                              //               decoration: BoxDecoration(
                              //                   border: Border(
                              //                       bottom: BorderSide(
                              //                           color: Colors.grey))),
                              //               child: Row(
                              //                 mainAxisAlignment:
                              //                     MainAxisAlignment
                              //                         .spaceBetween,
                              //                 children: [
                              //                   Column(
                              //                     crossAxisAlignment:
                              //                         CrossAxisAlignment.start,
                              //                     children: [
                              //                       Text(
                              //                         item['jenis_produk'],
                              //                         style: TextStyle(
                              //                             fontSize: 12,
                              //                             fontWeight:
                              //                                 FontWeight.bold),
                              //                       ),
                              //                       SizedBox(
                              //                         height: 3,
                              //                       ),
                              //                       Text(item['tanggal'],
                              //                           style: TextStyle(
                              //                               fontSize: 12,
                              //                               color: Colors.grey))
                              //                     ],
                              //                   ),
                              //                   Container(
                              //                     padding: EdgeInsets.symmetric(
                              //                         horizontal: 5,
                              //                         vertical: 3),
                              //                     decoration: BoxDecoration(
                              //                         borderRadius:
                              //                             BorderRadius.circular(
                              //                                 7),
                              //                         color: Colors
                              //                             .greenAccent[100]),
                              //                     child: Text(item['ket'],
                              //                         style: TextStyle(
                              //                             fontSize: 12,
                              //                             fontWeight:
                              //                                 FontWeight.bold)),
                              //                   )
                              //                 ],
                              //               ),
                              //             ),
                              //             SizedBox(
                              //               height: 10,
                              //             ),
                              //             Row(
                              //               children: [
                              //                 Container(
                              //                   decoration: BoxDecoration(
                              //                       border: Border.all()),
                              //                   child: Image.asset(
                              //                     'images/eror.png',
                              //                     width: 65,
                              //                     height: 40,
                              //                     fit: BoxFit.cover,
                              //                   ),
                              //                 ),
                              //                 SizedBox(
                              //                   width: 5,
                              //                 ),
                              //                 Container(
                              //                   width: width - 210,
                              //                   child: Text(
                              //                     // overflow: TextOverflow.ellipsis,
                              //                     item['nama_produk'],
                              //                     maxLines: 3,
                              //                     style: TextStyle(
                              //                         fontWeight:
                              //                             FontWeight.bold,
                              //                         fontSize: 12),
                              //                   ),
                              //                 ),
                              //               ],
                              //             ),
                              //             SizedBox(
                              //               height: 10,
                              //             ),
                              //             Column(
                              //               crossAxisAlignment:
                              //                   CrossAxisAlignment.start,
                              //               children: [
                              //                 Text(
                              //                   'Total Masuk:',
                              //                   style: TextStyle(fontSize: 12),
                              //                 ),
                              //                 SizedBox(
                              //                   height: 3,
                              //                 ),
                              //                 Text(
                              //                   '${item['jumlah']} Produk',
                              //                   style: TextStyle(
                              //                       fontSize: 12,
                              //                       fontWeight:
                              //                           FontWeight.bold),
                              //                 )
                              //               ],
                              //             )
                              //           ],
                              //         ),
                              //       ),
                              //       SizedBox(
                              //         height: 20,
                              //       )
                              //     ],
                              //   );
                              // }
                            },
                          )
                    // Container(
                    //   padding: EdgeInsets.only(
                    //       left: 15, right: 15, top: 15, bottom: 5),
                    //   height: 155,
                    //   width: width - 60,
                    //   decoration: BoxDecoration(
                    //     border: Border.all(color: Colors.grey),
                    //     borderRadius: BorderRadius.circular(10),
                    //   ),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Container(
                    //         padding: EdgeInsets.only(bottom: 5),
                    //         decoration: BoxDecoration(
                    //             border: Border(
                    //                 bottom: BorderSide(color: Colors.grey))),
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             Column(
                    //               crossAxisAlignment: CrossAxisAlignment.start,
                    //               children: [
                    //                 Text(
                    //                   'Knalpot',
                    //                   style: TextStyle(
                    //                       fontSize: 12,
                    //                       fontWeight: FontWeight.bold),
                    //                 ),
                    //                 SizedBox(
                    //                   height: 3,
                    //                 ),
                    //                 Text('22 Nov 2023',
                    //                     style: TextStyle(
                    //                         fontSize: 12, color: Colors.grey))
                    //               ],
                    //             ),
                    //             Container(
                    //               padding: EdgeInsets.symmetric(
                    //                   horizontal: 5, vertical: 3),
                    //               decoration: BoxDecoration(
                    //                   borderRadius: BorderRadius.circular(7),
                    //                   color: Colors.greenAccent[100]),
                    //               child: Text('Masuk',
                    //                   style: TextStyle(
                    //                       fontSize: 12,
                    //                       fontWeight: FontWeight.bold)),
                    //             )
                    //           ],
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         height: 10,
                    //       ),
                    //       Row(
                    //         children: [
                    //           Container(
                    //             decoration: BoxDecoration(border: Border.all()),
                    //             child: Image.asset(
                    //               'images/mugen.png',
                    //               width: 65,
                    //               height: 40,
                    //               fit: BoxFit.cover,
                    //             ),
                    //           ),
                    //           SizedBox(
                    //             width: 5,
                    //           ),
                    //           Container(
                    //             width: width - 210,
                    //             child: Text(
                    //               overflow: TextOverflow.ellipsis,
                    //               'Mugen Single Exhaust MS1 | 9',
                    //               maxLines: 3,
                    //               style: TextStyle(
                    //                   fontWeight: FontWeight.bold,
                    //                   fontSize: 12),
                    //             ),
                    //           )
                    //         ],
                    //       ),
                    //       SizedBox(
                    //         height: 10,
                    //       ),
                    //       Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Text(
                    //             'Total Masuk:',
                    //             style: TextStyle(fontSize: 12),
                    //           ),
                    //           SizedBox(
                    //             height: 3,
                    //           ),
                    //           Text(
                    //             '1 Produk',
                    //             style: TextStyle(
                    //                 fontSize: 12, fontWeight: FontWeight.bold),
                    //           )
                    //         ],
                    //       )
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // Container(
                    //   padding: EdgeInsets.only(
                    //       left: 15, right: 15, top: 15, bottom: 5),
                    //   height: 190,
                    //   width: width - 60,
                    //   decoration: BoxDecoration(
                    //     border: Border.all(color: Colors.grey),
                    //     borderRadius: BorderRadius.circular(10),
                    //   ),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Container(
                    //         padding: EdgeInsets.only(bottom: 5),
                    //         decoration: BoxDecoration(
                    //             border: Border(
                    //                 bottom: BorderSide(color: Colors.grey))),
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             Column(
                    //               crossAxisAlignment: CrossAxisAlignment.start,
                    //               children: [
                    //                 Text(
                    //                   'Suspensi',
                    //                   style: TextStyle(
                    //                       fontSize: 12,
                    //                       fontWeight: FontWeight.bold),
                    //                 ),
                    //                 SizedBox(
                    //                   height: 3,
                    //                 ),
                    //                 Text('1 Des 2023',
                    //                     style: TextStyle(
                    //                         fontSize: 12, color: Colors.grey))
                    //               ],
                    //             ),
                    //             Container(
                    //               padding: EdgeInsets.symmetric(
                    //                   horizontal: 5, vertical: 3),
                    //               decoration: BoxDecoration(
                    //                   borderRadius: BorderRadius.circular(7),
                    //                   color: Colors.redAccent[100]),
                    //               child: Text('Keluar',
                    //                   style: TextStyle(
                    //                       fontSize: 12,
                    //                       fontWeight: FontWeight.bold)),
                    //             )
                    //           ],
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         height: 10,
                    //       ),
                    //       Row(
                    //         children: [
                    //           Container(
                    //             decoration: BoxDecoration(border: Border.all()),
                    //             child: Image.asset(
                    //               'images/kayaba.png',
                    //               width: 65,
                    //               height: 40,
                    //               fit: BoxFit.cover,
                    //             ),
                    //           ),
                    //           SizedBox(
                    //             width: 5,
                    //           ),
                    //           Container(
                    //             width: width - 210,
                    //             child: Text(
                    //               overflow: TextOverflow.ellipsis,
                    //               'Kayaba Ultra Suspensi Rigid UR1 | 58',
                    //               maxLines: 3,
                    //               style: TextStyle(
                    //                   fontWeight: FontWeight.bold,
                    //                   fontSize: 12),
                    //             ),
                    //           )
                    //         ],
                    //       ),
                    //       SizedBox(
                    //         height: 10,
                    //       ),
                    //       Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Text(
                    //             'Nama Pembeli : Ageng Hebat',
                    //             style: TextStyle(
                    //                 fontWeight: FontWeight.bold, fontSize: 12),
                    //           ),
                    //           SizedBox(
                    //             height: 3,
                    //           ),
                    //           Text(
                    //             'No HP        : 081234567890',
                    //             style: TextStyle(
                    //                 fontWeight: FontWeight.bold, fontSize: 12),
                    //           ),
                    //           SizedBox(
                    //             height: 3,
                    //           ),
                    //           Text(
                    //             'Total Keluar:',
                    //             style: TextStyle(fontSize: 12),
                    //           ),
                    //           SizedBox(
                    //             height: 3,
                    //           ),
                    //           Text(
                    //             '3 Produk',
                    //             style: TextStyle(
                    //                 fontSize: 12, fontWeight: FontWeight.bold),
                    //           )
                    //         ],
                    //       )
                    //     ],
                    //   ),
                    // ),
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
