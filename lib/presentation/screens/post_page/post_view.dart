import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SpecificPostView extends StatelessWidget {
   SpecificPostView({
    super.key,
    required this.title,
    required this.author,
    required this.author_avatar,
    required this.content,
    required this.description
    });

    String title;
    String author;
    String author_avatar;
    String description;
    String content;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios)),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,style: GoogleFonts.poppins(
                fontSize: 35,
                fontWeight: FontWeight.w600
              ),),
              Row(
                children: [
                  CircleAvatar(backgroundImage: NetworkImage(author_avatar),),
                  SizedBox(width: 5,),
                  Text(author,style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w500
                  ),),
                ],
              ),
              SizedBox(height: 20,),
              Text(description),
              SizedBox(height: 20,),
              Text(content),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
      
    );
  }
}