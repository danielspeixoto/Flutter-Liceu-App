import 'package:app/domain/aggregates/Post.dart';
import 'package:app/domain/aggregates/exceptions/CreatePostExceptions.dart';
import 'package:app/domain/boundary/LocalBoundary.dart';
import 'package:app/domain/boundary/PostBoundary.dart';

class CreatePostUseCase implements ICreatePostUseCase {
  final IPostRepository _postRepository;
  final ILocalRepository _localRepository;

  CreatePostUseCase(this._localRepository, this._postRepository);

  @override
  Future<void> run(PostType type, String text) async {
 
    if(text.length < 100 || text.length > 2000){
      throw CreatePostException();
    }
    final accessToken = await this._localRepository.getCredentials();
    await this._postRepository.create(accessToken, type, text);
  }
}
