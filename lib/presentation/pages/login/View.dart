library login;

import 'dart:io';
import 'dart:typed_data';

import 'package:app/presentation/state/actions/PageActions.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:app/presentation/widgets/TextFieldHighlight.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:path_provider/path_provider.dart';
import 'ViewModel.dart';

part 'components/facebook_button.dart';
part 'components/google_button.dart';

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
  Widget build(BuildContext context) =>
      StoreConnector<AppState, LoginViewModel>(
          onInit: (store) => store.dispatch(PageInitAction("Login")),
          converter: (store) => LoginViewModel.create(store),
          builder: (BuildContext context, LoginViewModel viewModel) {
            Widget child = CircularProgressIndicator(
              backgroundColor: Colors.white,
            );
            /*if (!viewModel.isLoading) {
              child = Column(children: [
                //_slider(),
                //_contentOld(viewModel, context),
                new Spacer(),
                //_content(),
              ]);
            }*/
            return Scaffold(
              body: Container(),
              floatingActionButton: new FloatingActionButton(
                child: new Icon(Icons.home),
                onPressed: null,
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
              bottomNavigationBar: BottomAppBar(
                child: new Container(height: 60),
                color: Colors.red,
                notchMargin: 10,
                shape: CircularNotchedRectangle(),
              ),
            );
          });

  Expanded _slider() {
    return Expanded(
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
    );
  }

  Container _content() {
    return new Container(
      height: 190.00,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xfff3f3f3),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.00),
          topRight: Radius.circular(20.00),
        ),
      ),
      child: new Column(
        children: <Widget>[
          Spacer(flex: 42),
          _facebookButton(),
          Spacer(flex: 16),
          _googleButton(),
          Spacer(flex: 16),
          new Text(
            "Termos de Uso",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "SF Pro Display",
              fontWeight: FontWeight.w600,
              fontSize: 10,
              color: Color(0xff5e5e5e),
            ),
          ),
          Spacer(flex: 21),
        ],
      ),
    );
  }

  Container _contentOld(LoginViewModel viewModel, BuildContext context) {
    return Container(
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
          Container(
            key: Key("facebookLogin"),
            child: SignInButton(Buttons.Facebook,
                text: "Entrar com Facebook",
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                onPressed: () async {
              if (DotEnv().env['ENV'] == "staging") {
                viewModel.login(
                  DotEnv().env['FACEBOOK_TOKEN'],
                  "facebook",
                );
                return;
              }
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
          ),
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
                                                    .onMessageTextChanged(text);
                                              },
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    width: 0.1,
                                                  ),
                                                ),
                                                hintText:
                                                    "Escreva sua mensagem",
                                              ),
                                              maxLines: 4,
                                              keyboardType:
                                                  TextInputType.multiline,
                                              capitalization:
                                                  TextCapitalization.sentences,
                                            ),
                                            ListTile(
                                              title: Center(
                                                child: Text(
                                                  "Enviar",
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              onTap: () {
                                                Navigator.of(context).pop();
                                                viewModel
                                                    .onSendMessageButtonPressed(
                                                        runtimeType.toString(),
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width
                                                            .toString(),
                                                        MediaQuery.of(context)
                                                            .size
                                                            .height
                                                            .toString());
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
    );
  }
}
