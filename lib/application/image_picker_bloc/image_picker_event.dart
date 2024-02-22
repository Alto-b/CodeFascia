part of 'image_picker_bloc.dart';

sealed class ImagePickerEvent extends Equatable {
  const ImagePickerEvent();

  @override
  List<Object> get props => [];
}

class GalleryPicker extends ImagePickerEvent{}

class CameraCapture extends ImagePickerEvent{}