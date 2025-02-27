import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

enum AnimatedSplashType { StaticDuration, BackgroundProcess }

class AnimatedSplash extends StatefulWidget {
  const AnimatedSplash({
    super.key,
    required this.logoText,
    this.imagePath,
    required this.home,
    required this.duration,
    required this.runfor,
  });

  final Widget home;
  final String? imagePath;
  final String logoText;
  final int duration;
  final AnimatedSplashType runfor;

  @override
  _AnimatedSplashState createState() => _AnimatedSplashState();
}

class _AnimatedSplashState extends State<AnimatedSplash>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 800));
    _animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInCirc,
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.reset();
  }

  navigator(home) {
    Navigator.of(context).pushReplacement(
        CupertinoPageRoute(builder: (BuildContext context) => home));
  }

  @override
  Widget build(BuildContext context) {
    widget.runfor == AnimatedSplashType.BackgroundProcess
        ? Future.delayed(Duration.zero).then((value) {
            Future.delayed(Duration(milliseconds: widget.duration)).then((value) {
              if (mounted) {
                Navigator.of(context).pushReplacement(CupertinoPageRoute(
                  builder: (BuildContext context) => widget.home));
              }              
            });
          })
        : Future.delayed(Duration(milliseconds: widget.duration)).then((value) {
            if (mounted) {
              Navigator.of(context).pushReplacement(
                  CupertinoPageRoute(builder: (BuildContext context) => widget.home));
            }
          });
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: FadeTransition(
        opacity: _animation,
        child: Container(
          width: size.width,
          height: size.height,
          alignment: Alignment.center,
          child: widget.imagePath != null
              ? Image.asset(
                  widget.imagePath!,
                  fit: BoxFit.fill,
                )
              : Text(
                  widget.logoText,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                    color: Colors.white,
                    height: 1.3,
                  ),
                  textAlign: TextAlign.center,
                ),
          ),
      ),
    );
  }
}
