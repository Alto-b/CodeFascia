part of 'image_bloc.dart';

sealed class ImageState extends Equatable {
  const ImageState();
  
  @override
  List<Object> get props => [];
}

final class ImageInitial extends ImageState {}

// ignore: must_be_immutable
class ImageSuccess extends ImageState{
    Uint8List selectedImage;

    ImageSuccess({required this.selectedImage});

    @override
    List<Object> get props => [selectedImage];
}
