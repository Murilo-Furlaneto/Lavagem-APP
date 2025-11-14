
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get uid => text()();
  TextColumn get nome => text()();
  TextColumn get email => text()();
  TextColumn get funcao => text()();
  BoolColumn get isLoggedIn => boolean().withDefault(const Constant(false))();
}

class Veiculos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text().references(Users, #uid)();
  TextColumn get modelo => text()();
  TextColumn get placa => text()();
  TextColumn get marca => text()();
  TextColumn get status => text()();
}

@DriftDatabase(tables: [Users, Veiculos])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
