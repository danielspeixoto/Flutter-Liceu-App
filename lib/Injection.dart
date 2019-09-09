import 'package:http/http.dart' as http;

import 'data/LocalRepository.dart';
import 'data/LoginRepository.dart';
import 'data/UserRepository.dart';
import 'domain/usecase/IsLoggedInUseCase.dart';
import 'domain/usecase/LoginUseCase.dart';
import 'domain/usecase/MyInfoUseCase.dart';

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
final localRepository = LocalRepository();
final loginUseCase = LoginUseCase(loginRepository, localRepository);
final myInfoUseCase = MyInfoUseCase(userRepository, localRepository);
final isLoggedInUseCase = IsLoggedInUseCase(localRepository);
