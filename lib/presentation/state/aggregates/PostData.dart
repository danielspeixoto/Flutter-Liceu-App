import 'package:app/domain/aggregates/User.dart';

class PostData {
  final String id;
  final User user;
  final String type;
  final String text;

  PostData(this.id, this.user, this.type, this.text);
}
