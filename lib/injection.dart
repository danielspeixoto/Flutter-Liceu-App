import 'dart:io';

import 'package:app/data/ReportRepository.dart';
import 'package:app/data/TriviaRepository.dart';
import 'package:app/domain/boundary/RankingBoundary.dart';
import 'package:app/domain/usecase/challenge/GetChallengeUseCase.dart';
import 'package:app/domain/usecase/post/DeletePostCommentUseCase.dart';
import 'package:app/domain/usecase/post/GetPostByIdUseCase.dart';
import 'package:app/domain/usecase/post/UpdatePostCommentUseCase.dart';
import 'package:app/domain/usecase/post/UpdatePostRatingUseCase.dart';
import 'package:app/domain/usecase/report/SubmitReportUseCase.dart';
import 'package:app/domain/usecase/trivia/CreateTriviaUseCase.dart';
import 'package:app/domain/usecase/user/DeleteSavedPostUseCase.dart';
import 'package:app/domain/usecase/user/GetSavedPostsUseCase.dart';
import 'package:app/domain/usecase/user/IsLoggedInUseCase.dart';
import 'package:app/domain/usecase/user/LogOutUseCase.dart';
import 'package:app/domain/usecase/user/LoginUseCase.dart';
import 'package:app/domain/usecase/user/MyInfoUseCase.dart';
import 'package:app/domain/usecase/user/SavePost.dart';
import 'package:app/domain/usecase/user/SetUserDesiredCourseUseCase.dart';
import 'package:app/domain/usecase/user/SetUserPhoneUseCase.dart';
import 'package:app/domain/usecase/user/SetUserSchoolUseCase.dart';
import 'package:app/domain/usecase/user/SubmitFcmTokenUseCase.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:package_info/package_info.dart';

import 'data/ChallengeRepository.dart';
import 'data/ENEMGameRepository.dart';
import 'data/ExploreRepository.dart';
import 'data/LocalRepository.dart';
import 'data/LoginRepository.dart';
import 'data/PostRepository.dart';
import 'data/QuestionRepository.dart';
import 'data/RankingRepository.dart';
import 'data/UserRepository.dart';
import 'domain/boundary/ChallengeBoundary.dart';
import 'domain/boundary/ENEMBoundary.dart';
import 'domain/boundary/LoginBoundary.dart';
import 'domain/boundary/PostBoundary.dart';
import 'domain/boundary/ReportBoundary.dart';
import 'domain/boundary/TriviaBoundary.dart';
import 'domain/boundary/UserBoundary.dart';
import 'domain/usecase/challenge/ChallengeSomeoneUseCase.dart';
import 'domain/usecase/challenge/GetChallengeByIdUseCase.dart';
import 'domain/usecase/challenge/SubmitChallengeAnswers.dart';
import 'domain/usecase/enem/GetENEMVideosUseCase.dart';
import 'domain/usecase/enem/GetQuestionsUseCase.dart';
import 'domain/usecase/enem/SubmitGameUseCase.dart';
import 'domain/usecase/post/CreatePostUseCase.dart';
import 'domain/usecase/post/DeletePostUseCase.dart';
import 'domain/usecase/post/ExplorePostsUseCase.dart';
import 'domain/usecase/post/SearchPostUseCase.dart';
import 'domain/usecase/tournament/GetRankingUseCase.dart';
import 'domain/usecase/user/CheckUseCase.dart';
import 'domain/usecase/user/GetUserByIdUseCase.dart';
import 'domain/usecase/user/GetUserPostsUseCase.dart';
import 'domain/usecase/user/MyChallengesUseCase.dart';
import 'domain/usecase/user/MyId.dart';
import 'domain/usecase/user/MyPostsUseCase.dart';
import 'domain/usecase/user/SetUserDescriptionUseCase.dart';
import 'domain/usecase/user/SetUserInstagramUseCase.dart';

class Feature {
  static bool get isDev {
    bool isDev = false;

    assert(isDev = true);

    return isDev;
  }
}

class Information {
  static Future<String> get phoneModel async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    String model;
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      model = androidInfo.model;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      model = iosInfo.utsname.machine;
    }

    return model;
  }

  static Future<String> get appVersion async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    return packageInfo.version;
  }

  static Future<String> get brand async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    String brand;
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      brand = androidInfo.brand;
    } else if (Platform.isIOS) {
      brand = "Apple";
    }

    return brand;
  }

  static Future<String> get osRelease async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    String release;
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      release = androidInfo.version.release;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      release = iosInfo.utsname.release;
    }

    return release;
  }
}

