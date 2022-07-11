import 'package:flutter/material.dart';
import 'package:southwind/UI/components/NetworkImageLoader.dart';
import 'package:southwind/UI/incentives/incentives.dart';
import 'package:southwind/UI/incentives/page/buy.dart';
import 'package:southwind/UI/theme/apptheme.dart';

class IncentiveCard extends StatelessWidget {
  String imageUrl;
  String title;
  int token;
  bool? buyButton;
  
  IncentiveCard(
      {required this.imageUrl,
      required this.title,
      required this.token,
       this.buyButton= true});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Container(
              width: 60,
              height: 60,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: NetworkImagesLoader(
                  url: imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${token} TOKENS",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:
                        TextStyle(color: Colors.grey, height: 1, fontSize: 14),
                  )
                ],
              ),
            ),
            // Spacer(),
            if (buyButton!)
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => BuyTab(
                            image: imageUrl,
                            name: title,
                            desc: ' ini paramater',
                            
                          )));
                },
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                        color: primarySwatch[100],
                        border: Border.all(color: primarySwatch[900]!),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 2),
                      child: Text(
                        "Buy",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                ),
              ),
            SizedBox(
              width: 10,
            ),
            // Row(
            //   children: [
            //     Icon(Icons.attach_money),
            //     Text(
            //       "${Revenuelist[index].income}",
            //       style: TextStyle(fontWeight: FontWeight.bold),
            //     )
            //   ],
            // ),
          ],
        ),
      ),
      // child: ListTile(
      //   horizontalTitleGap: 0,
      //   leading: Text("${index + 1}"),
      // title: Text(
      //   "${Revenuelist[index].title}",
      //   style: TextStyle(
      //       fontWeight: FontWeight.w600, fontSize: 14),
      // ),
      //   subtitle: Text("${Revenuelist[index].subtitle}"),
      //   trailing: Container(
      //     width: 100,
      // child: Row(
      //   children: [
      //     Icon(Icons.attach_money),
      //     Text(
      //       "${Revenuelist[index].income}",
      //       style: TextStyle(
      //           fontWeight: FontWeight.bold),
      //     )
      //   ],
      // ),
      //   ),
      // ),
    );
  }
}
