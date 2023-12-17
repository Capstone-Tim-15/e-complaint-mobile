import 'dart:ui';

import 'package:e_complaint/models/user_profile.dart';
import 'package:e_complaint/views/widget/card_contact_widget.dart';
import 'package:flutter/material.dart';

class ProfileImageWidget extends StatelessWidget {
  const ProfileImageWidget({
    Key? key,
    required this.user,
  }) : super(key: key);

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
                    // ignore: unnecessary_null_comparison
                    image: user.coverImageUrl != null
                        ? DecorationImage(
                            image: NetworkImage(
                                'https://res.cloudinary.com/dua3iphs9/image/upload/v1700572036/${user.coverImageUrl}'),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                    child: Container(
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ),
                ),
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
                                // ignore: unnecessary_null_comparison
                                backgroundImage: user.profileImageUrl != null
                                    ? NetworkImage(user.profileImageUrl)
                                    : null,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    CardContact(user: user),
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
