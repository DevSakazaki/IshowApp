import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ishowapp/home.dart';
import 'package:ishowapp/inputCustomizado.dart';
import 'package:ishowapp/home.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animacaoBlur;
  late Animation<double> _animacaoFade;
  late Animation<double> _animacaoSize;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));

    _animacaoBlur = Tween<double>(begin: 5, end: 0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.ease));

    _animacaoFade = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOutQuint));

    _animacaoSize = Tween<double>(begin: 0, end: 500).animate(
        CurvedAnimation(parent: _controller, curve: Curves.decelerate));

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    //timeDilation = 8;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              AnimatedBuilder(
                  animation: _animacaoBlur,
                  builder: (context, widget) {
                    return Container(
                      height: 400,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("images/fundo.png"),
                              fit: BoxFit.fill)),
                      child: BackdropFilter(
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                left: 10,
                                child: FadeTransition(
                                    opacity: _animacaoFade,
                                    child: Image.asset("images/detalhe1.png")),
                              ),
                              Positioned(
                                left: 40,
                                child: FadeTransition(
                                    opacity: _animacaoFade,
                                    child: Image.asset("images/detalhe2.png")),
                              )
                            ],
                          ),
                          filter: ImageFilter.blur(
                              sigmaX: _animacaoBlur.value,
                              sigmaY: _animacaoBlur.value)),
                    );
                  }),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Column(
                  children: <Widget>[
                    AnimatedBuilder(
                        animation: _animacaoSize,
                        builder: (context, widget) {
                          return Container(
                            width: _animacaoSize.value,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey[200]!,
                                      blurRadius: 15,
                                      spreadRadius: 4)
                                ]),
                            //LoginArea
                            child: Column(
                              children: const <Widget>[
                                InputCustomizado(
                                  hint: "Email",
                                  obscure: false,
                                  icon: Icon(Icons.person),
                                ),
                                InputCustomizado(
                                  hint: "Senha",
                                  obscure: true,
                                  icon: Icon(Icons.lock),
                                ),
                              ],
                            ),
                          );
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    AnimatedBuilder(
                        animation: _animacaoSize,
                        builder: (context, widget) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Home()
                                  )
                              );
                            },
                            child: Container(
                              width: _animacaoSize.value,
                              height: 50,
                              child: const Center(
                                child: Text(
                                  "Entrar",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: const LinearGradient(colors: [
                                    Color.fromRGBO(255, 100, 127, 1),
                                    Color.fromRGBO(255, 123, 145, 1)
                                  ])),
                            ),
                          );
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    FadeTransition(
                        opacity: _animacaoFade,
                        child: const Text(
                          "Esqueci Minha Senha!",
                          style: TextStyle(
                              color: Color.fromRGBO(255, 100, 127, 1),
                              fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
