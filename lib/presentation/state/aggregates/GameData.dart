import 'package:app/domain/aggregates/ENEMGame.dart';
import 'package:app/domain/aggregates/User.dart';

class GameData {
  final String id;
  final User user;
  final List<ENEMAnswer> answers;
  final int timeSpent;

  GameData(this.id, this.user, this.answers, this.timeSpent);
}