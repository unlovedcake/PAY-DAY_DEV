import 'package:my_app/Model/GK-DataModel/GKBorrowerProfileDataModel.dart';

import 'dart:async'; 
// ignore: depend_on_referenced_packages
import 'package:path/path.dart'; 
import 'package:sqflite/sqflite.dart'; 

class SQLiteDbProvider {

  SQLiteDbProvider._(); 
  static final SQLiteDbProvider db = SQLiteDbProvider._(); 

  static Database? _database;
  Future<Database> get database async => _database ??= await initDatabase();

  // this opens the database (and creates it if it doesn't exist)
  initDatabase() async {
    final dabasesPath = await getDatabasesPath(); 
    String path = join(dabasesPath, "gk_sqllite2022v2.db"); 
    return await openDatabase(path,
        version: 2,
        onCreate: _onCreate);
  }

  Future<List<GKBorrowerProfileDataModel>> getAllUserProfile() async {
    final db = await database; 
    List<Map<String,dynamic>> results = await db.query(
        "UserProfile", columns: GKBorrowerProfileDataModel.columns, orderBy: "id ASC"
    ); 

    List<GKBorrowerProfileDataModel> products = [];
    results.forEach((result) {
        GKBorrowerProfileDataModel product = GKBorrowerProfileDataModel.fromMap(result); 
        products.add(product); 
    });
    // print(products.toString());
    return products; 
  }

  Future<List> getSelectSQLLite(String fromTble, String queryStr) async {
    final db = await database; 
    List<Map<String,dynamic>> results = await db.rawQuery(queryStr);

    return results; 
  }

  insertDBQuery(String fromTble, String queryStr, List values, {int isNeedID = 0}) async { 
    List? newVal = values;

    final db = await database; 
    if (isNeedID == 1) {
      var maxIdResult = await db.rawQuery("SELECT MAX(id)+1 as last_inserted_id FROM $fromTble");

      var id = maxIdResult.first["last_inserted_id"];
      newVal.insert(0, id);
    }

    var result = await db.rawInsert(
        queryStr,
        newVal
    ); 
    return result; 
  }

  deleteDBQuery(String tblName, int id) async {
      final db = await database; 
      db.delete(tblName, where: "id = ?", whereArgs: [id]);
  } 

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE UserProfile (
        id INTEGER PRIMARY KEY, 
        sessionid TEXT, 
        borrowerid TEXT, 
        borrowername TEXT, 
        borrowertype TEXT, 
        firstname TEXT,
        middlename TEXT, lastname TEXT, birthdate TEXT, gender TEXT, occupation TEXT, 
        interest TEXT, emailaddress TEXT, isverified INTEGER, mobileno TEXT, imei TEXT,
        userid TEXT, password TEXT, lastlogin TEXT, longitude TEXT, latitude TEXT,
        billingaddress TEXT, streetaddress TEXT, city TEXT, province TEXT, zip INTEGER,
        country TEXT, dateregistration TEXT, datetimelinked TEXT, guarantorid TEXT, isviasubguarantor INTEGER,
        dateapprovedbyguarantor TEXT, creditratingbyguarantor TEXT, status TEXT, profilepicurl TEXT, extra1 TEXT,
        recentotp TEXT, extra2 TEXT, extra3 TEXT, extra4 TEXT, notes1 TEXT, notes2 TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE UserSHA1OTP (
        id INTEGER PRIMARY KEY, 
        sha1OTP TEXT
      )
    ''');
  }
}