import 'package:objectbox/objectbox.dart';

@Entity()
class Account {
  int id;
  String title;
  String secret;
  DateTime added;
  DateTime lastUsed;

  Account({
    this.id = 0,
    required this.title,
    required this.secret,
    required this.added,
    required this.lastUsed,
  });
}