import 'package:http/http.dart' as http;

import 'data/LocalRepository.dart';
import 'data/LoginRepository.dart';
import 'domain/usecase/LoginUseCase.dart';

final baseURL =  "https://liceu-staging.herokuapp.com/v2";
final client = new http.Client();
final loginRepository = LoginRepository(
    baseURL + "/login",
    "2VsYHwfQKtjiAdLs8Z2fTLwuLpofSXWy",
    client
);
final localRepository = LocalRepository();
final loginUseCase = LoginUseCase(loginRepository, localRepository);
