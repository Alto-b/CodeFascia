import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

part 'image_event.dart';
part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  ImageBloc() : super(ImageInitial()) {
    on<ImageEvent>((event, emit) {
      if(event is ImageChangedEvent){
        print("bloc1 ${event.selectedImage}");
        emit(ImageSuccess(selectedImage: event.selectedImage));
        print("bloc2 ${event.selectedImage}");
      }
    });
  }
}
