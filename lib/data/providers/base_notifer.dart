import 'package:flutter/widgets.dart';
import 'package:southwind/data/http_client/dio_client.dart';
export 'package:southwind/data/config.dart';

abstract class BaseNotifier extends ChangeNotifier {
  final DioClient dioClient = DioClient();
}
