import 'dart:io';

import 'package:isar/isar.dart';

import 'data.dart';

const _schema = [CompanySchema, Company2Schema, Company3Schema];

Future<void> initIsar() async {
  await Isar.initializeIsarCore(download: true);
  final db = Isar.openSync(
    _schema,
    maxSizeMiB: 1000000,
    directory: Directory.current.path,
  );
  // insertTest(db);
  // calculateSum(db);
  queryTest(db);
}

void insertTest(Isar db) {
  final start = DateTime.now().microsecondsSinceEpoch;
  db.writeTxnSync(
      () => db.company3s.putAllSync(List.generate(3000000, (_) => Company3())));
  final mt = DateTime.now().microsecondsSinceEpoch;
  print('Insert: ${Duration(microseconds: mt - start).inSeconds}');
  // db.writeTxnSync(() =>
  //     db.company2s.putAllSync(List.generate(10000000, (_) => Company2())));
  // final end = DateTime.now().microsecondsSinceEpoch;
  // print('Company2: ${Duration(microseconds: end - mt).inSeconds}');
}

void calculateSum(Isar db) {
  final start = DateTime.now().microsecondsSinceEpoch;
  final sum = db.company3s.where().iProperty().sumSync();
  final mt = DateTime.now().microsecondsSinceEpoch;
  print('Aggregation: ${Duration(microseconds: mt - start).inSeconds}');
  print('Sum: $sum');
}

void queryTest(Isar db) {
  final start = DateTime.now().microsecondsSinceEpoch;
  final companies = db.company3s.where().idBetween(1000, 100000).countSync();
  final mt = DateTime.now().microsecondsSinceEpoch;
  print('Query: ${Duration(microseconds: mt - start).inSeconds}');
  print('Count: $companies');
}
