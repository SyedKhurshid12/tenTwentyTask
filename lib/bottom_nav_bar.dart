import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tentwenty_task/config/colors.dart';
import 'package:tentwenty_task/deshboard_home/deshboard_home.dart';
import 'package:tentwenty_task/media_library_home/media_library_screen.dart';
import 'package:tentwenty_task/more_home/more_screen.dart';
import 'package:tentwenty_task/movie_home/movie_screen.dart';

class BottomNavBar extends StatefulWidget {
  int? index;

  BottomNavBar({Key? key, this.index}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 1;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  void initState() {

    super.initState();
  }

  @override
  void dispose() {
    _scaffoldKey.currentState?.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: IndexedStack(
        index: currentIndex,
        alignment: Alignment.bottomCenter,
        children: const [
          DeshboardHome(),
          MovieScreen(),
          MediaLibraryScreen(),
          MoreScreen(),
        ],
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.all( Radius.circular(30.0) ),

        child: BottomNavigationBar(

          selectedFontSize: 10, // Adjust the font size as needed
          backgroundColor: Gunmetal,
          selectedItemColor: whiteColor,


          unselectedItemColor: Colors.grey, // Set the color for unselected items
          showSelectedLabels: true, // Set to true to show labels for selected items
          showUnselectedLabels: true, // Set to true to show labels for unselected items
          items:  [
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  "assets/deshboard.svg",
                ),
              ),
              label: "Dashboard",
            ),
             BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.all(8.0),
                child:  SvgPicture.asset(
                  "assets/media.svg",

                ),
              ),
              label: "Watch",
            ),
             BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  "assets/library.svg",

                ),
              ),
              label: "Media Library",
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  "assets/more.svg",
                ),
              ),
              label: "More",
            ),
          ],
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });

          },


        ),
      ),
    );
  }



}
