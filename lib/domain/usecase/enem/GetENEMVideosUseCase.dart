import 'package:app/domain/aggregates/ENEMVideo.dart';
import 'package:app/domain/boundary/ENEMBoundary.dart';
import 'package:app/domain/boundary/LocalBoundary.dart';

class GetENEMQuestionsVideosUseCase implements IGetENEMQuestionsVideosUseCase {
  final ILocalRepository _localRepository;
  final IENEMQuestionRepository _questionRepository;

  GetENEMQuestionsVideosUseCase(
      this._localRepository, this._questionRepository);

  @override
  Future<List<ENEMVideo>> run(String id) async {
    final accessToken = await this._localRepository.getCredentials();
    final videos = await this._questionRepository.videos(accessToken, id);
    return videos;
  }
}
