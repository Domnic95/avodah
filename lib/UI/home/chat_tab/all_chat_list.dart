import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:southwind/UI/components/loadingWidget.dart';
import 'package:southwind/UI/home/chat_tab/components/group_chat_card.dart';
import 'package:southwind/UI/home/chat_tab/components/single_chat_card.dart';
import 'package:southwind/UI/home/chat_tab/group_chat_screen.dart';
import 'package:southwind/UI/theme/apptheme.dart';
import 'package:southwind/data/providers/providers.dart';
import 'package:southwind/routes/routes.dart';

class AllChatList extends StatefulHookWidget {
  const AllChatList({Key? key}) : super(key: key);

  @override
  State<AllChatList> createState() => _AllChatListState();
}

class _AllChatListState extends State<AllChatList> {
  bool loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() async {
    final res = await context.read(groupProvider).getAllGroup();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _groupProvider = useProvider(groupProvider);
    return loading
        ? LoadingWidget()
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: _groupProvider.listGroup.length > 0
                ? ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: GroupChatCard(
                          index: index,
                        ),
                      );
                      return Column(
                        children: [
                          // index % 2 == 0
                          //     ? SingleChatCard(index: index):
                          GroupChatCard(
                            index: index,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          // Divider(
                          //   height: 10,
                          // ),
                        ],
                      );
                    },
                    itemCount: _groupProvider.listGroup.length,
                  )
                : Center(
                    child: Text('No group found'),
                  ),
          );
  }
}
