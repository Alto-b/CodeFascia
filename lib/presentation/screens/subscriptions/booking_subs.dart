import 'package:cached_network_image/cached_network_image.dart';
import 'package:code_geeks/application/subscription_bloc/subscription_bloc.dart';
import 'package:code_geeks/presentation/screens/subscriptions/subscriptions.dart';
import 'package:code_geeks/presentation/widgets/bnb.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class SubscriptionBookingPage extends StatefulWidget {
   SubscriptionBookingPage({super.key,required this.subId});

  final subId;

  @override
  State<SubscriptionBookingPage> createState() => _SubscriptionBookingPageState();
}

class _SubscriptionBookingPageState extends State<SubscriptionBookingPage> {

  List<String> plans = ["Basic","Standard","Premium"];

  List<Color> tilebg = [
    Color.fromARGB(195, 76, 175, 79),
    Color.fromARGB(182, 255, 235, 59),
    Color.fromARGB(177, 33, 149, 243)
  ];

  List<int> duration = [3,7,30];

  Razorpay? _razorpay;

   @override
  void initState(){
    _razorpay = Razorpay();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response){
    Fluttertoast.showToast(msg: "Payment successful ${response.orderId}");
  }

  void _handlePaymentError(PaymentFailureResponse response){
    Fluttertoast.showToast(msg: "Payment Failed ${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response){
    Fluttertoast.showToast(msg: "External wallet is  ${response.walletName}");
  }

  void makePayments(
    SubscriptionState state,
    // String amount,
    // String name,
    // String subscription,
    // String prefill
    Map<String,dynamic> ops
    )async{
    var options ={
                      'key' : 'rzp_test_om7emjnNEbQYMJ',
                      'amount' : ops['amount'],
                      'name' : ops['name'],
                      'subscritpion' : ops['subscriptions'],
                      'prefill' : ops['prefill']
                    };
      try{
        _razorpay?.open(options);
      }
      catch(e){
        debugPrint(e.toString());
      }
  }

  @override
  Widget build(BuildContext context) {
    context.read<SubscriptionBloc>().add(SpecificSubsLoadEvent(SubsId:widget.subId));
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<SubscriptionBloc, SubscriptionState>(
      builder: (context, state) {
        print(state.runtimeType);
        if(state is SpecificSubsLoadedState){
          return Scaffold(
            appBar: AppBar(),
            body:  SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Text(state.specSubsList[0].title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                            Text(state.specSubsList[0].language)
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text("Select a plan to proceed",style: GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.w600),),
                      Container(
                        height: screenHeight-30,
                        width: screenWidth,
                        child: ListView.builder(
                          itemCount: 3,
                          itemBuilder: (context, index) {
                           return  Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Card(
                              elevation: 5,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                               child: Container(
                                height: screenHeight/7,
                                width: screenWidth-30,
                                decoration: BoxDecoration(
                                  // borderRadius: BorderRadius.circular(30),
                                  // border: Border.all(width: 0.5)
                                  border: Border.all(
                                    color: tilebg[index]
                                  )
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: ListTile(
                                  onTap: () {
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Long press to confirm "),backgroundColor: Colors.green,));
                                  },
                                  onLongPress: () {
                                    //  makePayment() async{
                                            var options ={
                                              'key' : 'rzp_test_om7emjnNEbQYMJ',
                                              'amount' : '${(int.parse(state.specSubsList[0].amount) * duration[index]*100)}',
                                              'name' : '${FirebaseAuth.instance.currentUser!.displayName}',
                                              'subscritpion' : '${state.specSubsList[0].title}',
                                              'prefill' : '${FirebaseAuth.instance.currentUser?.email}'
                                            };
                                    //         try{

                                    //         }
                                    //         catch(e){

                                    //         }
                                    //       }
                                    makePayments(state,options);
                                  },
                                  splashColor: Colors.white54,
                                  // tileColor:tilebg[index],
                                  title: Text(plans[index],style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500),),
                                  subtitle: Text("Duration : ${duration[index]} days",style: TextStyle(
                                        fontSize: 20
                                      ),),
                                  trailing: Text("₹ ${int.parse(state.specSubsList[0].amount) * duration[index]}",style: TextStyle(
                                    fontSize: 20,fontWeight: FontWeight.w500
                                  ),),
                                ),
                                                        ),
                             ),
                           );  
                          },
                          
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          );
        }
  
        return Scaffold(
          body: Center(child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Some issue has happended"),
              IconButton(onPressed: (){
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => BnbPage(),), (route) => false);
              }, icon: const Icon(Icons.arrow_back_ios))
            ],
          )),
        );
      },
    );
  }
}