import 'package:http/http.dart' as http;

import 'data/LocalRepository.dart';
import 'data/LoginRepository.dart';
import 'data/PostRepository.dart';
import 'data/UserRepository.dart';
import 'package:app/domain/usecase/user/IsLoggedInUseCase.dart';
import 'package:app/domain/usecase/user/LoginUseCase.dart';
import 'package:app/domain/usecase/user/MyInfoUseCase.dart';

import 'domain/usecase/post/CreatePostUseCase.dart';

final baseURL =  "https://liceu-staging.herokuapp.com/v2";
final client = new http.Client();
final loginRepository = LoginRepository(
    baseURL + "/login",
    "2VsYHwfQKtjiAdLs8Z2fTLwuLpofSXWy",
    client
);
final userRepository = UserRepository(
    baseURL + "/user",
    "2VsYHwfQKtjiAdLs8Z2fTLwuLpofSXWy",
    client
);
final postRepository = PostRepository(
    baseURL + "/post",
    "2VsYHwfQKtjiAdLs8Z2fTLwuLpofSXWy"
);
final localRepository = LocalRepository();
final loginUseCase = LoginUseCase(loginRepository, localRepository);
final myInfoUseCase = MyInfoUseCase(userRepository, localRepository);
final isLoggedInUseCase = IsLoggedInUseCase(localRepository);
final createPostUseCase = CreatePostUseCase(localRepository, postRepository);
