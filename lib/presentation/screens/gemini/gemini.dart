import 'package:code_geeks/application/gemini_bloc/gemini_bloc.dart';
import 'package:code_geeks/domain/gemini_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class GeminiPage extends StatelessWidget {
   GeminiPage({super.key});

  TextEditingController textEditingController = TextEditingController();
  final GeminiBloc geminiBloc = GeminiBloc();
  

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GeminiBloc, GeminiState>(
      bloc: geminiBloc,
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case GeminiSuccessState:
            List<GeminiMessageModel> messages = (state as GeminiSuccessState).messages;
            return Scaffold(
          appBar: AppBar(),
    
          body:Container(
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: [
                // Container(
                //   height: 120,
                //   color: Colors.red,
                // ),
                Expanded(child: 
                ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 25,
                      // margin: EdgeInsets.only(bottom: 12),
                      // padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.grey,
                        
                      ),
                      child: Column(
                        children: [
                          Text(messages[index].role == "user"?"user":"ai",),
                          Text(messages[index].parts.first.text,),
                        ],
                      )),
                  );
                })),
                if(geminiBloc.generating)
                Container(
                  width: 80,height: 80,
                  child: Lottie.asset('lib/assets/loader.json')),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 30,horizontal: 16),
    
                  child: Stack(
                    children: [
                      TextField(
                        controller: textEditingController,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                            borderRadius: BorderRadius.circular(100),
                          ),fillColor: Colors.white,filled: true,hintText: "Ask me something",
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide(color: Theme.of(context).primaryColor)
                          )
                        ),
                      ),
                      SizedBox(width: 12,),
                      Positioned(
                        right: 10,
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.transparent,
                          child: IconButton(onPressed: (){
                            if(textEditingController.text.isNotEmpty){
                              String text = textEditingController.text;
                              textEditingController.clear();
                              geminiBloc.add(ChatGenerateNewTextMessageEvent(inputMessage: text));
                            }
                          }, icon: Icon(Icons.send,color: Colors.blue,)),
                        ),
                      )
                      
                    ],
                  ),
                )
              ],
            ),
          )
        );
          default:
        return SizedBox();
        }
      },
    );
  }
}