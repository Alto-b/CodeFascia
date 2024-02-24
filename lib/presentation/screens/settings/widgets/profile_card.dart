import 'package:code_geeks/application/user_bloc/user_bloc.dart';
import 'package:code_geeks/domain/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({
    super.key,
    // required this.user,
  });

  // final User? user;

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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final currUser = FirebaseAuth.instance.currentUser;
    
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {

        if(state is UserLoadedState){
          // List<UserModel> data = state.userList;
          UserModel data = state.userList;
            return Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              height: screenHeight/7,
              width: screenWidth-50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50)
              ),
              child: GlassContainer(
                color: Colors.transparent,
                borderColor: Colors.transparent,
                height: 150,width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
              
                  child: Container(
                    height: 150,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: 10,),
                         CircleAvatar(
                          radius: 40,
                          backgroundImage:NetworkImage(currUser?.photoURL ?? data.profile),
                        ),
                        const SizedBox(width: 20,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(currUser?.displayName ?? data.name,style: GoogleFonts.taiHeritagePro(fontWeight: FontWeight.w600,fontSize: 18),),
                            // Text(widget.user?.displayName??data.name,style: GoogleFonts.taiHeritagePro(fontWeight: FontWeight.w600,fontSize: 18),),
                            Text(currUser?.email ?? data.email,style: GoogleFonts.taiHeritagePro(fontWeight: FontWeight.w600,fontSize: 18),),
                          ],
                        ),                       
                      ],
                    ),
                  ),
              
                ),
              ),
            );
        }
        else if(state is UserLoadingState){
          return Center(child: Lottie.asset('lib/assets/loader.json',height: 80,width: 80));
        }
        else if(state is UserErroState){
          return const Text("error");
        }
        else{
          return const Text("err");
        }
      },
    );
  }
}