import 'package:code_geeks/domain/login_check.dart';
import 'package:code_geeks/presentation/screens/homepage/homepage.dart';
import 'package:code_geeks/presentation/widgets/bnb.dart';
import 'package:flutter/material.dart';

class LoaderPage extends StatefulWidget {
  const LoaderPage({super.key});

  @override
  State<LoaderPage> createState() => _LoaderPageState();
}

class _LoaderPageState extends State<LoaderPage> {

  @override
  void initState() {
    goToHome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Column(
          children: [
            Image.asset('lib/assets/signup_loader.json')
          ],
        ),
      ),
    );
  }
  Future<void> goToHome() async{

    await Future.delayed(const Duration(milliseconds: 2900));
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement( MaterialPageRoute(builder:(ctx)=> BnbPage()));
  }
}