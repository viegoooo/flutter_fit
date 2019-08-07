import 'package:flutter/material.dart';
import 'package:flutter_fit/page/welcome/login_or_register_page.dart';

/// WelcomePage 和 SplashPage 2选1
class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 2000));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);

    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        //动画结束后后跳转主界面
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginOrRegisterPage()),
                (route) => route == null);
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new FadeTransition(
      opacity: _animation,
      child: new Image.asset(
        'assets/images/splash.png',
        scale: 2.0,
        fit: BoxFit.cover,
      ),
    );
  }
}