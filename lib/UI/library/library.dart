// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:southwind/Models/library_model.dart';
import 'package:southwind/UI/components/common_appbar.dart';
import 'package:southwind/UI/components/loadingWidget.dart';
import 'package:southwind/UI/library/components/library_card.dart';
import 'package:southwind/UI/library/video_tab.dart';
import 'package:southwind/UI/theme/apptheme.dart';
import 'package:southwind/constant/inputStyle.dart';
import 'package:southwind/data/providers/providers.dart';
import 'package:southwind/routes/routes.dart';

class Library extends StatefulHookWidget {
  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  bool isLoading = true;

  List<String> typeList = [
    'Trucks',
    "Heath and Safety",
    "Culture",
    "Training - New Hires & Currently employee skill development",
    'Customer Service',
    'Sales',
    'Operations & Metric Management'
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() async {
    await context.read(libraryNotifier).loadLibrayData();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _libraryNotifier = useProvider(libraryNotifier);

    return Scaffold(
        // appBar: AppBar(
        //   title: Text(
        //     "LIBRARY",
        //     style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.5),
        //   ),
        //   actions: [
        //     Icon(
        //       Icons.menu_outlined,
        //     ),
        //     SizedBox(
        //       width: 10,
        //     ),
        //   ],
        // ),
        body: isLoading
            ? LoadingWidget()
            : SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: typeList
                        .map((e) => Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _libraryNotifier.setFilter(e);

                                    Navigator.pushNamed(
                                      context,
                                      Routes.libraryFilter,
                                    );
                                  });
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  shadowColor: primarySwatch.shade400,
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                    width: size.width,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: primaryColor, width: 0.3)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 15,
                                      ),
                                      child: Text(e.toString()),
                                    ),
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ));
  }
}

class LibraryWithFilter extends StatefulHookWidget {
  LibraryWithFilter({Key? key}) : super(key: key);

  @override
  State<LibraryWithFilter> createState() => _LibraryWithFilterState();
}

class _LibraryWithFilterState extends State<LibraryWithFilter> {
  bool isSearch = false;
  bool isLoading = true;
  String searchString = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() async {
    await context.read(libraryNotifier).filteredlibraries();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _libraryNotifier = useProvider(libraryNotifier);
    return Scaffold(
      appBar: AppBar(

          // shadowColor: Colors.red,
          backgroundColor: Colors.white,
          title: Container(
            // color: Colors.teal,
            height: 30,
            child: Image.asset("assets/images/southwind_logo.png"),
          ),
          centerTitle: true,
          actions: [
            // IconButton(
            //   icon: Icon(Icons.notifications),
            //   onPressed: () {
            //     Navigator.of(context).pushNamed(Routes.notification);
            //   },
            // )
            // (widget.screenIndex == DrawerIndex.Incentives)
            //     ? IconButton(
            //         icon: Icon(Icons.history),
            //         onPressed: () {
            //           Navigator.of(context)
            //               .pushNamed(Routes.history);
            //         },
            //       )
            //     : Container(),
          ]),
      body: isLoading
          ? LoadingWidget()
          : Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 8),
                  //   child: Text(
                  //     _libraryNotifier.libraryFilter,
                  //     style: TextStyle(
                  //         fontSize: 18,
                  //         fontWeight: FontWeight.bold,
                  //         color: primarySwatch.shade400),
                  //   ),
                  // ),
                  // Divider(
                  //   height: 20,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: TextFormField(
                        onChanged: (v) {
                          if (v.length > 0) {
                            setState(() {
                              isSearch = true;
                              searchString = v;
                            });
                          } else if (v.length == 0 && isSearch) {
                            setState(() {
                              isSearch = false;
                            });
                          }
                        },
                        decoration: transparentInputDecoration.copyWith(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 15),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: Icon(
                                Icons.search,
                              ),
                            ),
                            prefixIconConstraints:
                                BoxConstraints(maxHeight: 30),
                            filled: true,
                            fillColor: Colors.grey[300]),
                      )),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: isSearch
                        ? FutureBuilder(
                            future:
                                _libraryNotifier.searchlibraries(searchString),
                            builder: (context, AsyncSnapshot snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.data.length > 0) {
                                  return ListView.builder(
                                    itemCount: snapshot.data.length,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (context, index) {
                                      return LibraryCard(
                                        libraryModel: snapshot.data[index],
                                      );
                                    },
                                  );
                                } else {
                                  return Center(
                                    child: Text(
                                      'No library resources available',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  );
                                }
                              } else {
                                return LoadingWidget();
                              }
                            })
                        : _libraryNotifier.filteredLibraires.length > 0
                            ? ListView.builder(
                                itemCount:
                                    _libraryNotifier.filteredLibraires.length,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  return LibraryCard(
                                    libraryModel: _libraryNotifier
                                        .filteredLibraires[index],
                                  );
                                },
                              )
                            : Center(
                                child: Text(
                                  'No library resources available',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                  )
                ],
              ),
            ),
    );
  }
}
