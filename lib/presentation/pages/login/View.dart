import 'package:app/presentation/state/app_state.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'ViewModel.dart';

final List<String> imgList = [
  "assets/opinion0.jpeg",
  "assets/opinion1.jpeg",
  "assets/opinion2.jpeg",
  "assets/opinion3.jpeg"
];

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      StoreConnector<AppState, LoginViewModel>(
          converter: (store) => LoginViewModel.create(store),
          builder: (BuildContext context, LoginViewModel viewModel) {
            Widget child = CircularProgressIndicator();
            if (!viewModel.isLoading) {
              child = Column(children: [
                Expanded(
                  child: CarouselSlider(
                    autoPlay: true,
                    aspectRatio: 0.5,
                    viewportFraction: 1.0,
                    pauseAutoPlayOnTouch: Duration(seconds: 10),
                    items: imgList
                        .map((path) => new Image(
                              image: new AssetImage(path),
                            ))
                        .toList(),
                  ),
                ),
                SignInButton(Buttons.Facebook, text: "Entrar com Facebook",
                    onPressed: () async {
                  try {
                    final facebookLogin = FacebookLogin();
                    final result =
                        await facebookLogin.logInWithReadPermissions(['email']);
                    switch (result.status) {
                      case FacebookLoginStatus.loggedIn:
                        var token = result.accessToken.token;
                        viewModel.login(token, "facebook");
                        break;
                      case FacebookLoginStatus.cancelledByUser:
                        print("cancelled");
                        break;
                      case FacebookLoginStatus.error:
                        print("error");
                        print(result.errorMessage);
                        break;
                    }
                  } catch (e) {
                    print(e);
                  }
                })
              ]);
            }
            return Scaffold(
              body: Container(
                child: Center(child: child),
                color: new Color(0xFF0061A1),
                padding: EdgeInsets.all(8),
              ),
            );
          });
}
