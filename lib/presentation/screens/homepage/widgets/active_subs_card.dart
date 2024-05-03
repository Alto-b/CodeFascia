import 'package:CodeFascia/application/subscription_bloc/subscription_bloc.dart';
import 'package:CodeFascia/presentation/screens/homepage/widgets/subs_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class active_subs_card extends StatelessWidget {
  const active_subs_card({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Active Subscriptions",style: GoogleFonts.poppins(
                fontSize: 15,fontWeight: FontWeight.w600,
              ),),
              const SizedBox(width: 15,),
              BlocBuilder<SubscriptionBloc, SubscriptionState>(
                builder: (context, state) {
                  if(state is MySubscritpionsLoadedState){
                    return CircleAvatar(
                      backgroundColor: Colors.white,
                    radius: 10,
                     child: Text(state.mySubsList.length.toString()),
                   );
                  }
                  return const SizedBox();
                },
              )
            ],
          ),
          const SizedBox(height: 10,),
          const OngoingSubsSlider(),
          const SizedBox(height: 20,),
        ],
      ),
    ));
  }
}
