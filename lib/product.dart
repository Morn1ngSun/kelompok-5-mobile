import 'dart:io';

import 'package:app_kepin/constant.dart';
import 'package:app_kepin/sql_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  // TextEditingController txtJenis = TextEditingController();
  TextEditingController txtNama = TextEditingController();
  TextEditingController txtKode = TextEditingController();
  TextEditingController txtJumlah = TextEditingController();
  TextEditingController txtHarga = TextEditingController();
  String gambar = '';
  bool isGambar = false;

  Future<void> addProduk() async {
    if (_value != '' &&
        txtNama.text != '' &&
        txtKode.text != '' &&
        txtJumlah.text != '' &&
        gambar != '' &&
        txtHarga.text != '') {
      await SQFHelper.createBarang(txtNama.text, _value, txtKode.text, gambar,
          txtJumlah.text, txtHarga.text);
      await SQFHelper.createRiwayat(
          txtNama.text, _value, gambar, txtJumlah.text, 'Masuk', '-', '-');
      setState(() {
        isGambar = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
          new SnackBar(content: new Text('Tambah Data Berhasil')));
      kosong();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
          content: new Text('Ada Bagian Wajib Diisi yang Belum Terisi')));
    }
  }

  String _value = '';

  void kosong() {
    gambar = '';
    _value = '';
    txtJumlah.text = '';
    txtKode.text = '';
    txtNama.text = '';
    txtHarga.text = '';
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: BottomNavigation(initialIndex: 1),
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
                padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                // height: 400,
                width: width - 60,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Text('Tambah Produk'),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        children: [
                          Container(
                              height: 200,
                              width: 200,
                              padding: EdgeInsets.only(left: 10, right: 10),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.blueGrey),
                              ),
                              child: GestureDetector(
                                  onTap: () async {
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
                                      setState(() {
                                        gambar = filePath.toString();
                                        if (gambar != '') {
                                          isGambar = true;
                                        }
                                      });

                                      // Lakukan tindakan lain setelah gambar disimpan
                                      print(
                                          'File berhasil disimpan di: $filePath');
                                    } else {
                                      print('Pemilihan gambar dibatalkan');
                                    }
                                    // Navigator.pushNamed(context, '/suspension');
                                  },
                                  child: isGambar
                                      ? Image.file(File(gambar))
                                      : Icon(Icons.add_a_photo))),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 30,
                            padding: EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blueGrey),
                            ),
                            child: DropdownButtonFormField<String>(
                              padding: EdgeInsets.all(0),
                              // itemHeight: 24,
                              decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.all(0),
                                  hintText: 'Jenis Produk',
                                  hintStyle: TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                  border: InputBorder.none),
                              // isDense: true,
                              // isExpanded: true,
                              items: [
                                DropdownMenuItem(
                                  value: '',
                                  child: Text(
                                    'Jenis Produk',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'suspension',
                                  child: Text(
                                    'Suspension',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'tire',
                                  child: Text(
                                    'Tire',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'brake',
                                  child: Text(
                                    'Brake',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'exhaust',
                                  child: Text(
                                    'Exhaust',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _value = value!;
                                  print(_value);
                                });
                              },
                              value: _value,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 30,
                            padding: EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blueGrey),
                            ),
                            child: TextFormField(
                              style: TextStyle(fontSize: 14),
                              controller: txtNama,
                              decoration: InputDecoration(
                                  hintText: 'Nama Produk',
                                  hintStyle: TextStyle(fontSize: 14),
                                  border: InputBorder.none),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 30,
                            padding: EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blueGrey),
                            ),
                            child: TextFormField(
                              style: TextStyle(fontSize: 14),
                              controller: txtKode,
                              decoration: InputDecoration(
                                  hintText: 'Kode Produk',
                                  hintStyle: TextStyle(fontSize: 14),
                                  border: InputBorder.none),
                            ),
                          ),
                          // SizedBox(
                          //   height: 20,
                          // ),
                          // Container(
                          //   height: 30,
                          //   padding: EdgeInsets.only(left: 10, right: 10),
                          //   decoration: BoxDecoration(
                          //     border: Border.all(color: Colors.blueGrey),
                          //   ),
                          //   child: TextFormField(
                          //     style: TextStyle(fontSize: 14),
                          //     controller: txtGambar,
                          //     decoration: InputDecoration(
                          //         hintText: 'Gambar Produk',
                          //         hintStyle: TextStyle(fontSize: 14),
                          //         border: InputBorder.none),
                          //   ),
                          // ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 30,
                            padding: EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blueGrey),
                            ),
                            child: TextFormField(
                              style: TextStyle(fontSize: 14),
                              controller: txtJumlah,
                              decoration: InputDecoration(
                                  hintText: 'Jumlah Inputan',
                                  hintStyle: TextStyle(fontSize: 14),
                                  border: InputBorder.none),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 30,
                            padding: EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blueGrey),
                            ),
                            child: TextFormField(
                              style: TextStyle(fontSize: 14),
                              controller: txtHarga,
                              decoration: InputDecoration(
                                  hintText: 'Harga Barang',
                                  hintStyle: TextStyle(fontSize: 14),
                                  border: InputBorder.none),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                side: BorderSide(color: Colors.black),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                ),
                                minimumSize: Size(0, 0),
                                backgroundColor: Colors.white),
                            onPressed: () {
                              kosong();
                            },
                            child: Container(
                              padding: EdgeInsets.only(top: 3, bottom: 3),
                              child: Text(
                                'Batal',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal),
                              ),
                            )),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                side: BorderSide(color: Colors.black),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                ),
                                minimumSize: Size(0, 0),
                                backgroundColor: Colors.white),
                            onPressed: () {
                              addProduk();
                            },
                            child: Container(
                              padding: EdgeInsets.only(top: 3, bottom: 3),
                              child: Text(
                                'Tambah',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal),
                              ),
                            )),
                      ],
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
