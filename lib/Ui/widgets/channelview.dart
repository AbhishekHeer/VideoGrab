import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Channelview {
  static Widget channelview(double height, double width, String channelname) {
    return Card(
      child: SizedBox(
        height: height * .07,
        width: width * .96,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * .06),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              AutoSizeText(
                channelname.length > 20
                    ? "${channelname.substring(0, 20)}..."
                    : channelname,
                style: GoogleFonts.poppins(fontSize: width * .04),
              ),
              const Icon(
                CupertinoIcons.chevron_right,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
