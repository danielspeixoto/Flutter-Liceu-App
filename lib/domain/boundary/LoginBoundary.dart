abstract class ILoginRepository {
  Future<String> auth(String accessCode, String method);
}

abstract class ILoginUseCase {
  Future<String> run(String accessCode, String method);
}
