import 'package:app/data/TriviaRepository.dart';
import 'package:app/domain/usecase/challenge/GetChallengeUseCase.dart';
import 'package:app/domain/usecase/trivia/CreateTriviaUseCase.dart';
import 'package:app/domain/usecase/user/IsLoggedInUseCase.dart';
import 'package:app/domain/usecase/user/LogOutUseCase.dart';
import 'package:app/domain/usecase/user/LoginUseCase.dart';
import 'package:app/domain/usecase/user/MyInfoUseCase.dart';
import 'package:http/http.dart' as http;

import 'data/ChallengeRepository.dart';
import 'data/ENEMGameRepository.dart';
import 'data/ExploreRepository.dart';
import 'data/LocalRepository.dart';
import 'data/LoginRepository.dart';
import 'data/PostRepository.dart';
import 'data/QuestionRepository.dart';
import 'data/RankingRepository.dart';
import 'data/UserRepository.dart';
import 'domain/usecase/challenge/ChallengeSomeoneUseCase.dart';
import 'domain/usecase/challenge/GetChallengeByIdUseCase.dart';
import 'domain/usecase/challenge/SubmitChallengeAnswers.dart';
import 'domain/usecase/enem/GetENEMVideosUseCase.dart';
import 'domain/usecase/enem/GetQuestionsUseCase.dart';
import 'domain/usecase/enem/SubmitGameUseCase.dart';
import 'domain/usecase/post/CreatePostUseCase.dart';
import 'domain/usecase/post/DeletePostUseCase.dart';
import 'domain/usecase/post/ExplorePostsUseCase.dart';
import 'domain/usecase/tournament/GetRankingUseCase.dart';
import 'domain/usecase/user/GetUserByIdUseCase.dart';
import 'domain/usecase/user/GetUserPostsUseCase.dart';
import 'domain/usecase/user/MyChallengesUseCase.dart';
import 'domain/usecase/user/MyPostsUseCase.dart';
import 'domain/usecase/user/SetUserDescriptionUseCase.dart';
import 'domain/usecase/user/SetUserInstagramUseCase.dart';

bool get isDev {
  bool isDev = false;

  assert(isDev = true);

  return isDev;
}

class FeaturesReady {
  static final viewFriend = true;
  static final createTrivia = true;
}

final baseURL = isDev
    ? "https://liceu-staging.herokuapp.com/v2"
    : "https://protected-river-16209.herokuapp.com/v2";

final apiKey = isDev
    ? "2VsYHwfQKtjiAdLs8Z2fTLwuLpofSXWy"
    : "8y/B?E(H+MbQeThWmYq3t6w9z\$C&F)J@";

final enviroment = isDev ? "development" : "production";

final client = new http.Client();
// Repositories
final loginRepository = LoginRepository(baseURL + "/login", apiKey);
final userRepository = UserRepository(baseURL + "/user", apiKey);
final postRepository = PostRepository(baseURL + "/post", apiKey);
final questionRepository =
    ENEMQuestionRepository(baseURL + "/question", apiKey);
final gameRepository = ENEMGameRepository(baseURL + "/game", apiKey);
final exploreRepository = ExploreRepository(baseURL + "/explore", apiKey);
final rankingRepository = RankingRepository(baseURL + "/ranking", apiKey);
final challengeRepository = ChallengeRepository(baseURL + "/challenge", apiKey);
final triviaRepository = TriviaRepository(baseURL + "/trivia", apiKey);
final localRepository = LocalRepository();
// Use Cases
final loginUseCase = LoginUseCase(loginRepository, localRepository);
final myInfoUseCase = MyInfoUseCase(userRepository, localRepository);
final getUserByIdUseCase = GetUserByIdUseCase(userRepository, localRepository);
final myPostsUseCase = MyPostsUseCase(localRepository, userRepository);
final getUserPostsUseCase =
    GetUserPostsUseCase(localRepository, userRepository);
final myChallengesUseCase =
    MyChallengesUseCase(localRepository, userRepository);
final getRankingUseCase =
    GetCurrentRankingUseCase(localRepository, rankingRepository);
final isLoggedInUseCase = IsLoggedInUseCase(localRepository);
final logoutUseCase = LogOutUseCase(localRepository);
final createPostUseCase = CreatePostUseCase(localRepository, postRepository);
final deletePostUseCase = DeletePostUseCase(localRepository, postRepository);
final setUserDescriptionUseCase =
    SetUserDescriptionUseCase(localRepository, userRepository);
final setUserInstagramUseCase =
    SetUserInstagramUseCase(localRepository, userRepository);
final challengeSomeoneUseCase =
    ChallengeSomeoneUseCase(localRepository, challengeRepository);
final getChallengeUseCase =
    GetChallengeUseCase(localRepository, challengeRepository);
final getChallengeByIdUseCase =
    GetChallengeByIdUseCase(localRepository, challengeRepository);
final submitChallengeAnswersUseCase =
    SubmitChallengeAnswersUseCase(localRepository, challengeRepository);
final getExplorePostsUseCase =
    ExplorePostsUseCase(exploreRepository, localRepository);
final getENEMQuestionsUseCase =
    GetQuestionsUseCase(localRepository, questionRepository);
final getENEMQuestionsVideosUseCase =
    GetENEMQuestionsVideosUseCase(localRepository, questionRepository);
final submitENEMGamesUseCase =
    SubmitGameUseCase(localRepository, gameRepository);
final createTriviaUseCase =
    CreateTriviaUseCase(localRepository, triviaRepository);
