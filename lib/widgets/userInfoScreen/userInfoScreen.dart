import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:search_user_repo/search_user_repo.dart';

class UserInfoScreen extends StatelessWidget {
  const UserInfoScreen({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          user.username ?? '',
          style: TextStyle(fontSize: 24),
        ),
      ),
      body: Column(
        children: [
          Hero(
              tag: user.username ?? 'NoName',
              child: Container(
                width: double.infinity,
                height: 280,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(user.images ?? ''), fit: BoxFit.cover),
                ),
              )),
          Text.rich(TextSpan(style: TextStyle(fontSize: 26), children: [
            TextSpan(text: 'link to user website => '),
            TextSpan(
                text: user.url ?? '',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.blueAccent,
                ),
                recognizer: TapGestureRecognizer()..onTap = () {}),
          ]))
        ],
      ),
    );
  }
}
