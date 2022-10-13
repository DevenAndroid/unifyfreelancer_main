import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../resources/app_theme.dart';

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({Key? key}) : super(key: key);

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  var time;
  @override
  Widget build(BuildContext context) {
    return showBottomSheet1(context);
  }

  showBottomSheet1(context) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return FractionallySizedBox(
              heightFactor: 0.9,
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () => Get.back(), icon: Icon(Icons.clear),
                        ),
                        Text(
                          "To (or expected graduation year)",
                          style: TextStyle(
                              fontSize: 14,
                              color: AppTheme.titleText,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox()

                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: 10,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return RadioListTile(
                            title: Text(
                              index.toString(),
                              style: TextStyle(
                                  fontSize: 14,
                                  color: AppTheme.darkBlueText,
                                  fontWeight: FontWeight.w500),
                            ),
                            contentPadding: const EdgeInsets.all(0),
                            dense: true,
                            visualDensity: VisualDensity(
                                horizontal: -4, vertical: -4),
                            value: index.toString(),
                            groupValue: time,
                            onChanged: (value) {
                              setState(() {
                                time = value.toString();
                              });
                            },
                          );
                        })

                  ],
                ),
              )
          );
        });
  }
}
