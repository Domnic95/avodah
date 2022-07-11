// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:dio/dio.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:southwind/Models/library_model.dart';
import 'package:southwind/data/providers/auth__notifier.dart';
import 'package:southwind/data/providers/base_notifer.dart';
import 'package:southwind/data/providers/providers.dart';

class LibraryNotifier extends BaseNotifier {
  List<LibraryModel> libraries = [];
  List<LibraryModel> filteredLibraires = [];
  String libraryFilter = '';
  late AuthNotifier authNotifier;
  LibraryNotifier(ProviderReference _ref) {
    authNotifier = _ref.read(authProvider);
  }
  setFilter(String filter) {
    libraryFilter = filter;
    notifyListeners();
  }

  Future loadLibrayData() async {
    libraries.clear();
    Response res =
        await dioClient.postWithFormData(apiEnd: api_libraryDataEnd, data: {
      "team_id": authNotifier.userData?.teamId,
      'client_id': authNotifier.userData?.id,
    });
    if (res.data.containsKey('profile_schedules'))
      libraries = List<LibraryModel>.from(
          res.data['profile_schedules'].map((x) => LibraryModel.fromJson(x)));
  }

  Future<List<LibraryModel>> searchlibraries(
    String name,
  ) async {
    List<LibraryModel> item = [];

    for (int i = 0; i < filteredLibraires.length; i++) {
      if (filteredLibraires[i]
          .resourceTitle!
          .toLowerCase()
          .contains(name.toLowerCase())) {
        item.add(filteredLibraires[i]);
      }
    }
    return item;
  }

  Future filteredlibraries() async {
    filteredLibraires = [];

    for (int i = 0; i < libraries.length; i++) {
      if (libraries[i]
          .cats![0]
          .toLowerCase()
          .contains(libraryFilter.toLowerCase())) {
        filteredLibraires.add(libraries[i]);
      }
    }
  }
}

enum LibraryMediaType { youtube, pdf, none }
