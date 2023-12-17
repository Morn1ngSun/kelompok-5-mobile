import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQFHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.transaction((txn) async {
      await txn.execute("""CREATE TABLE user(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      username VARCHAR NOT NULL UNIQUE,
      password VARCHAR NOT NULL
    )""");

      await txn.execute("""CREATE TABLE barang(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      nama_produk VARCHAR NOT NULL,
      jenis_produk VARCHAR NOT NULL,
      kode_produk VARCHAR NOT NULL UNIQUE,
      gambar VARCHAR,
      jumlah_barang VARCHAR NOT NULL,
      harga_barang VARCHAR NOT NULL,
      tanggal_masuk VARCHAR,
      tanggal_keluar VARCHAR
    )""");

      await txn.execute("""CREATE TABLE riwayat(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      nama_produk VARCHAR NOT NULL,
      jenis_produk VARCHAR NOT NULL,
      gambar VARCHAR,
      jumlah VARCHAR NOT NULL,
      ket VARCHAR NOT NULL,
      tanggal VARCHAR NOT NULL,
      nama_pembeli VARCHAR,
      nohp VARCHAR
    )""");
    });
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('sip.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  static Future<int> createUser(String username, String password) async {
    final db = await SQFHelper.db();

    final data = {'username': username, 'password': password};
    final id = await db.insert('user', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await SQFHelper.db();
    return db.query('user', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getUser(int id) async {
    final db = await SQFHelper.db();
    return db.query('user', orderBy: 'id = ?', whereArgs: [id], limit: 1);
  }

  static Future<int> updateUser(int id, String username) async {
    final db = await SQFHelper.db();

    final data = {'username': username};

    final result =
        await db.update('user', data, where: 'id = ?', whereArgs: [id]);
    return result;
  }

  static Future<void> deleteUser(int id) async {
    final db = await SQFHelper.db();
    try {
      await db.delete('user', where: 'id = ?', whereArgs: [id]);
    } catch (err) {
      debugPrint('Something went wrong when deleting an item: $err');
    }
  }

  static Future<int> createBarang(String nama, String jenis, String kode,
      String gambar, String jumlah, String harga) async {
    final db = await SQFHelper.db();
    final now = DateTime.now();
    DateTime newTime = now.add(Duration(hours: 34, minutes: 49));
    String tanggal = DateFormat('dd MMMM yyyy').format(newTime);

    try {
      final data = {
        'nama_produk': nama,
        'jenis_produk': jenis,
        'kode_produk': kode,
        'gambar': gambar,
        'jumlah_barang': jumlah,
        'harga_barang': harga,
        'tanggal_masuk': tanggal,
      };

      final id = await db.insert('barang', data,
          conflictAlgorithm: sql.ConflictAlgorithm.replace);

      return id;
    } catch (e) {
      print('Error creating barang: $e');
      return -1; // Atau nilai lain yang menunjukkan kesalahan
    }
  }

  static Future<List<Map<String, dynamic>>> getBarangs() async {
    final db = await SQFHelper.db();
    return db.query('barang', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getBarang(String kode) async {
    final db = await SQFHelper.db();
    return db.query('barang',
        where: 'kode_produk = ?', whereArgs: [kode], limit: 1);
  }

  static Future<List<Map<String, dynamic>>> getBarangBy(String jenis) async {
    final db = await SQFHelper.db();
    return db.query('barang',
        where: 'jenis_produk = ?', orderBy: 'id = ?', whereArgs: [jenis]);
  }

  static Future<List<Map<String, dynamic>>> searchBarang(
      String nama, String jenis) async {
    final db = await SQFHelper.db();

    return db.query('barang',
        where: 'nama_produk LIKE ? AND jenis_produk = ?',
        whereArgs: ['$nama%', jenis]);
  }

  static Future<int> updateBarang(int id, String nama, String kode,
      String gambar, String jumlah, String harga) async {
    final db = await SQFHelper.db();
    final now = DateTime.now();
    DateTime newTime = now.add(Duration(hours: 34, minutes: 49));
    String tanggal = DateFormat('dd MMMM yyyy').format(newTime);

    final data = {
      'nama_produk': nama,
      'kode_produk': kode,
      'gambar': gambar,
      'jumlah_barang': jumlah,
      'harga_barang': harga,
      'tanggal_keluar': tanggal
    };

    final result =
        await db.update('barang', data, where: 'id = ?', whereArgs: [id]);
    return result;
  }

  static Future<int> updateGambar(String gambar, String kode) async {
    final db = await SQFHelper.db();

    final data = {
      'gambar': gambar,
    };

    final result = await db
        .update('barang', data, where: 'kode_produk = ?', whereArgs: [kode]);
    return result;
  }

  static Future<int> updateStok(String awal, String jumlah, String kode) async {
    final db = await SQFHelper.db();
    int aw = int.parse(awal);
    int jlh = int.parse(jumlah);
    int akh = aw - jlh;
    String akhir = akh.toString();

    final data = {
      'jumlah_barang': akhir,
    };

    final result = await db
        .update('barang', data, where: 'kode_produk = ?', whereArgs: [kode]);
    return result;
  }

  static Future<void> deleteBarang(int id) async {
    final db = await SQFHelper.db();
    try {
      await db.delete('barang', where: 'id = ?', whereArgs: [id]);
    } catch (err) {
      debugPrint('Something went wrong when deleting an item: $err');
    }
  }

  static Future<int> createRiwayat(String nama, String jenis, String gambar,
      String jumlah, String ket, String pembeli, String nohp) async {
    final db = await SQFHelper.db();
    final now = DateTime.now();
    DateTime newTime = now.add(Duration(hours: 34, minutes: 49));
    String tanggal = DateFormat('dd MMMM yyyy').format(newTime);

    try {
      final data = {
        'nama_produk': nama,
        'jenis_produk': jenis,
        'gambar': gambar,
        'jumlah': jumlah,
        'ket': ket,
        'tanggal': tanggal,
        'nama_pembeli': pembeli,
        'nohp': nohp
      };

      final id = await db.insert('riwayat', data,
          conflictAlgorithm: sql.ConflictAlgorithm.replace);

      return id;
    } catch (e) {
      print('Error creating barang: $e');
      return -1; // Atau nilai lain yang menunjukkan kesalahan
    }
  }

  static Future<List<Map<String, dynamic>>> getRiwayats() async {
    final db = await SQFHelper.db();
    return db.query('riwayat', orderBy: 'id');
  }
}
