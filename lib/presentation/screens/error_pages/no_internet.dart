import 'package:animated_icon/animated_icon.dart';
import 'package:code_geeks/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class NoInternetPage extends StatelessWidget {
  const NoInternetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('lib/assets/internet.json'),
            Text(
              "No Internet Connection",
              style: GoogleFonts.orbitron(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20), // Adjust spacing as needed
            TextButton(
              onPressed: () {
                // Navigate back to the main page where internet connection is checked
                Navigator.popUntil(context, ModalRoute.withName(main() as String));
              },
              // child: Text(
              //   'Restart Application',
              //   style: TextStyle(
              //     color: Colors.blue, // Customize button text color
              //     fontSize: 16, // Customize button text size
              //   ),
              // ),
              child: AnimateIcon(
        key: UniqueKey(),
        onTap: () {
          Navigator.popUntil(context, ModalRoute.withName(main() as String));
        },
        iconType: IconType.animatedOnTap,
        height: 70,
        width: 70,
        color: const Color.fromARGB(255, 110, 138, 185),
        animateIcon: AnimateIcons.refresh,
        toolTip: "Reload",
            ),
              ),


            // LoadingBtn(
            //         height: 40,
            //         borderRadius: 8,
            //         animate: true,
            //         color: Color.fromARGB(0, 110, 132, 214),
            //         width: MediaQuery.of(context).size.width * 0.45,
            //         loader: Container(
            //             padding: const EdgeInsets.all(10),
            //             width: 40,
            //             height: 40,
            //             child: const CircularProgressIndicator(
            //                 valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            //             ),
            //         ),
            //         child: const Text('Restart Application',style: TextStyle(color: Colors.white),),
            //         onTap: (startLoading, stopLoading, btnState) async {
            //             if (btnState == ButtonState.idle) {
            //                 startLoading();
            //                 Navigator.popUntil(context, ModalRoute.withName(main() as String));
            //                 await Future.delayed(const Duration(seconds: 2));
            //                 stopLoading();
            //             }
            //         },
            //     ),

//             LoadingBtn(
//   height: 40,
//   borderRadius: 8,
//   animate: true,
//   color: Color.fromARGB(0, 110, 132, 214),
//   width: MediaQuery.of(context).size.width * 0.45,
//   loader: Container(
//     padding: const EdgeInsets.all(10),
//     width: 40,
//     height: 40,
//     child: const CircularProgressIndicator(
//       valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//     ),
//   ),
//   child: const Text('Restart Application', style: TextStyle(color: Colors.white)),
//   onTap: (startLoading, stopLoading, btnState) async {
//     if (btnState == ButtonState.idle) {
//       startLoading();
      
//       // Navigate back to the main page
//       Navigator.popUntil(context, ModalRoute.withName('/main'));

//       await Future.delayed(const Duration(seconds: 2));
//       stopLoading();
//     }
//   },
// ),

          ],
        ),
      ),
    );
  }
}
