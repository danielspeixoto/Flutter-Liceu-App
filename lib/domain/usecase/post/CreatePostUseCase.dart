import 'package:app/domain/boundary/LocalBoundary.dart';
import 'package:app/domain/boundary/PostBoundary.dart';

class CreatePostUseCase implements ICreatePostUseCase {

  final IPostRepository _postRepository;
  final ILocalRepository _localRepository;

  CreatePostUseCase(this._localRepository, this._postRepository);

  @override
  Future<void> run(String type, String text) async {
    final accessToken = await this._localRepository.getCredentials();
    await this._postRepository.create(accessToken, type, text);
  }


}