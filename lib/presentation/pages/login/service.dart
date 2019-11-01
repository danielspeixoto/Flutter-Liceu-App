part of login;

const String _documentPath = 'assets/therms-and-conditions.pdf';

_onTapGoogle(LoginViewModel viewModel) async {
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
}

_onTapFacebook(LoginViewModel viewModel) async {
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
}

_onTapTerms(context) {
  _prepareTestPdf(context).then((pdfPath) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PDFViewerScaffold(
              appBar: AppBar(
                title: Text("Termos de Uso"),
              ),
              path: pdfPath)),
    );
  });
}

Future<String> _prepareTestPdf(context) async {
  final ByteData bytes =
      await DefaultAssetBundle.of(context).load(_documentPath);
  final Uint8List list = bytes.buffer.asUint8List();

  final tempDir = await getTemporaryDirectory();
  final tempDocumentPath = '${tempDir.path}/$_documentPath';

  final file = await File(tempDocumentPath).create(recursive: true);
  file.writeAsBytesSync(list);
  return tempDocumentPath;
}
