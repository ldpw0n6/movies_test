import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_test/src/commons/widgets/text_title.dart';

import '../../commons/utils/constants.dart';
import '../../router/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(Images.homeBackground, fit: BoxFit.cover),
          Container(color: Colors.black45),
          SafeArea(
              child: Column(
            children: [
              const SizedBox(height: 20),
              const TextTitle(title: Constants.homeScreenTitle),
              const Spacer(),
              const SizedBox(
                width: 250,
                child: Text(
                  Constants.slogan,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      shadows: [
                        Shadow(color: Colors.black, offset: Offset(1, 2))
                      ]),
                ),
              ),
              const SizedBox(height: 40),
              CupertinoButton(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(50),
                onPressed: () {
                  GoRouter.of(context).pushReplacementNamed(Routes.movies);
                },
                child: const Text(Constants.enter),
              ),
              const SizedBox(height: 20),
            ],
          ))
        ],
      ),
    );
  }
}
