abstract class IReportRepository {
  Future<void> submit(String accessToken, String message, List<String> tags);
}

abstract class ISubmitReportUseCase {
  Future<void> run(String message, List<String> tags);
}