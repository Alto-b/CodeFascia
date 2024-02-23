import 'package:code_geeks/application/user_bloc/user_bloc.dart';
import 'package:code_geeks/domain/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({
    super.key,
    required this.user,
  });

  final User? user;

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {

@override
void initState() {
    BlocProvider.of<UserBloc>(context).add(LoadUserEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {

        if(state is UserLoadedState){
          List<UserModel> data = state.userList;

          return Text("data[0].name");
          // return ListView.builder(
          //   itemCount: data.length,
          //   itemBuilder: (context,index){
          //    return Container(
          //     height: 200,width: 200,
          //   clipBehavior: Clip.antiAlias,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(30),
          //     color: Color.fromARGB(255, 110, 132, 214),
          //   ),
          //   child: GlassContainer(
          //     color: Colors.white.withOpacity(0.5),
          //     borderColor: Colors.white,
          //     height: 150,width: double.infinity,
          //     child: Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Container(
          //         height: 150,
          //         child: Column(
          //           children: [
          //              CircleAvatar(
          //               radius: 40,
          //               backgroundImage: NetworkImage(widget.user?.photoURL!??"")
          //             ),const SizedBox(height: 10,),
          //             Text(widget.user?.displayName??data[index].name,style: GoogleFonts.taiHeritagePro(fontWeight: FontWeight.w600,fontSize: 18),),                       
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          //   );
          //   // return Container(
          //   //   height: 300,width: 400,
          //   //   child: Text("data"));
          // }
          // );
        }
        else if(state is UserLoadingState){
          return Center(child: CircularProgressIndicator());
        }
        else if(state is UserErroState){
          return Text("error");
        }
        else{
          return Text("err");
        }
      },
    );
  }
}