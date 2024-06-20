import 'package:flutter/material.dart';
import 'package:fyp/utils/app_colors.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            
            SizedBox(
              height: 270,
              child: Stack(
                children:[ Container(
                  width: double.infinity,
                  height: 170,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(200), bottomRight: Radius.circular(200)),
                    gradient: LinearGradient(colors: [Colors.green, primaryColor])
                  ),
                  child: Text('ii'),
                ),

                  Positioned(
                    left: -20,
                    top: -50,
                    child: Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        gradient: LinearGradient(colors: [Colors.white.withOpacity(0.2), Colors.white70.withOpacity(0.2)])
                      ),
                    ),
                  ),
                  Positioned(
                    left: -20,
                    top: -50,
                    child: Container(
                      height: 145,
                      width: 145,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          gradient: LinearGradient(colors: [Colors.white.withOpacity(0.2), Colors.white70.withOpacity(0.2)])
                      ),
                    ),
                  ),

                  Positioned(
                    left: -20,
                    top: -50,
                    child: Container(
                      height: 170,
                      width: 170,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          gradient: LinearGradient(colors: [Colors.white.withOpacity(0.2), Colors.white70.withOpacity(0.2)])
                      ),
                    ),
                  ),

                  Positioned(
                    top:105,
                    left: 145,
                    child: Center(
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.green,
                      ),
                    ),
                  )

                      ]
              ),
            )
          ],
        ),
      ),
    );
  }
}
