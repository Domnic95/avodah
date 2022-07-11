import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:YouMoveMe/Models/survey/basic_survey_dekmmktails.dart';
import 'package:southwind/Models/survey/individual_survey.dart';
import 'package:southwind/Models/survey/surveyModel.dart';
import 'package:southwind/UI/components/loadingWidget.dart';
import 'package:southwind/UI/theme/apptheme.dart';
import 'package:southwind/data/providers/providers.dart';
import 'package:southwind/routes/routes.dart';
import 'package:southwind/UI/theme/apptheme.dart';

class Surveys_Tab extends StatefulHookWidget {
  @override
  _Surveys_TabState createState() => _Surveys_TabState();
}

class _Surveys_TabState extends State<Surveys_Tab> {
  bool loading = true;
  List<String> tabs = ["New Survey", "Submitted Surveys"];
  int selectedIndex = 0;
  ScrollController controller = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
   controller = ScrollController()..addListener(_scrollListener);
    loadData();
  }

  loadData() async {
    await context.read(surveyNotifierProvider).suveryNotification();
    setState(() {
      loading = false;
    });
  }
@override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }
 
void _scrollListener() async{
   if( context.read(surveyNotifierProvider).lazyLoading){

   
    if (controller.position.extentAfter < 500) {
         await context.read(surveyNotifierProvider).lazyData();
      // setState(() {
      //   // items.addAll(List.generate(42, (index) => 'Inserted $index'));
      // });
    }
    }
  }
  @override
  Widget build(BuildContext context) {
    final _surveyNotifierProvider = useProvider(surveyNotifierProvider);

    return SafeArea(
      child: Scaffold(
          body: loading
              ? LoadingWidget()
              : Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          for (int i = 0; i < tabs.length; i++)
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 10),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(1000),
                                  onTap: () async {
                                    if (i == 0) {
                                      await _surveyNotifierProvider
                                          .setReadibility(false);
                                    } else {
                                      await _surveyNotifierProvider
                                          .setReadibility(true);
                                    }
                                    setState(() {
                                      selectedIndex = i;
                                    });
                                  },
                                  child: Material(
                                    color: Colors.transparent,
                                    elevation: selectedIndex == i ? 10 : 0,
                                    borderRadius: BorderRadius.circular(1000),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: selectedIndex == i
                                              ? primarySwatch[700]
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: primarySwatch[900]!,
                                              width: .5)),
                                      child: Center(
                                          child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 10),
                                        child: Text(
                                          tabs[i],
                                          maxLines: 1,
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.visible,
                                          style: selectedIndex != i
                                              ? TextStyle(
                                                  color: primarySwatch[900],
                                                  fontWeight: FontWeight.bold)
                                              : TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                        ),
                                      )),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      // SurveyCategory(
                      //   title: selectedIndex == 0 ? "Interesting" : "Submitted",
                      //   data: selectedIndex == 0
                      //       ? _surveyNotifierProvider.newSurvey
                      //       : _surveyNotifierProvider.submittedSurvey,
                      // )

                      
                      // Expanded(
                      //   child: SurveyCategory(
                      //             title: selectedIndex == 0
                      //                 ? "Interesting"
                      //                 : "Submitted",
                      //             data: selectedIndex == 0
                      //                 ? _surveyNotifierProvider.newSurvey
                      //                 : _surveyNotifierProvider.submittedSurvey,
                      //           ),
                        Expanded(
                          child: FutureBuilder(
                              future: _surveyNotifierProvider.reload(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return SurveyCategory(
                                    title: selectedIndex == 0
                                        ? "Interesting"
                                        : "Submitted",
                                    data: selectedIndex == 0
                                        ? _surveyNotifierProvider.newSurvey
                                        : _surveyNotifierProvider.submittedSurvey,
                                  );
                                } else {
                                  return Center(
                                    child: LoadingWidget(),
                                  );
                                }
                              }),
                        ),
                    
                    ],
                  ),
                )
          // : Center(
          //     child: Text('No survey found'),
          //   ),
          ),
    );
  }
}

class SurveyCategory extends StatefulHookWidget {
  final String title;
  final List<LibraryNotification> data;
  SurveyCategory({required this.data, required this.title, Key? key})
      : super(key: key);

  @override
  State<SurveyCategory> createState() => _SurveyCategoryState();
}

class _SurveyCategoryState extends State<SurveyCategory> {
  @override
  Widget build(BuildContext context) {
    return widget.data.length > 0
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${widget.title} Surveys",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5),
              ),
              Text(
                "${widget.data.length} Surveys",
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.data.length,
                  padding: const EdgeInsets.only(top: 0, bottom: 60),
                  itemBuilder: (context, index) {
                    return SingleCollection(widget.data[index]);
                  },
                ),
              ),
            ],
          )
        : Center(
            child: Text('No survey found'),
          );
  }
}

class SingleCollection extends HookWidget {
  final LibraryNotification collection;

  const SingleCollection(this.collection, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final surveyProvider = context.read(surveyNotifierProvider);
    const double radius = 12;
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: InkWell(
          onTap: () async {
             await surveyProvider.setSurveyId(collection.id!);
            // await surveyProvider.setSurvey(collection);
            // Navigator.push(context, MaterialPageRoute(builder: (_)=>Questions_Tab()));
            Navigator.pushNamed(context, Routes.question_tab);
          },
          child: Material(
            elevation: 3,
            borderRadius: BorderRadius.circular(radius),
            child: Container(
              decoration: BoxDecoration(
                  // color: primarySwatch[100],
                  borderRadius: BorderRadius.circular(radius),
                  border: Border.all(color: primaryColor, width: .5)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 0),
                child: ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.pink[200],
                    ),
                    child: const Icon(Icons.settings),
                  ),
                  title: Text(
                    collection.title!.toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      color: primarySwatch[900],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: primarySwatch[900],
                  ),
                  subtitle: Text(
                    "${collection.questionCount} Question",
                    style: TextStyle(color: primarySwatch[500], fontSize: 12),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
