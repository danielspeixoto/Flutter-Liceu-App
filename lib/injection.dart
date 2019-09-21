import 'package:app/domain/usecase/challenge/GetChallengeUseCase.dart';
import 'package:app/domain/usecase/user/IsLoggedInUseCase.dart';
import 'package:app/domain/usecase/user/LogOutUseCase.dart';
import 'package:app/domain/usecase/user/LoginUseCase.dart';
import 'package:app/domain/usecase/user/MyInfoUseCase.dart';
import 'package:http/http.dart' as http;

import 'data/ChallengeRepository.dart';
import 'data/ExploreRepository.dart';
import 'data/LocalRepository.dart';
import 'data/LoginRepository.dart';
import 'data/PostRepository.dart';
import 'data/QuestionRepository.dart';
import 'data/RankingRepository.dart';
import 'data/UserRepository.dart';
import 'domain/usecase/challenge/SubmitChallengeAnswers.dart';
import 'domain/usecase/enem/GetQuestionsUseCase.dart';
import 'domain/usecase/post/CreatePostUseCase.dart';
import 'domain/usecase/post/DeletePostUseCase.dart';
import 'domain/usecase/post/ExplorePostsUseCase.dart';
import 'domain/usecase/tournament/GetRankingUseCase.dart';
import 'domain/usecase/user/GetUserByIdUseCase.dart';
import 'domain/usecase/user/MyChallengesUseCase.dart';
import 'domain/usecase/user/MyPostsUseCase.dart';
import 'domain/usecase/user/SetUserDescriptionUseCase.dart';
import 'domain/usecase/user/SetUserInstagramUseCase.dart';

//final baseURL = "https://liceu-staging.herokuapp.com/v2";
//final apiKey = "2VsYHwfQKtjiAdLs8Z2fTLwuLpofSXWy";
final baseURL = "https://protected-river-16209.herokuapp.com/v2";
final apiKey = "8y/B?E(H+MbQeThWmYq3t6w9z\$C&F)J@";

final client = new http.Client();
// Repositories
final loginRepository = LoginRepository(baseURL + "/login", apiKey);
final userRepository = UserRepository(baseURL + "/user", apiKey);
final postRepository = PostRepository(baseURL + "/post", apiKey);
final questionRepository = ENEMQuestionRepository(baseURL + "/question", apiKey);
final exploreRepository = ExploreRepository(baseURL + "/explore", apiKey);
final rankingRepository = RankingRepository(baseURL + "/ranking", apiKey);
final challengeRepository = ChallengeRepository(baseURL + "/challenge", apiKey);
final localRepository = LocalRepository();
// Use Cases
final loginUseCase = LoginUseCase(loginRepository, localRepository);
final myInfoUseCase = MyInfoUseCase(userRepository, localRepository);
final getUserByIdUseCase = GetUserByIdUseCase(userRepository, localRepository);
final myPostsUseCase = MyPostsUseCase(localRepository, userRepository);
final myChallengesUseCase = MyChallengesUseCase(localRepository, userRepository);
final getRankingUseCase = GetCurrentRankingUseCase(localRepository, rankingRepository);
final isLoggedInUseCase = IsLoggedInUseCase(localRepository);
final logoutUseCase = LogOutUseCase(localRepository);
final createPostUseCase = CreatePostUseCase(localRepository, postRepository);
final deletePostUseCase = DeletePostUseCase(localRepository, postRepository);
final setUserDescriptionUseCase =
    SetUserDescriptionUseCase(localRepository, userRepository);
final setUserInstagramUseCase =
    SetUserInstagramUseCase(localRepository, userRepository);
final getChallengeUseCase = GetChallengeUseCase(localRepository, challengeRepository);
final submitChallengeAnswersUseCase = SubmitChallengeAnswersUseCase(localRepository, challengeRepository);
final getExplorePostsUseCase = ExplorePostsUseCase(exploreRepository, localRepository);
final getENEMQuestionsUseCase = GetQuestionsUseCase(localRepository, questionRepository);