import 'package:flutter_bloc_template/data/post/models/post_isar.dart';
import 'package:flutter_bloc_template/data/service/local/local_db.dart';
import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';

class LocalDbImpl implements LocalDb {
  Isar? _db;
  bool _isInitialized = false;

  Isar get isar {
    if (_db == null) {
      throw StateError("Database not initialized. Call initialize() first.");
    }
    return _db!;
  }

  @override
  Future<void> clear() async {
    await db.writeTxn(() => db.clear());
  }

  @override
  Future<void> dispose() async {
    if (_db != null && _db!.isOpen) {
      await _db!.close();
      _db = null;
      _isInitialized = false;
    }
  }

  @override
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      final dir = await getApplicationDocumentsDirectory();
      _db = Isar.openSync(
        [PostIsarSchema],
        directory: dir.path,
        name: "bloc_template_app_db",
        maxSizeMiB: 1024,
      );
      _isInitialized = true;
    } catch (e) {
      _isInitialized = false;
      rethrow;
    }
  }

  @override
  bool get isInitialized => _isInitialized;

  @override
  Isar get db => isar;
}