class Dependencies {
  final ILoginUseCase loginUseCase;
  final IMyInfoUseCase myInfoUseCase;
  final IGetUserByIdUseCase getUserByIdUseCase;
  final IMyPostsUseCase myPostsUseCase;
  final IGetUserPostsUseCase getUserPostsUseCase;
  final IMyChallengesUseCase myChallengesUseCase;
  final IGetCurrentRankingUseCase getRankingUseCase;
  final IIsLoggedInUseCase isLoggedInUseCase;
  final IMyIdUseCase myIdUseCase;
  final ICheckUseCase checkUseCase;
  final ILogOutUseCase logoutUseCase;
  final ICreateTextPostUseCase createTextPostUseCase;
  final ICreateImagePostUseCase createImagePostUseCase;
  final IDeletePostUseCase deletePostUseCase;
  final ISetUserDescriptionUseCase setUserDescriptionUseCase;
  final ISetUserInstagramUseCase setUserInstagramUseCase;
  final IChallengeSomeoneUseCase challengeSomeoneUseCase;
  final IGetChallengeUseCase getChallengeUseCase;
  final IGetChallengeByIdUseCase getChallengeByIdUseCase;
  final ISubmitChallengeAnswersUseCase submitChallengeAnswersUseCase;
  final IExplorePostUseCase getExplorePostsUseCase;
  final IGetENEMQuestionsUseCase getENEMQuestionsUseCase;
  final IGetENEMQuestionsVideosUseCase getENEMQuestionsVideosUseCase;
  final ISubmitGameUseCase submitENEMGamesUseCase;
  final ICreateTriviaUseCase createTriviaUseCase;
  final ISubmitFcmTokenUseCase submitUserFcmTokenUseCase;
  final ISubmitReportUseCase submitReportUseCase;
  final IGetPostByIdUseCase getPostByIdUseCase;
  final ISetUserPhoneUseCase setUserPhoneUseCase;
  final ISetUserDesiredCourseUseCase setUserDesiredCourseUseCase;
  final ISetUserSchoolUseCase setUserSchoolUseCase;
  final IUpdatePostRatingUseCase updatePostRatingUseCase;
  final IUpdatePostCommentUseCase updatePostCommentUseCase;
  final ISearchPostsUseCase searchPostsUseCase;
  final ISavePostUseCase savePostUseCase;
  final IGetSavedPostsUseCase getSavedPostsUseCase;
  final IDeleteSavedPostUseCase deleteSavedPostUseCase;
  final IDeletePostCommentUseCase deletePostCommentUseCase;

  Dependencies(
    this.loginUseCase,
    this.myInfoUseCase,
    this.getUserByIdUseCase,
    this.myPostsUseCase,
    this.getUserPostsUseCase,
    this.myChallengesUseCase,
    this.getRankingUseCase,
    this.isLoggedInUseCase,
    this.myIdUseCase,
    this.checkUseCase,
    this.logoutUseCase,
    this.createTextPostUseCase,
    this.createImagePostUseCase,
    this.deletePostUseCase,
    this.setUserDescriptionUseCase,
    this.setUserInstagramUseCase,
    this.challengeSomeoneUseCase,
    this.getChallengeUseCase,
    this.getChallengeByIdUseCase,
    this.submitChallengeAnswersUseCase,
    this.getExplorePostsUseCase,
    this.getENEMQuestionsUseCase,
    this.getENEMQuestionsVideosUseCase,
    this.submitENEMGamesUseCase,
    this.createTriviaUseCase,
    this.submitUserFcmTokenUseCase,
    this.submitReportUseCase,
    this.getPostByIdUseCase,
    this.setUserPhoneUseCase,
    this.setUserDesiredCourseUseCase,
    this.setUserSchoolUseCase,
    this.updatePostRatingUseCase,
    this.updatePostCommentUseCase,
    this.searchPostsUseCase,
    this.savePostUseCase,
    this.getSavedPostsUseCase,
    this.deleteSavedPostUseCase,
    this.deletePostCommentUseCase
  );

  static Dependencies obj;

