import 'package:image_picker/image_picker.dart';

class File_Picker {
  final ImagePicker _picker = ImagePicker();
  Future<String> pickImage(ImageSource source) async {
    XFile? file = await _picker.pickImage(source: source);
    return file!.path;
  }
  Future<String> pickVideo(ImageSource source) async {
    XFile? file = await _picker.pickVideo(source: source);
    return file!.path;
  }
  
}
