import 'package:app/domain/usecase/user/IsLoggedInUseCase.dart';
import 'package:app/domain/usecase/user/LogOutUseCase.dart';
import 'package:app/domain/usecase/user/LoginUseCase.dart';
import 'package:app/domain/usecase/user/MyInfoUseCase.dart';
import 'package:http/http.dart' as http;

import 'data/LocalRepository.dart';
import 'data/LoginRepository.dart';
import 'data/PostRepository.dart';
import 'data/UserRepository.dart';
import 'domain/usecase/post/CreatePostUseCase.dart';
import 'domain/usecase/user/MyPostsUseCase.dart';
import 'domain/usecase/user/SetUserDescriptionUseCase.dart';
import 'domain/usecase/user/SetUserInstagramUseCase.dart';

final baseURL = "https://liceu-staging.herokuapp.com/v2";
final apiKey = "2VsYHwfQKtjiAdLs8Z2fTLwuLpofSXWy";
//final baseURL = "https://protected-river-16209.herokuapp.com/v2";
//final apiKey = "8y/B?E(H+MbQeThWmYq3t6w9z\$C&F)J@";

final client = new http.Client();
// Repositories
final loginRepository = LoginRepository(baseURL + "/login", apiKey);
final userRepository = UserRepository(baseURL + "/user", apiKey);
final postRepository = PostRepository(baseURL + "/post", apiKey);
final localRepository = LocalRepository();
// Use Cases
final loginUseCase = LoginUseCase(loginRepository, localRepository);
final myInfoUseCase = MyInfoUseCase(userRepository, localRepository);
final myPostsUseCase = MyPostsUseCase(localRepository, userRepository);
final isLoggedInUseCase = IsLoggedInUseCase(localRepository);
final logoutUseCase = LogOutUseCase(localRepository);
final createPostUseCase = CreatePostUseCase(localRepository, postRepository);
final setUserDescriptionUseCase =
    SetUserDescriptionUseCase(localRepository, userRepository);
final setUserInstagramUseCase =
    SetUserInstagramUseCase(localRepository, userRepository);
