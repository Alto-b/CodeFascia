
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


part 'image_event.dart';
part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  ImageBloc() : super(ImageInitial()) {
    on<ImageEvent>((event, emit) {
      if(event is ImageChangedEvent){
        emit(ImageSuccess(selectedImage: event.selectedImage));
      }
    });
  }
}
