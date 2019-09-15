abstract class ILoginRepository {
  Future<String> auth(String accessCode, String method);
}

abstract class ILoginUseCase {
  Future<void> run(String accessCode, String method);
}
