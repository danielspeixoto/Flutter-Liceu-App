library login;

import 'package:app/presentation/pages/login/ViewModel.dart';
import 'package:app/presentation/state/actions/PageActions.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

part 'components/bottom.dart';
part 'components/dialogBackground.dart';
part 'components/appName.dart';
part 'service.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LoginViewModel>(
        onInit: (store) => store.dispatch(PageInitAction("Login")),
        converter: (store) => LoginViewModel.create(store),
        builder: (BuildContext context, LoginViewModel viewModel) {
          return Scaffold(
            body: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                new _DialogBackground(),
                _title(),
                Column(
                  children: <Widget>[
                    Spacer(flex: 40),
                    new _AppName(),
                    Spacer(flex: 364),
                    new _Bottom(viewModel),
                  ],
                ),
              ],
            ),
          );
        });
  }

  Positioned _title() {
    return Positioned(
      top: 150,
      child: new Text(
        "O QUE ESTÃO FALANDO\nDA GENTE?",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: "Poppins",
          fontWeight: FontWeight.w600,
          fontSize: 25,
          color: Color(0xff6c63ff),
        ),
      ),
    );
  }
}
