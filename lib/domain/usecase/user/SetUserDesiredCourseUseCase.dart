import 'package:app/domain/boundary/LocalBoundary.dart';
import 'package:app/domain/boundary/UserBoundary.dart';

class SetUserDesiredCourseUseCase implements ISetUserDesiredCourseUseCase {
  final IUserRepository _userRepository;
  final ILocalRepository _localRepository;

  SetUserDesiredCourseUseCase(this._localRepository, this._userRepository);

  @override
  Future<void> run(String desiredCourse) async {
    final accessToken = await this._localRepository.getCredentials();
    final id = await this._localRepository.getId();
    await this._userRepository.setDesiredCourse(accessToken, id, desiredCourse);
  }
}