part of login;

class _DialogBackground extends StatefulWidget {
  const _DialogBackground({
    Key key,
  }) : super(key: key);

  @override
  __DialogBackgroundState createState() => __DialogBackgroundState();
}

class __DialogBackgroundState extends State<_DialogBackground>
    with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;
  @override
  void initState() {
    animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 800));
    animation = new Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));
    Future.delayed(Duration(seconds: 2)).whenComplete(() {
      animationController.forward();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new AnimatedBuilder(
      animation: animation,
      builder: (_, widget) {
        return Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            new Container(
              height: 133.21 +
                  ((MediaQuery.of(context).size.height - 133.21) *
                      animation.value),
              width: 165.58 +
                  ((MediaQuery.of(context).size.width - 165.58) *
                      animation.value),
              decoration: BoxDecoration(
                color: Color(0xff6c63ff),
                borderRadius:
                    BorderRadius.circular(8.00 - (8 * animation.value)),
              ),
            ),
            Positioned(
              bottom: -22,
              right: 5,
              child: new ClipPath(
                clipper: TriangleClipper(),
                child: new Container(
                  height: 25,
                  width: 25,
                  color: Color(0xff6c63ff),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.moveTo(size.width * 0.9, 0);
    path.lineTo(0, 0);
    path.lineTo(size.width, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
