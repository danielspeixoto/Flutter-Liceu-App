part of login;

class _Bottom extends StatelessWidget {
  final LoginViewModel viewModel;
  const _Bottom(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 190.00,
      width: double.infinity,
      decoration: _bottomDecoration(),
      child: new Column(
        children: <Widget>[
          Spacer(flex: 42),
          _facebookButton(),
          Spacer(flex: 16),
          _googleButton(),
          Spacer(flex: 16),
          _terms(context),
          Spacer(flex: 21),
        ],
      ),
    );
  }

  BoxDecoration _bottomDecoration() {
    return BoxDecoration(
      color: Color(0xfffafafa),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.00),
        topRight: Radius.circular(20.00),
      ),
    );
  }

  InkWell _googleButton() {
    return InkWell(
      onTap: () async {
        _onTapGoogle(viewModel);
      },
      child: new Container(
        height: 40.00,
        width: 280.00,
        decoration: BoxDecoration(
          color: Color(0xfffafafa),
          boxShadow: [
            BoxShadow(
              offset: Offset(0.00, 0.00),
              color: Color(0xff000000).withOpacity(0.20),
              blurRadius: 6,
            ),
          ],
          borderRadius: BorderRadius.circular(10.00),
        ),
        alignment: Alignment.center,
        child: new Text(
          "Entrar com Google",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "SF Pro Display",
            fontWeight: FontWeight.w500,
            fontSize: 15,
            color: Color(0xff5e5e5e),
          ),
        ),
      ),
    );
  }

  InkWell _facebookButton() {
    return InkWell(
      onTap: () {
        _onTapFacebook(viewModel);
      },
      child: new Container(
        height: 40.00,
        width: 280.00,
        decoration: BoxDecoration(
          color: Color(0xff6c63ff),
          boxShadow: [
            BoxShadow(
              offset: Offset(0.00, 0.00),
              color: Color(0xff000000).withOpacity(0.20),
              blurRadius: 6,
            ),
          ],
          borderRadius: BorderRadius.circular(10.00),
        ),
        alignment: Alignment.center,
        child: new Text(
          "Entrar com Facebook",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "SF Pro Display",
            fontWeight: FontWeight.w500,
            fontSize: 15,
            color: Color(0xffffffff),
          ),
        ),
      ),
    );
  }

  InkWell _terms(context) {
    return InkWell(
      onTap: () {
        _onTapTerms(context);
      },
      child: new Text(
        "Termos de Uso",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: "SF Pro Display",
          fontWeight: FontWeight.w600,
          fontSize: 12,
          color: Color(0xff5e5e5e),
        ),
      ),
    );
  }
}
