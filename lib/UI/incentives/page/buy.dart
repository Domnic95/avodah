import 'package:flutter/material.dart';
import 'package:southwind/UI/components/NetworkImageLoader.dart';
import 'package:southwind/UI/components/common_appbar.dart';
import 'package:southwind/UI/components/common_button.dart';
import 'package:southwind/UI/theme/apptheme.dart';

class BuyTab extends StatefulWidget {
  String image;
  String name;
  String desc;

  BuyTab(
      {Key? key, required this.image, required this.name, required this.desc})
      : super(key: key);

  @override
  _BuyTabState createState() => _BuyTabState();
}

class _BuyTabState extends State<BuyTab> {
  GlobalKey<FormState> _Formkey = GlobalKey<FormState>();
  TextEditingController _answerController = TextEditingController();
  String answer = "";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      appBar: CommonAppbar(),
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 5,
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Container(
                        height: size.height * 0.3,
                        // decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(20),
                        //     image: DecorationImage(
                        //         image: NetworkImage(widget.image),
                        //         fit: BoxFit.cover)),
                        child: NetworkImagesLoader(
                          url: widget.image,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Text(
                          "${widget.name}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Text(widget.desc),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 13),
                        child: TextFormField(
                          controller: _answerController,
                          // validator: (val){
                          //   if(val!.isEmpty){
                          //     return "Please enter comment";
                          //   }
                          // },
                          onChanged: (val) {
                            setState(() {
                              answer = val;
                            });
                          },
                          maxLines: 6,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                              hintText: "Enter Your Answer",
                              hintStyle: TextStyle(color: Colors.grey),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              isCollapsed: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      width: .5, color: primarySwatch[700]!)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      width: .5, color: primarySwatch[700]!)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      width: 1, color: primaryColor))),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 50,
              margin: EdgeInsets.only(bottom: 10, left: 5, right: 5),
              child: CommonButton(
                lable: "BUY",
                bgColor: primarySwatch.shade900,
                borderRadius: 5,
                isExpanded: true,
                textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white),
                ontap: () {
                  if (answer.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Please Enter comment"),
                        behavior: SnackBarBehavior.floating,
                        duration: Duration(milliseconds: 1000),
                        backgroundColor: Colors.grey[800],
                        margin:
                            EdgeInsets.only(bottom: 70, right: 20, left: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
