part of login;

class _AppName extends StatefulWidget {
  const _AppName({
    Key key,
  }) : super(key: key);

  @override
  __AppNameState createState() => __AppNameState();
}

class __AppNameState extends State<_AppName>
    with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;
  @override
  void initState() {
    animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 500));
    animation = new ColorTween(begin: Colors.black, end: Colors.white)
        .animate(animationController);
    Future.delayed(Duration(seconds: 2)).whenComplete(() {
      animationController.forward();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (_, widget) {
        return new Text(
          "Liceu",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "Vegan Style Personal Use",
            fontSize: 37,
            color: animation.value,
          ),
        );
      },
    );
  }
}
