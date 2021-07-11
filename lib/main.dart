import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation bgColor, textColor;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    bgColor = ColorTween(begin: Colors.transparent, end: Colors.white)
        .animate(animationController);
    textColor = ColorTween(begin: Colors.white, end: Colors.blue)
        .animate(animationController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[100],
        body: NotificationListener<ScrollNotification>(
          onNotification: scrollNotification,
          child: Stack(
            children: [
              // NOTE: content
              SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset(
                      "assets/banner.jpeg",
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      height: 900,
                      color: Colors.teal,
                    )
                  ],
                ),
              ),
              // NOTE: custom appbar
              CustomAppBar(
                animationController: animationController,
                bgColor: bgColor,
                textColor: textColor,
              )
            ],
          ),
        ),
      ),
    );
  }

  bool scrollNotification(ScrollNotification notification) {
    bool scroll = false;
    if (notification.metrics.axis == Axis.vertical) {
      animationController.animateTo(notification.metrics.pixels / 70);
    }

    return scroll;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
    required this.animationController,
    required this.bgColor,
    required this.textColor,
  }) : super(key: key);

  final AnimationController animationController;
  final Animation bgColor;
  final Animation textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return AppBar(
            backgroundColor: bgColor.value,
            elevation: 0,
            title: Text(
              "Home",
              style: TextStyle(
                color: textColor.value,
              ),
            ),
          );
        },
      ),
    );
  }
}
