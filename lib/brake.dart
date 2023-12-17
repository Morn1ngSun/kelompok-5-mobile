import 'dart:convert';
import 'dart:io';

import 'package:app_kepin/constant.dart';
import 'package:app_kepin/detail_product.dart';
import 'package:app_kepin/sql_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class BrakePage extends StatefulWidget {
  const BrakePage({super.key});

  @override
  State<BrakePage> createState() => _BrakePageState();
}

class _BrakePageState extends State<BrakePage> {
  TextEditingController txtSearch = TextEditingController();

  bool _isLoading = true;
  bool isSearch = false;

  List<Map<String, dynamic>> data = [];

  void showProduk() async {
    data = await SQFHelper.getBarangBy('brake');
    for (int a = 0; a < data.length; a++) {
      print(data[a]);
    }
    // print(data);
    setState(() {
      _isLoading = false;
      isSearch = false;
    });
  }

  void search() async {
    data = await SQFHelper.searchBarang(txtSearch.text, 'brake');
    print(data);
    setState(() {
      isSearch = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showProduk();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: BottomNavigation(initialIndex: 0),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.only(top: 50, bottom: 20),
            child: Container(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 5),
              // height: height - 130,
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
                            hintStyle: TextStyle(fontSize: 14),
                            hintText: 'Cari di Brake',
                            icon: GestureDetector(
                              onTap: () {
                                search();
                              },
                              child: Icon(
                                Icons.search,
                                color: Colors.black,
                                size: 20,
                              ),
                            ),
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  _isLoading
                      ? CircularProgressIndicator()
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            bool isGambar = false;
                            Map<String, dynamic> item = data[index];
                            if (item['gambar'] == '') {
                              isGambar = false;
                            } else if (item['gambar'] != '') {
                              isGambar = true;
                            }
                            return Column(
                              children: [
                                GestureDetector(
                                  onLongPress: () async {
                                    ImagePicker imagePicker = ImagePicker();
                                    XFile? file = await imagePicker.pickImage(
                                        source: ImageSource.gallery);

                                    if (file != null) {
                                      // Dapatkan direktori penyimpanan lokal
                                      Directory appDocumentsDirectory =
                                          await getApplicationDocumentsDirectory();
                                      String appDocumentsPath =
                                          appDocumentsDirectory.path;

                                      // Buat path lengkap ke file di penyimpanan lokal
                                      String filePath =
                                          '$appDocumentsPath/${DateTime.now().millisecondsSinceEpoch}.jpg';

                                      // Pindahkan file dari XFile ke penyimpanan lokal
                                      File imageFile = File(file.path);
                                      await imageFile.copy(filePath);

                                      // Lakukan tindakan lain setelah gambar disimpan
                                      print(
                                          'File berhasil disimpan di: $filePath');
                                      await SQFHelper.updateGambar(
                                          filePath, item['kode_produk']);
                                    } else {
                                      print('Pemilihan gambar dibatalkan');
                                    }
                                    Navigator.pushNamed(context, '/brake');
                                  },
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailProductPage(
                                          kode: item['kode_produk'],
                                          id: item['id'],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(),
                                        ),
                                        child: isGambar
                                            ? Image.file(
                                                File(item['gambar']),
                                                fit: BoxFit.fitHeight,
                                                width: (width / 2.4),
                                                height: 100,
                                              )
                                            : Image.asset(
                                                'images/eror.png',
                                                fit: BoxFit.fitHeight,
                                                width: (width / 2.4),
                                                height: 100,
                                              ),
                                      ),
                                      Container(
                                        width: (width / 3.5),
                                        height: 102,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 5,
                                          vertical: 5,
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            top: BorderSide(),
                                            right: BorderSide(),
                                            bottom: BorderSide(),
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              item['nama_produk'],
                                              style: TextStyle(fontSize: 14),
                                            ),
                                            SizedBox(height: 1),
                                            Text(
                                              item['jenis_produk'],
                                              style: TextStyle(fontSize: 12),
                                            ),
                                            SizedBox(height: 1),
                                            Text(
                                              item['kode_produk'],
                                              style: TextStyle(fontSize: 12),
                                            ),
                                            SizedBox(height: 1),
                                            Text(
                                              'Rp ' + item['harga_barang'],
                                              style: TextStyle(fontSize: 12),
                                            ),
                                            SizedBox(height: 1),
                                            Text(
                                              'stok: ' + item['jumlah_barang'],
                                              style: TextStyle(fontSize: 10),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                )
                              ],
                            );
                          },
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
