import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:southwind/UI/components/NetworkImageLoader.dart';
import 'package:southwind/UI/components/common_appbar.dart';
import 'package:southwind/UI/components/common_button.dart';
import 'package:southwind/UI/components/loadingWidget.dart';
import 'package:southwind/UI/incentives/component/IncentivreCard.dart';
import 'package:southwind/UI/theme/apptheme.dart';
import 'package:southwind/data/providers/providers.dart';
import 'package:southwind/routes/routes.dart';

class Incentives extends StatefulHookWidget {
  const Incentives({Key? key}) : super(key: key);

  @override
  _IncentivesState createState() => _IncentivesState();
}

class _IncentivesState extends State<Incentives> {
  int selectedIndex = 0;
  List<String> tabs = [
    'New',
    'Most Popular',
    'Purchased',
  ];

  @override
  Widget build(BuildContext context) {
    final incentiveProvider = useProvider(incentiveNotifierProvider);
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: primarySwatch[900],
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primarySwatch[900]!, primarySwatch[600]!],
                  stops: [.2, .8],
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              height: size.height * .3,
              // width: size.width,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Awailable Incentives",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "250",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Row(
          children: [
            for (int i = 0; i < tabs.length; i++)
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(1000),
                    onTap: () {
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
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: primarySwatch[900]!, width: .5)),
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: Center(
                            child: Text(
                              tabs[i],
                              maxLines: 1,
                              overflow: TextOverflow.visible,
                              style: selectedIndex != i
                                  ? TextStyle(
                                      color: primarySwatch[900],
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)
                                  : TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                            ),
                          ),
                        )),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        if (selectedIndex == 0)
          Expanded(
            child: FutureBuilder(
                future: incentiveProvider.newIncentive(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Container(
                      child: ListView.builder(
                          itemCount: incentiveProvider
                              .newIncentives.incentiveList!.length,
                          itemBuilder: (context, index) {
                            return IncentiveCard(
                              imageUrl: incentiveProvider
                                  .newIncentives
                                  .incentiveList![index]
                                  .url!, // no parameter in api respone
                              title: incentiveProvider.newIncentives
                                  .incentiveList![index].incentiveTitle!,
                              token: incentiveProvider.newIncentives
                                  .incentiveList![index].incentiveBadge!,
                            );
                          }),
                    );
                  } else {
                    return LoadingWidget();
                  }
                }),
          ),
        if (selectedIndex == 1)
          Expanded(
            child: FutureBuilder(
                future: incentiveProvider.mostopularIncentive(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
                        itemCount: incentiveProvider
                            .mostPopularIncentive.incentiveList!.length,
                        itemBuilder: (context, index) {
                          return IncentiveCard(
                            imageUrl: incentiveProvider.mostPopularIncentive
                                .incentiveList![index].url!,
                            title: incentiveProvider.mostPopularIncentive
                                .incentiveList![index].incentiveDescription!,
                            token: incentiveProvider.mostPopularIncentive
                                .incentiveList![index].incentiveBadge!,
                          );
                        });
                  } else {
                    return LoadingWidget();
                  }
                }),
          ),
      ],
    );
  }
}
