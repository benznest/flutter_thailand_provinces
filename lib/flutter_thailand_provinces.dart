import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_thailand_provinces/my_utils.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ThailandProvincesDatabase {
  static Database db;

  static Future<Database> init() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "thailand.db");

    // Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application
      print("Creating database copy from asset.");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load("packages/flutter_thailand_provinces/assets/thailand.db");
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Opening existing database.");
    }

    // open the database
    db = await openDatabase(path, readOnly: true);
    return db;
  }


}
