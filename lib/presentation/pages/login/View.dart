import 'dart:io';
import 'dart:typed_data';

import 'package:app/injection.dart';
import 'package:app/presentation/state/actions/PageActions.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:app/presentation/widgets/TextFieldHighlight.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:path_provider/path_provider.dart';

import 'ViewModel.dart';

final List<String> imgList = [
  "assets/opinion0.jpeg",
  "assets/opinion1.jpeg",
  "assets/opinion2.jpeg",
  "assets/opinion3.jpeg"
];

const String _documentPath = 'assets/therms-and-conditions.pdf';

class LoginPage extends StatelessWidget {
  Future<String> prepareTestPdf(context) async {
    final ByteData bytes =
        await DefaultAssetBundle.of(context).load(_documentPath);
    final Uint8List list = bytes.buffer.asUint8List();

    final tempDir = await getTemporaryDirectory();
    final tempDocumentPath = '${tempDir.path}/$_documentPath';

    final file = await File(tempDocumentPath).create(recursive: true);
    file.writeAsBytesSync(list);
    return tempDocumentPath;
  }

  @override
  Widget build(BuildContext context) => StoreConnector<AppState,
          LoginViewModel>(
      onInit: (store) => store.dispatch(PageInitAction("Login")),
      converter: (store) => LoginViewModel.create(store),
      builder: (BuildContext context, LoginViewModel viewModel) {
        Widget child = CircularProgressIndicator(
          backgroundColor: Colors.white,
        );
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
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(64)),
                shape: BoxShape.rectangle,
                color: Colors.white,
              ),
              width: double.infinity,
              padding: EdgeInsets.all(8),
              child: Column(
                children: <Widget>[
                  SignInButton(
                    Buttons.GoogleDark,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                    text: "Entrar com Google",
                    onPressed: () async {
                      GoogleSignIn _googleSignIn = GoogleSignIn(
                        scopes: [
                          'email',
                          "profile",
                          "https://www.googleapis.com/auth/userinfo.profile"
                        ],
                      );
                      final account = await _googleSignIn.signIn();
                      final auth = (await account.authentication);
                      final accessToken = auth.accessToken;
                      viewModel.login(accessToken, "google");
                    },
                  ),
                  SignInButton(Buttons.Facebook,
                      text: "Entrar com Facebook",
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                      onPressed: () async {
                    try {
                      final facebookLogin = FacebookLogin();
                      final result = await facebookLogin.logIn(['email']);
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
                  }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: viewModel.isReportLoginFeatureReady
                            ? FlatButton(
                                onPressed: () => {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return SimpleDialog(
                                          title: Text("Fale conosco"),
                                          children: <Widget>[
                                            Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 24),
                                                child: Column(
                                                  children: <Widget>[
                                                    TextFieldHighlight(
                                                      onChanged: (text) {
                                                        viewModel
                                                            .onMessageTextChanged(
                                                                text);
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            width: 0.1,
                                                          ),
                                                        ),
                                                        hintText:
                                                            "Escreva sua mensagem",
                                                      ),
                                                      maxLines: 4,
                                                      keyboardType:
                                                          TextInputType
                                                              .multiline,
                                                    ),
                                                    ListTile(
                                                      title: Center(
                                                        child: Text(
                                                          "Enviar",
                                                        ),
                                                      ),
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                        viewModel
                                                            .onSendMessageButtonPressed();
                                                      },
                                                    ),
                                                  ],
                                                )),
                                          ],
                                        );
                                      })
                                },
                                child: const Text(
                                  'Fale conosco',
                                  style: TextStyle(
                                      color: Color(0xFF0061A1),
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            : null,
                      ),
                      Container(
                        alignment: Alignment.bottomRight,
                        child: FlatButton(
                          onPressed: () => {
                            // We need to prepare the test PDF, and then we can display the PDF.
                            prepareTestPdf(context).then((pdfPath) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PDFViewerScaffold(
                                        appBar: AppBar(
                                          title: Text("Termos de Uso"),
                                        ),
                                        path: pdfPath)),
                              );
                            })
                          },
                          child: const Text('Termos de Uso',
                              style: TextStyle(
                                  color: Color(0xFF0061A1),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ]);
        }
        return Scaffold(
          body: Container(
            child: Center(child: child),
            color: Color(0xFF0061A1),
          ),
        );
      });
}
