import 'package:app/domain/aggregates/Post.dart';
import 'package:app/domain/boundary/LocalBoundary.dart';
import 'package:app/domain/boundary/PostBoundary.dart';

class SearchPostsUseCase implements ISearchPostsUseCase {
  final IPostRepository _postRepository;
  final ILocalRepository _localRepository;

  SearchPostsUseCase(this._postRepository, this._localRepository);

  @override
  Future<List<Post>> run(String query) async {
    final accessToken = await this._localRepository.getCredentials();
    final posts = await this._postRepository.search(accessToken, query);
    return posts;
  }
}
