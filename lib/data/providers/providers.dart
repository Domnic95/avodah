import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:southwind/data/providers/auth__notifier.dart';
import 'package:southwind/data/providers/carrer_notifer.dart';
import 'package:southwind/data/providers/group_notifier.dart';
import 'package:southwind/data/providers/incentive__notifier.dart';
import 'package:southwind/data/providers/jobsService.dart';
import 'package:southwind/data/providers/leadrboard__notifier.dart';
import 'package:southwind/data/providers/learning__notifier.dart';
import 'package:southwind/data/providers/library__notifier.dart';
import 'package:southwind/data/providers/news_comment__notifier.dart';
import 'package:southwind/data/providers/news_notifier.dart';
import 'package:southwind/data/providers/schedule__notifier.dart';

import 'package:southwind/data/providers/survey_provider.dart';
import 'package:southwind/data/providers/timerCard_notifier.dart';

final authProvider = ChangeNotifierProvider((ref) => AuthNotifier());
final libraryNotifier = ChangeNotifierProvider((_ref) => LibraryNotifier(_ref));
final newsNotifierProvider = ChangeNotifierProvider((_ref) => NewsNotifier());
final incentiveNotifierProvider =
    ChangeNotifierProvider((_ref) => IncentiveNotifier());
final timerNotifierProvider =
    ChangeNotifierProvider((_ref) => TimerCardNotifier());
final carerNotifierProvider =
    ChangeNotifierProvider((_ref) => CareerProvider());
final surveyNotifierProvider =
    ChangeNotifierProvider((_ref) => SurveyProvider());
final leaderBoardNotifierProvider =
    ChangeNotifierProvider((_ref) => LeaderBoardProvider());
final scheduleNotifierProvider =
    ChangeNotifierProvider((_ref) => ScheduleProvider());
final learningProvider =  ChangeNotifierProvider((_ref) => LearningNotifier());
final groupProvider =  ChangeNotifierProvider((_ref) => GroupNotifier());
final jobsNotifierProvider =  ChangeNotifierProvider((_ref) => JobsService());
final commentNotifierProvider =
    ChangeNotifierProvider.family<NewsCommentNotifier, String>(
        (_ref, id) => NewsCommentNotifier(id));
