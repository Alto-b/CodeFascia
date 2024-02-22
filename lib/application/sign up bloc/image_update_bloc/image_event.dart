part of 'image_bloc.dart';

sealed class ImageEvent extends Equatable {
  const ImageEvent();

  @override
  List<Object> get props => [];
}

class ImageChangedEvent extends ImageEvent{
  Uint8List selectedImage;

  ImageChangedEvent({required this.selectedImage});
}
