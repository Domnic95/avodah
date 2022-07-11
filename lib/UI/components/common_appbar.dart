import 'package:flutter/material.dart';

class CommonAppbar extends StatelessWidget implements PreferredSizeWidget {
  final Widget actions;
  const CommonAppbar(
      {this.actions = const SizedBox(
        height: 0,
        width: 0,
      ),
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      iconTheme: IconThemeData(color: Colors.black),
      // leading: SizedBox(
      //   width: AppBar().preferredSize.height - 8,
      //   height: AppBar().preferredSize.height - 8,
      //   child: Material(
      //     borderRadius: BorderRadius.only(
      //         topRight: Radius.circular(20),
      //         bottomRight: Radius.circular(20)),
      //     color: Colors.transparent,
      //     child: InkWell(
      //       borderRadius: BorderRadius.circular(
      //           AppBar().preferredSize.height),
      //       child: Center(
      //         // if you use your own menu view UI you add form initialization
      //         child: widget.menuView != null
      //             ? widget.menuView
      //             : AnimatedIcon(
      //                 icon: widget.animatedIconData != null
      //                     ? widget.animatedIconData
      //                     : AnimatedIcons.close_menu,
      //                 color: Colors.black,
      //                 size: 30,
      //                 progress: iconAnimationController),
      //       ),
      //       onTap: () {
      //         FocusScope.of(context)
      //             .requestFocus(FocusNode());
      //         onDrawerClick();
      //       },
      //     ),
      //   ),
      // ),
      // shadowColor: Colors.red,
      backgroundColor: Colors.white,
      title: Container(
        // color: Colors.teal,
        height: 30,
        child: Image.asset("assets/images/southwind_logo.png"),
      ),
      actions: [
        // IconButton(
        //     onPressed: () {},
        //     icon: Icon(
        //       Icons.notifications,
        //     )),
        actions,
      ],
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
