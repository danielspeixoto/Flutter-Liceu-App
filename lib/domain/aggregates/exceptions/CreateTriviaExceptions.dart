import 'package:app/domain/aggregates/exceptions/Exceptions.dart';

class DomainException implements NullException {}

class QuestionException implements SizeBoundaryException {}

class CorrectAnswerException implements SizeBoundaryException {}

class WrongAnswerException implements SizeBoundaryException {}
