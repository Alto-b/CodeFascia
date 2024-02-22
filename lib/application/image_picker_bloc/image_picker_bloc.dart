import 'package:bloc/bloc.dart';
import 'package:code_geeks/application/image_picker_utils.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'image_picker_event.dart';
part 'image_picker_state.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {

  final ImagePickerUtils imagePickerUtils;
  ImagePickerBloc(this.imagePickerUtils) : super(ImagePickerInitial()) {
   on<GalleryPicker>(galleryPick);

 
  }
     void galleryPick(GalleryPicker event,Emitter<ImagePickerState> states)async{
      XFile? file = await imagePickerUtils.galleryPick();
      emit(state.copyWith(file: file));
    }

    void cameraCapture(CameraCapture event,Emitter<ImagePickerState> states)async{
      XFile? file = await imagePickerUtils.cameraCapture();
      emit(state.copyWith(file: file));
    }
}
