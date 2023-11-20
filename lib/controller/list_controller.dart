  import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



  Container weatherList(BuildContext context, {String? image, String? text,String? text1}) {
    return Container(
      width: 170,
      height: 170,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 102, 104, 105).withOpacity(0.4),
                Color.fromARGB(255, 253, 253, 254).withOpacity(0.4),
              ]),
          borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(width: 10,),
            Image(
              image: AssetImage(image!),
              width: MediaQuery.of(context).size.width * 0.2,
            ),
            SizedBox(width: 10,),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(text!,style: GoogleFonts.raleway(color: Colors.white,fontWeight: FontWeight.w800)),
            Text(
              text1!,
              style: GoogleFonts.raleway(color: Colors.white,fontWeight: FontWeight.w800,fontSize: 20)
            ),
              ],
            )
          ],
        ),
      ),
    );
  }

  SizedBox spacingheight(double value) {
    return SizedBox(
      height: value,
    );
  }