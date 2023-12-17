import 'package:app_kepin/constant.dart';
import 'package:app_kepin/sql_helper.dart';
import 'package:flutter/material.dart';

class DetailProductPage extends StatefulWidget {
  final String kode;
  final int id;
  const DetailProductPage({super.key, required this.kode, required this.id});

  @override
  State<DetailProductPage> createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  TextEditingController txtNama = TextEditingController();
  TextEditingController txtKode = TextEditingController();
  TextEditingController txtJumlah = TextEditingController();
  TextEditingController txtGambar = TextEditingController();
  TextEditingController txtHarga = TextEditingController();
  TextEditingController txtPembeli = TextEditingController();
  TextEditingController txtNohp = TextEditingController();
  TextEditingController txtJlhBeli = TextEditingController();

  bool _isLoading = true;
  String jenis = '';
  int id = 0;

  List<Map<String, dynamic>> data = [];

  Future<void> editProduk() async {
    await SQFHelper.updateBarang(widget.id, txtNama.text, txtKode.text,
        txtGambar.text, txtJumlah.text, txtHarga.text);
    if (jenis == 'suspension') {
      Navigator.pushNamed(context, '/susp');
    } else if (jenis == 'tire') {
      Navigator.pushNamed(context, '/tire');
    } else if (jenis == 'brake') {
      Navigator.pushNamed(context, '/brake');
    } else if (jenis == 'exhaust') {
      Navigator.pushNamed(context, '/exh');
    }
  }

  Future<void> addRiwayat() async {
    await SQFHelper.createRiwayat(txtNama.text, jenis, txtGambar.text,
        txtJlhBeli.text, 'Keluar', txtPembeli.text, txtNohp.text);
    if (jenis == 'suspension') {
      Navigator.pushNamed(context, '/susp');
    } else if (jenis == 'tire') {
      Navigator.pushNamed(context, '/tire');
    } else if (jenis == 'brake') {
      Navigator.pushNamed(context, '/brake');
    } else if (jenis == 'exhaust') {
      Navigator.pushNamed(context, '/exh');
    }
  }

