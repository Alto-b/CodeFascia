// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:CodeFascia/application/image_picker_utils.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'image_picker_event.dart';
part 'image_picker_state.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {

  final ImagePickerUtils imagePickerUtils;
  ImagePickerBloc(this.imagePickerUtils) : super(ImagePickerInitial()) {
    on<PickerInitial>(initial);
   on<GalleryPicker>(galleryPick);

 
  }
     void galleryPick(GalleryPicker event,Emitter<ImagePickerState> states)async{
      XFile? file = await imagePickerUtils.galleryPick();
      emit(state.copyWith(file: file));
      // emit(ImagePickerInitial());
    }

    void cameraCapture(CameraCapture event,Emitter<ImagePickerState> states)async{
      XFile? file = await imagePickerUtils.cameraCapture();
      emit(state.copyWith(file: file));
    }

  FutureOr<void> initial(PickerInitial event, Emitter<ImagePickerState> emit) {
    emit(ImagePickerInitial());
  }
}
