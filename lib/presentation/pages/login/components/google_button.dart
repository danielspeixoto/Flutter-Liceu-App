part of login;

Container _googleButton() {
  return new Container(
    height: 40.00,
    width: 280.00,
    decoration: BoxDecoration(
      color: Color(0xfff3f3f3),
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
  );
}