  void showProduk() async {
    data = await SQFHelper.getBarang(widget.kode);
    print(data);
    setState(() {
      _isLoading = false;
      id = data[0]['id'];
      txtNama.text = data[0]['nama_produk'];
      txtKode.text = data[0]['kode_produk'];
      txtJumlah.text = data[0]['jumlah_barang'];
      txtGambar.text = data[0]['gambar'];
      txtHarga.text = data[0]['harga_barang'];
      jenis = data[0]['jenis_produk'];
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
    // print('id nya :  ${widget.id}');
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: BottomNavigation(initialIndex: 0),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
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
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: 20, bottom: 20, left: 15, right: 15),
                    // height: 400,
                    width: width - 60,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding:
                              EdgeInsets.only(top: 10, left: 10, right: 10),
                          // height: 400,
                          width: width - 80,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Text('Edit Produk'),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 30),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 30,
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.blueGrey),
                                      ),
                                      child: TextFormField(
                                        controller: txtNama,
                                        decoration: InputDecoration(
                                            hintText: 'Nama Produk',
                                            hintStyle: TextStyle(fontSize: 14),
                                            border: InputBorder.none),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      height: 30,
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.blueGrey),
                                      ),
                                      child: TextFormField(
                                        controller: txtKode,
                                        decoration: InputDecoration(
                                            hintText: 'Kode Produk',
                                            hintStyle: TextStyle(fontSize: 14),
                                            border: InputBorder.none),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      height: 30,
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.blueGrey),
                                      ),
                                      child: TextFormField(
                                        controller: txtJumlah,
                                        decoration: InputDecoration(
                                            hintText: 'Jumlah Produk',
                                            hintStyle: TextStyle(fontSize: 14),
                                            border: InputBorder.none),
                                      ),
                                    ),
                                    // SizedBox(
                                    //   height: 10,
                                    // ),
                                    // Container(
                                    //   height: 30,
                                    //   padding:
                                    //       EdgeInsets.only(left: 10, right: 10),
                                    //   decoration: BoxDecoration(
                                    //     border:
                                    //         Border.all(color: Colors.blueGrey),
                                    //   ),
                                    //   child: TextFormField(
                                    //     controller: txtGambar,
                                    //     decoration: InputDecoration(
                                    //         hintText: 'Gambar Produk',
                                    //         hintStyle: TextStyle(fontSize: 14),
                                    //         border: InputBorder.none),
                                    //   ),
                                    // ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      height: 30,
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.blueGrey),
                                      ),
                                      child: TextFormField(
                                        controller: txtHarga,
                                        decoration: InputDecoration(
                                            hintText: 'Harga Produk',
                                            hintStyle: TextStyle(fontSize: 14),
                                            border: InputBorder.none),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                                        if (jenis == 'suspension') {
                                          Navigator.pushNamed(context, '/susp');
                                        } else if (jenis == 'tire') {
                                          Navigator.pushNamed(context, '/tire');
                                        } else if (jenis == 'brake') {
                                          Navigator.pushNamed(
                                              context, '/brake');
                                        } else if (jenis == 'exhaust') {
                                          Navigator.pushNamed(context, '/exh');
                                        }
                                      },
                                      child: Container(
                                        padding:
                                            EdgeInsets.only(top: 3, bottom: 3),
                                        child: Text(
                                          'Cancel',
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
                                        editProduk();
                                      },
                                      child: Container(
                                        padding:
                                            EdgeInsets.only(top: 3, bottom: 3),
                                        child: Text(
                                          'Submit',
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
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding:
                              EdgeInsets.only(top: 10, left: 10, right: 10),
                          // height: 400,
                          width: width - 80,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Text('Form Beli Produk'),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 30),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 30,
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.blueGrey),
                                      ),
                                      child: TextFormField(
                                        controller: txtPembeli,
                                        decoration: InputDecoration(
                                            hintText: 'Nama Pembeli',
                                            hintStyle: TextStyle(fontSize: 14),
                                            border: InputBorder.none),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      height: 30,
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.blueGrey),
                                      ),
                                      child: TextFormField(
                                        controller: txtNohp,
                                        decoration: InputDecoration(
                                            hintText: 'No HP',
                                            hintStyle: TextStyle(fontSize: 14),
                                            border: InputBorder.none),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      height: 30,
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.blueGrey),
                                      ),
                                      child: TextFormField(
                                        controller: txtJlhBeli,
                                        decoration: InputDecoration(
                                            hintText: 'Jumlah',
                                            hintStyle: TextStyle(fontSize: 14),
                                            border: InputBorder.none),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                                        if (jenis == 'suspension') {
                                          Navigator.pushNamed(context, '/susp');
                                        } else if (jenis == 'tire') {
                                          Navigator.pushNamed(context, '/tire');
                                        } else if (jenis == 'brake') {
                                          Navigator.pushNamed(
                                              context, '/brake');
                                        } else if (jenis == 'exhaust') {
                                          Navigator.pushNamed(context, '/exh');
                                        }
                                      },
                                      child: Container(
                                        padding:
                                            EdgeInsets.only(top: 3, bottom: 3),
                                        child: Text(
                                          'Cancel',
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
                                        addRiwayat();
                                        SQFHelper.updateStok(txtJumlah.text,
                                            txtJlhBeli.text, txtKode.text);
                                      },
                                      child: Container(
                                        padding:
                                            EdgeInsets.only(top: 3, bottom: 3),
                                        child: Text(
                                          'Submit',
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
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: 10, left: 30, right: 30, bottom: 10),
                          // height: 400,
                          width: width - 80,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Hapus Produk?'),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      side: BorderSide(color: Colors.black),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero,
                                      ),
                                      minimumSize: Size(0, 0),
                                      backgroundColor: Colors.white),
                                  onPressed: () {
                                    SQFHelper.deleteBarang(id);
                                    if (jenis == 'suspension') {
                                      Navigator.pushNamed(context, '/susp');
                                    } else if (jenis == 'tire') {
                                      Navigator.pushNamed(context, '/tire');
                                    } else if (jenis == 'brake') {
                                      Navigator.pushNamed(context, '/brake');
                                    } else if (jenis == 'exhaust') {
                                      Navigator.pushNamed(context, '/exh');
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(top: 3, bottom: 3),
                                    child: Text(
                                      'Hapus',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
