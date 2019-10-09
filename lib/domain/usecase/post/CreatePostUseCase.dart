import 'package:app/domain/aggregates/exceptions/CreatePostExceptions.dart';
import 'package:app/domain/boundary/LocalBoundary.dart';
import 'package:app/domain/boundary/PostBoundary.dart';

class CreateTextPostUseCase implements ICreateTextPostUseCase {
  final IPostRepository _postRepository;
  final ILocalRepository _localRepository;

  CreateTextPostUseCase(this._localRepository, this._postRepository);

  @override
  Future<void> run(String text) async {
    if (text.length < 100 || text.length > 2000) {
      throw CreatePostException();
    }
    final accessToken = await this._localRepository.getCredentials();
    await this._postRepository.createTextPost(accessToken, text);
  }
}

class CreateImagePostUseCase implements ICreateImagePostUseCase {
  final IPostRepository _postRepository;
  final ILocalRepository _localRepository;

  CreateImagePostUseCase(this._localRepository, this._postRepository);

  @override
  Future<void> run(String imageData, String text) async {
    if (text.length < 100 || text.length > 2000) {
      throw CreatePostException();
    }
    final accessToken = await this._localRepository.getCredentials();
    await this
        ._postRepository
        .createImagePost(accessToken, imageData, "DEFAULT_TITLE", text);
  }
}
