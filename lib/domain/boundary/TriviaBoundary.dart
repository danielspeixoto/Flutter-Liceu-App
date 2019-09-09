abstract class ITriviaRepository {
  Future<void> create(String accessToken, String question,
      String correctAnswer, String wrongAnswer, List<String> tags);
}

abstract class ICreateTriviaUseCase {
  Future<void> run(String question,
      String correctAnswer, String wrongAnswer, List<String> tags);
}
