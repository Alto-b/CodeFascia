
// import 'dart:io';

// import 'package:flutter/material.dart';

// class ImagePickerWidget extends StatefulWidget {
//    ImagePickerWidget({
//     super.key,
//     required this.selectedImage,
//   });

//    File? selectedImage;
//    bool imageAvailable = false;

//   @override
//   State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
// }

// class _ImagePickerWidgetState extends State<ImagePickerWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//                     onTap: () async{
//                       // pickUploadImage();
//                       // pickImage(context);
//                       _photoImage();
//                       // BlocProvider.of<ImageBloc>(context).add(ImageChangedEvent(selectedImage: widget.selectedImage!));
//                     },
//                     child: CircleAvatar(
//                       radius: 60,
//                       // child: widget.imageAvailable?Image.file(widget.selectedImage!,fit:BoxFit.cover ,):Icon(Icons.add_a_photo),
//                       child: Container(
//                         child: widget.imageAvailable?Image.file(widget.selectedImage!,fit: BoxFit.fill,filterQuality: FilterQuality.high,) :Icon(Icons.add_a_photo),
                        
//                         decoration: BoxDecoration(
                          
//                         ),
//                       )
//                       // backgroundImage: widget.imageAvailable?Image.file(widget.selectedImage!)
                      
//                     ),
//                   );
//   }
//     Future _photoImage() async {
//     final picker = ImagePickerWidget();
//     final pickedImage = await picker.pickImage(source: ImageSource.gallery);

//     if (pickedImage != null) {
//       setState(() {
//      widget.selectedImage = File(pickedImage.path);
//      widget.imageAvailable = true;
//      print(pickedImage.name);
//       });
//     }
//     // final result = await FilePicker.platform.pickFiles(type: FileType.image);
//     // if(result==null)return;
//     // final  pickedFile = result.files.first;
//   }
// }