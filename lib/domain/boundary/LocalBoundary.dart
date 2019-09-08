abstract class ILocalRepository {
  Future<void> saveCredentials(String credentials);
  Future<String> getCredentials();
  Future<String> getId();
  Future<bool> isLoggedIn();

}