import 'package:CodeFascia/application/gemini_bloc/gemini_bloc.dart';
import 'package:CodeFascia/domain/gemini_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class GeminiPage extends StatelessWidget {
  GeminiPage({super.key});

  TextEditingController textEditingController = TextEditingController();
  final GeminiBloc geminiBloc = GeminiBloc();

  ScrollController chatScrollController = ScrollController();

  void scrollToBottom() {
    if (chatScrollController.hasClients) {
      final position = chatScrollController.position.maxScrollExtent;
      chatScrollController.animateTo(position,
          duration: const Duration(seconds: 1), curve: Curves.easeOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GeminiBloc, GeminiState>(
      bloc: geminiBloc,
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.runtimeType) {
          case GeminiSuccessState:
            List<GeminiMessageModel> messages =
                (state as GeminiSuccessState).messages;
            return Scaffold(
                appBar: AppBar(
                  actions: [
                    // IconButton(onPressed: (){scrollToBottom();}, icon: const Icon(Icons.abc))
                  ],
                ),
                extendBodyBehindAppBar: true,
                body: Container(
                  width: MediaQuery.of(context).size.width,
                  height: double.maxFinite,
                  decoration: const BoxDecoration(
                      // color: Colors.red,
                      ),
                  child: Column(
                    children: [
                      Expanded(
                          child: ListView.builder(
                              itemCount: messages.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      width: 10,
                                      decoration: BoxDecoration(
                                        color: messages[index].role == "user"
                                            ? const Color(0XFF04A3FF)
                                                .withOpacity(.4)
                                            : const Color.fromARGB(
                                                    255, 79, 79, 79)
                                                .withOpacity(.5),
                                        borderRadius: messages[index].role ==
                                                "user"
                                            ? const BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(50),
                                                topLeft: Radius.circular(50),
                                                bottomLeft: Radius.circular(50))
                                            : const BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(50),
                                                // bottomLeft: Radius.circular(50),
                                                topLeft: Radius.circular(50),
                                                topRight: Radius.circular(50)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Text(
                                              messages[index].role == "user"
                                                  ? "You"
                                                  : "AI",
                                            ),
                                            Text(
                                              messages[index].parts.first.text,
                                            ),
                                          ],
                                        ),
                                      )),
                                );
                              })),
                      if (geminiBloc.generating)
                        SizedBox(
                            width: 80,
                            height: 80,
                            child: Lottie.asset('lib/assets/loader.json')),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 30, horizontal: 16),
                        child: Stack(
                          children: [
                            TextField(
                              controller: textEditingController,
                              // style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  prefixIcon: Image.asset(
                                    'lib/assets/logo.png',
                                    width: 15,
                                    height: 15,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.green),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  fillColor: Colors.transparent,
                                  filled: true,
                                  hintText: "Ask me something",
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: BorderSide(
                                          color:
                                              Theme.of(context).primaryColor))),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Positioned(
                              right: 0,
                              bottom: 1,
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.transparent,
                                child: IconButton(
                                    onPressed: () {
                                      if (textEditingController
                                          .text.isNotEmpty) {
                                        String text =
                                            textEditingController.text;
                                        textEditingController.clear();
                                        geminiBloc.add(
                                            ChatGenerateNewTextMessageEvent(
                                                inputMessage: text));
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.send,
                                      // color: Colors.blue,
                                    )),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ));
          default:
            return const SizedBox();
        }
      },
    );
  }
}