  static Dependencies get() {
    if (obj != null) {
      return obj;
    }
    final client = new Client();
    final baseURL = DotEnv().env['URL'];
    final apiKey = DotEnv().env['API_KEY'];
    // Repositories
    final loginRepository = LoginRepository(baseURL + "/login", apiKey, client);
    final userRepository = UserRepository(baseURL + "/user", apiKey, client);
    final postRepository = PostRepository(baseURL + "/post", apiKey, client);
    final questionRepository =
        ENEMQuestionRepository(baseURL + "/question", apiKey, client);
    final gameRepository =
        ENEMGameRepository(baseURL + "/game", apiKey, client);
    final exploreRepository =
        ExploreRepository(baseURL + "/explore", apiKey, client);
    final rankingRepository =
        RankingRepository(baseURL + "/ranking", apiKey, client);
    final challengeRepository =
        ChallengeRepository(baseURL + "/challenge", apiKey, client);
    final triviaRepository =
        TriviaRepository(baseURL + "/trivia", apiKey, client);
    final reportRepository =
        ReportRepository(baseURL + "/report", apiKey, client);
    final localRepository = LocalRepository();

    // Use Cases
    final loginUseCase = LoginUseCase(loginRepository, localRepository);
    final myInfoUseCase = MyInfoUseCase(userRepository, localRepository);
    final getUserByIdUseCase =
        GetUserByIdUseCase(userRepository, localRepository);
    final myPostsUseCase = MyPostsUseCase(localRepository, userRepository);
    final getUserPostsUseCase =
        GetUserPostsUseCase(localRepository, userRepository);
    final myChallengesUseCase =
        MyChallengesUseCase(localRepository, userRepository);
    final getRankingUseCase =
        GetCurrentRankingUseCase(localRepository, rankingRepository);
    final isLoggedInUseCase = IsLoggedInUseCase(localRepository);
    final myIdUseCase = MyIdUseCase(localRepository);
    final checkUseCase = CheckUseCase(userRepository, localRepository);
    final logoutUseCase = LogOutUseCase(localRepository);
    final createTextPostUseCase =
        CreateTextPostUseCase(localRepository, postRepository);
    final createImagePostUseCase =
        CreateImagePostUseCase(localRepository, postRepository);
    final deletePostUseCase =
        DeletePostUseCase(localRepository, postRepository);
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
        ExplorePostsUseCase(exploreRepository, localRepository, userRepository);
    final searchPostsUseCase =
        SearchPostsUseCase(postRepository, localRepository);
    final getENEMQuestionsUseCase =
        GetQuestionsUseCase(localRepository, questionRepository);
    final getENEMQuestionsVideosUseCase =
        GetENEMQuestionsVideosUseCase(localRepository, questionRepository);
    final submitENEMGamesUseCase =
        SubmitGameUseCase(localRepository, gameRepository);
    final createTriviaUseCase =
        CreateTriviaUseCase(localRepository, triviaRepository);
    final submitUserFcmTokenUseCase =
        SubmitFcmTokenUseCase(localRepository, userRepository);
    final submitReportUseCase =
        SubmitReportUseCase(localRepository, reportRepository);
    final getPostByIdUseCase =
        GetPostByIdUseCase(localRepository, postRepository, userRepository);
    final setUserPhoneUseCase =
        SetUserPhoneUseCase(localRepository, userRepository);
    final setUserDesiredCourseUseCase =
        SetUserDesiredCourseUseCase(localRepository, userRepository);
    final setUserSchooleUseCase =
        SetUserSchoolUseCase(localRepository, userRepository);
    final updatePostRatingUseCase =
        UpdatePostRatingUseCase(localRepository, postRepository);
    final updatePostCommentUseCase =
        UpdatePostCommentUseCase(localRepository, postRepository);
    final savePostUseCase = SavePostUseCase(localRepository, userRepository);
    final getSavedPostsUseCase = GetSavedPostsUseCase(localRepository, userRepository, postRepository);
    final deleteSavedPostUseCase = DeleteSavedPostUseCase(localRepository, userRepository);

    final deletePostCommentUseCase = DeletePostCommentUseCase(localRepository, postRepository);
    obj = Dependencies(
      loginUseCase,
      myInfoUseCase,
      getUserByIdUseCase,
      myPostsUseCase,
      getUserPostsUseCase,
      myChallengesUseCase,
      getRankingUseCase,
      isLoggedInUseCase,
      myIdUseCase,
      checkUseCase,
      logoutUseCase,
      createTextPostUseCase,
      createImagePostUseCase,
      deletePostUseCase,
      setUserDescriptionUseCase,
      setUserInstagramUseCase,
      challengeSomeoneUseCase,
      getChallengeUseCase,
      getChallengeByIdUseCase,
      submitChallengeAnswersUseCase,
      getExplorePostsUseCase,
      getENEMQuestionsUseCase,
      getENEMQuestionsVideosUseCase,
      submitENEMGamesUseCase,
      createTriviaUseCase,
      submitUserFcmTokenUseCase,
      submitReportUseCase,
      getPostByIdUseCase,
      setUserPhoneUseCase,
      setUserDesiredCourseUseCase,
      setUserSchooleUseCase,
      updatePostRatingUseCase,
      updatePostCommentUseCase,
      searchPostsUseCase,
      savePostUseCase,
      getSavedPostsUseCase,
      deleteSavedPostUseCase,
      deletePostCommentUseCase
    );
    return obj;
  }
}
