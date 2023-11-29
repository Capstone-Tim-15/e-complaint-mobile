import 'dart:ui';

import 'package:e_complaint/models/user_profile.dart';
import 'package:e_complaint/views/widget/card_contact_widget.dart';
import 'package:flutter/material.dart';

class profile_image_widget extends StatelessWidget {
  const profile_image_widget({
    super.key,
    required this.user,
  });

  final UserProfile user;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 410,
      child: Wrap(
        children: [
          Container(
            height: 410,
            margin: EdgeInsets.only(
              bottom: 10.0,
            ),
            child: Stack(
              children: [
                Container(
                  height: 230,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(user.coverImageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                    child: Container(
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ),
                ),
                // Children
                Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            child: Center(
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage:
                                    NetworkImage(user.profileImageUrl),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Card_Contact(user: user)
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
