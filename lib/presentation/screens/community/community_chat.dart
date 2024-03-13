import 'dart:io';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:code_geeks/application/image_picker_bloc/image_picker_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebasestorage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class CommunityPage extends StatelessWidget {
   CommunityPage({super.key});

   XFile? newImge;

  final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
  final DatabaseReference chatRef = FirebaseDatabase.instance.reference().child('community');
  TextEditingController _content = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final DatabaseReference chatRef = FirebaseDatabase.instance.reference().child('community');
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Community"),
        actions: [IconButton(onPressed: (){
          AdaptiveTheme.of(context).toggleThemeMode();
        }, icon: Icon(Icons.light_mode_outlined))],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: screenHeight - screenHeight/5,
              width: screenWidth,
              // color: Colors.greenAccent,
              child: StreamBuilder(
                stream: chatRef.onValue, 
                builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                    if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
                     Map<dynamic, dynamic> map = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
                          List<dynamic> list = map.values.toList();
                          list.forEach((chat) {
                            if (chat['dateTime'] is String) {
                              // Parse the ISO 8601 string to a DateTime object
                              chat['dateTime'] = DateTime.parse(chat['dateTime']);
                            }
                          });
                          list.sort((a, b) => b['dateTime'].compareTo(a['dateTime']));
                          list = list.reversed.toList();
                      return ListView.builder(
                        itemCount: snapshot.data!.snapshot.children.length,
                        itemBuilder: (context, index) {
                          return (list[index]['senderId']==user!.uid)?
                          //send bubble
                            ChatBubble(
                              clipper: ChatBubbleClipper1(type: BubbleType.sendBubble),
                              alignment: Alignment.topRight,
                              margin: EdgeInsets.only(top: 20),
                              backGroundColor: Colors.blue,
                              child: Container(
                                constraints: BoxConstraints(
                                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    (list[index]['content_type']=="text")?
                                    Text(
                                      list[index]['content'],
                                      style: TextStyle(color: Colors.white,fontSize: 18),
                                    ):
                                    Container(
                                      height: 100,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        image: DecorationImage(image: NetworkImage(list[index]['content']))
                                      ),
                                    )
                                    ,SizedBox(width: 10,),
                                    CircleAvatar(backgroundImage: NetworkImage(list[index]['avatar']),radius: 10,),
                                  ],
                                ),
                              ),
                            ):
                            //recieve bubble
                            ChatBubble(
                          clipper: ChatBubbleClipper1(type: BubbleType.receiverBubble),
                          backGroundColor: Color(0xffE7E7ED),
                          margin: EdgeInsets.only(top: 20),
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.7,
                            ),
                            child:Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CircleAvatar(backgroundImage: NetworkImage(list[index]['avatar']),radius: 10,),
                                    SizedBox(width: 10,),
                                    (list[index]['content_type']=="text")?
                                    Text(
                                      list[index]['content'],
                                      style: TextStyle(color: const Color.fromARGB(255, 3, 3, 3),fontSize: 18),
                                    ):
                                    Container(
                                      height: 100,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        image: DecorationImage(image: NetworkImage(list[index]['content']))
                                      ),
                                    )
                                    
                                  ],
                                ),
                          ),
                        );

                        },
                        );
                    } else if (snapshot.hasError) {
                      return Icon(Icons.error);
                    } else {
                      return Center(
                        child: Text("Chat responsibly ",style: GoogleFonts.orbitron(
                          fontSize: 15,fontWeight: FontWeight.w700,color: Colors.grey
                        ),),
                      );
                    }
                  },

                ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _content,
                 decoration: InputDecoration(
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(onPressed: (){
                      //     Map<String,dynamic> data = {
                      //     "senderId" : user!.uid,
                      //     "avatar" : user.photoURL.toString(),
                      //     "content_type" : "photo",
                      //     "content" : _content.text.trim(),
                      //     "dateTime" : DateTime.now().toIso8601String()
                      // };
                          _imagePickerDialog(context);
                        }, icon: Icon(Icons.photo_outlined)),
                        IconButton(onPressed: (){
                          Map<String,dynamic> data = {
                          "senderId" : user!.uid,
                          "avatar" : user.photoURL.toString(),
                          "content_type" : "text",
                          "content" : _content.text.trim(),
                          "dateTime" : DateTime.now().toIso8601String()
                      };
                          sendMessage(context,data);
                        }, icon: Icon(Icons.send)),
                      ],
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  )
                 ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _imagePickerDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible:true,
    builder: (BuildContext context) {
      return AlertDialog(
        // title: const Text('AlertDialog Title'),
        content:  SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              BlocBuilder<ImagePickerBloc, ImagePickerState>(
                builder: (context, state) {
                  print(state.runtimeType);
                  if(state.file==null){
                        return InkWell(
                          onTap: () {
                            context.read<ImagePickerBloc>().add(GalleryPicker());
                            newImge = state.file;
                            
                          },
                          child: const CircleAvatar(child:  Icon(Icons.add_a_photo),),
                        );
                      }
                      else{
                        return Column(
                          children: [
                            GestureDetector(
                                    onTap: () {
                                      context.read<ImagePickerBloc>().add(GalleryPicker());
                                      newImge = state.file;
                                    },
                                    child: CircleAvatar(
                                         radius: 60,
                                     // child: Image.file(File(state.file!.path.toString()))
                                      backgroundImage: FileImage(File(state.file!.path.toString()))
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                            IconButton(onPressed: (){
                              sendImage(state.file!.path);
                            }, icon: Icon(Icons.send))
                          ],
                        );
                      }
                },
              )
            ],
          ),
        ),
        // actions: <Widget>[
        //   IconButton(onPressed: (){}, icon: Icon(Icons.send))
        // ],
      );
    },
  );
}

void sendImage(String newImg)async{
  File file = File(newImg);
   if (!file.existsSync()) {
    print("Error: File does not exist");
    return;
  }

  // String fileName = basename(newImg);
  firebasestorage.Reference ref = firebasestorage.FirebaseStorage.instance.ref("file${FirebaseAuth.instance.currentUser!.uid}");
  firebasestorage.UploadTask uploadTask = ref.putFile(file);
  try{
    await uploadTask;
    var downloadUrl = await ref.getDownloadURL();
    print("image link $downloadUrl");
    Map<String,dynamic> data = {
                          "senderId" :FirebaseAuth.instance.currentUser!.uid,
                          "avatar" : FirebaseAuth.instance.currentUser!.photoURL,
                          "content_type" : "photo",
                          "content" : downloadUrl,
                          "dateTime" : DateTime.now().toIso8601String()
                      };
       databaseReference.child('community').push().set(data).whenComplete((){
      print("snd success");
      _content.clear();
}) ;
  }
  on FirebaseException catch(e){

  }
}
  
  void sendMessage(BuildContext context,Map<String,dynamic> data) {
      databaseReference.child('community').push().set(data).whenComplete((){
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("done")));
      _content.clear();
}) ;
  }
}