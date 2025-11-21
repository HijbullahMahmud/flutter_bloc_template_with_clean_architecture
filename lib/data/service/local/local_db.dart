import 'package:isar_community/isar.dart';

abstract interface class LocalDb {
  Future<void> initialize();
  Future<void> dispose();
  Future<void> clear();
  bool get isInitialized;
  Isar get db;
}
