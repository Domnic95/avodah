// ignore_for_file: use_key_in_widget_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:southwind/Models/Group/GroupMessages.dart';
import 'package:southwind/Models/Group/GroupModel.dart';
import 'package:southwind/UI/components/NetworkImageLoader.dart';
import 'package:southwind/UI/theme/apptheme.dart';
import 'package:southwind/data/providers/providers.dart';
import 'package:southwind/routes/routes.dart';

import '../single_chat_screen.dart';

class GroupChatCard extends HookWidget {
  Group? group;
  final int index;
  GroupChatCard({required this.index, this.group});

  @override
  Widget build(BuildContext context) {
    GetAddressFromLatLong();
    final _groupProvider = context.read(groupProvider);
    String Address = "";
    DateTime time = DateTime.parse(
            _groupProvider.listGroup[index].createdOn.toString() + '-04:00')
        .toLocal();
    log("message" + time.toString());
    return InkWell(
      onTap: () {
        _groupProvider.setGroupId(index);
        Navigator.pushNamed(context, Routes.groupChatScreen);
      },
      child: Column(
        children: [
          Container(
            // height: 50,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // CircleAvatar(
                  //   radius: 25,
                  //   backgroundImage: NetworkImage(
                  //       "https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80"),
                  // ),
                  Container(
                    height: 50,
                    width: 50,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100000),
                        child: Image.asset(
                            "assets/images/southwind_logo_single.png")
                        //  Column(
                        //   children: [
                        //     Row(
                        //       children: [
                        //         Image.network(
                        //           "https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80",
                        //           height: 25,
                        //           width: 25,
                        //           fit: BoxFit.cover,
                        //         ),
                        //         Image.network(
                        //           "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhrlH9QlMjus9pQY0IPfd97FE7RdNVga3MY-lMqsaltgspxx3q_-Bg6wcOJDYGnPy1gIU&usqp=CAU",
                        //           height: 25,
                        //           width: 25,
                        //           fit: BoxFit.cover,
                        //         ),
                        //       ],
                        //     ),
                        //     Row(
                        //       children: [
                        //         ClipRRect(
                        //           borderRadius: BorderRadius.only(
                        //               bottomLeft: Radius.circular(10),
                        //               bottomRight: Radius.circular(10)),
                        //           child: Image.network(
                        //             "https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80",
                        //             height: 25,
                        //             width: 50,
                        //             fit: BoxFit.cover,
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ],
                        // )

                        ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _groupProvider.listGroup[index].group!.groupName!,
                          style: TextStyle(
                              fontSize: 18,
                              color: primarySwatch[900],
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          _groupProvider.listGroup[index].lastMessage!,
                          maxLines: 1,
                          style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                              color: index.isEven ? Colors.grey : Colors.grey
                              // primarySwatch[600]
                              ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      // group!.displayFormat.toString(),
                      // DateFormat.jm().format(time),
                      Address.toString().contains('United States')
                          ? _groupProvider.listGroup[index].displayFormat
                              .toString()
                          : DateFormat.jm().format(time),
                      //_groupProvider.listGroup[index].displayFormat.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 12),
                    ),
                  )
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width - 80,
                  child: Divider()),
            ],
          )
        ],
      ),
    );
  }
}
