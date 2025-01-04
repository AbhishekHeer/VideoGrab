import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_video_downloader/Ui/home/controller/filtercontroller.dart';

class Filters extends StatefulWidget {
  const Filters({super.key});

  @override
  State<Filters> createState() => _FiltersState();
}

Filtercontroller filtercontroller = Get.put(Filtercontroller());

class _FiltersState extends State<Filters> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Obx(() => ListView(
          scrollDirection: Axis.horizontal,
          children: [
            for (int i = 0; i < filtercontroller.category.length; i++)
              GestureDetector(
                onTap: () {
                  filtercontroller.changeIndex(i);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: filtercontroller.index.value == i
                        ? Colors.red
                        : Colors.white38,
                    borderRadius:
                        BorderRadius.all(Radius.circular(width * .02)),
                  ),
                  height: height * .02,
                  padding: EdgeInsets.symmetric(
                    horizontal: width * .04,
                  ),
                  margin: EdgeInsets.symmetric(
                    horizontal: width * .03,
                  ),
                  child: Center(
                    child: Text(
                      filtercontroller.category[i],
                      style: GoogleFonts.nunitoSans(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              )
          ],
        ));
  }
}
