import 'package:app/domain/aggregates/User.dart';
import 'package:app/domain/boundary/LocalBoundary.dart';
import 'package:app/domain/boundary/UserBoundary.dart';

class SearchForUserUseCase implements ISearchForUserUseCase {
  final IUserRepository _userRepository;
  final ILocalRepository _localRepository;

  SearchForUserUseCase(this._localRepository, this._userRepository);

  @override
  Future<List<User>> run(String query, int amount) async {
    final accessToken = await this._localRepository.getCredentials();
    final users = await this._userRepository.search(accessToken, query, amount);
    return users;
  }


}
