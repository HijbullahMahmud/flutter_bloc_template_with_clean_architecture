  import 'package:isar_community/isar.dart';

part 'post_isar.g.dart';

@collection
class PostIsar {
  Id id = Isar.autoIncrement; // optional
  late int userId;
  late String title;
  late String body;

  PostIsar();
}
