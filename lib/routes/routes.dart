import 'package:flutter/material.dart';
import 'package:southwind/UI/auth_wrapper.dart';
import 'package:southwind/UI/components/notification.dart';
import 'package:southwind/UI/home/career_tab/page/questions_page.dart';
import 'package:southwind/UI/home/chat_tab/group_Info.dart';
import 'package:southwind/UI/home/chat_tab/group_chat_screen.dart';
import 'package:southwind/UI/home/chat_tab/single_chat_screen.dart';
import 'package:southwind/UI/home/clock_in_out/work_history.dart';
import 'package:southwind/UI/home/custom_drawer.dart';
import 'package:southwind/UI/home/home_screen.dart';
import 'package:southwind/UI/incentives/incentives.dart';
import 'package:southwind/UI/incentives/page/history.dart';
import 'package:southwind/UI/jobs/jobs_screen.dart';
import 'package:southwind/UI/learning/components/learning_question.dart';
import 'package:southwind/UI/library/library.dart';
import 'package:southwind/UI/login/log_in.dart';
import 'package:southwind/UI/splash_screen.dart';
import 'package:southwind/UI/surveys_tab/Page/congratspage.dart';
import 'package:southwind/UI/surveys_tab/Page/congratspage.dart';
import 'package:southwind/UI/surveys_tab/Page/question_tab.dart';
import 'package:southwind/UI/surveys_tab/Page/summarypage.dart';

class Routes {
  static const String homePage = "/homePage";
  static const String QuestionPage = "/homePage/QuestionPage";
  static const String singleChatScreen = "/SingleChatScreen";
  static const String groupChatScreen = "/GroupChatScreen";
  static const String groupInfo = "/GroupInfo";
  static const String clockInOutScreen = "/clockInOutScreen";
  static const String question_tab = "/Question_tab";
  static const String learning_question_tab = '/Leaning_tab';
  static const String question_summary = "/Question_summary";
  static const String congrat_Tab = "/CongratTab";
  static const String customDrawer = "/customerDrawer";
  static const String login = "log_in";
  static const String authWrapper = "auth_wrapper";
  static const String splashScreen = 'splashScrren';
  static const String history = "history";
  static const String notification = 'notification';
  static const String libraryFilter = 'libraryFilter';
  static const String jobs = 'jobs';

  static Route<dynamic> onRouteGenerate(RouteSettings settings) {
    return MaterialPageRoute(
        builder: (context) {
          Widget page;
          switch (settings.name) {
            case Routes.splashScreen:
              page = SplashScrren();
              break;
            case Routes.clockInOutScreen:
              page = WorkHistory();
              break;
            case Routes.QuestionPage:
              page = QuestionsPage();
              break;
            case Routes.learning_question_tab:
              page = LearningQuestiontab();
              break;
            case Routes.libraryFilter:
              page = LibraryWithFilter();
              break;
            // case Routes.singleChatScreen:
            //   page = SingleChatScreen();
            //   break;
            case Routes.groupInfo:
              page = GroupInfo();
              break;
            case Routes.groupChatScreen:
              page = GroupChatScreen();
              break;
            case Routes.question_tab:
              page = Questions_Tab();
              break;
            case Routes.congrat_Tab:
              page = CongratTab();
              break;
            // case Routes.question_summary:
            //   page = SummaryTab(
            //     totalquestion: 6,
            //   );
            //   break;
            case Routes.customDrawer:
              page = CustomDrawer();
              break;
            case Routes.jobs:
              page = JobScreen();
              break;
            case Routes.login:
              page = Log_In();
              break;
            case Routes.history:
              page = History();
              break;
            case Routes.authWrapper:
              page = AuthWrapper();
              break;
            case Routes.notification:
              page = NotificationPage();
              break;
            default:
              page = Container(
                child: Text('no route'),
              );
          }
          return page;
        },
        settings: settings);
  }
}
