import 'package:flutter_bloc_template/data/post/models/post_isar.dart';
import 'package:flutter_bloc_template/data/service/local/local_db.dart';
import 'package:isar_community/isar.dart';

abstract class PostLocalDatasource {
  Future<void> savePosts(List<PostIsar> posts);
  Future<List<PostIsar>> getAllPosts();
  Future<PostIsar?> getPost(int id);
  Future<void> deletePost(int id);
  Stream<List<PostIsar>> watchPosts();
}

class PostLocalDatasourceImpl extends PostLocalDatasource {
  final LocalDb localDb;

  PostLocalDatasourceImpl({required this.localDb});

  Isar get _db => localDb.db;

  @override
  Future<void> deletePost(int id) async {
    await _db.writeTxn(() => _db.postIsars.delete(id));
  }

  @override
  Future<List<PostIsar>> getAllPosts() async {
    return await _db.postIsars.where().findAll();
  }

  @override
  Future<PostIsar?> getPost(int id) async {
    return await _db.postIsars.get(id);
  }

  @override
  Future<void> savePosts(List<PostIsar> posts) async {
    await _db.writeTxn(() => _db.postIsars.putAll(posts));
  }

  @override
  Stream<List<PostIsar>> watchPosts() {
    return _db.postIsars.where().watch(fireImmediately: true);
  }
}
