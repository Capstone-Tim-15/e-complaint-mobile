import 'package:flutter/material.dart';

List<String> list = <String>['Terbaru', 'Terlama'];

class CommentSection extends StatefulWidget {
  const CommentSection({super.key});

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
          child: DropdownButton<String>(
            value: dropdownValue,
            icon: const ImageIcon(
              AssetImage('assets/icons/icon_arrow_down.png'),
            ),
            elevation: 16,
            style: const TextStyle(color: Colors.black),
            underline: Container(
              height: 0,
            ),
            onChanged: (String? value) {
              setState(() {
                dropdownValue = value!;
              });
            },
            items: list.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: const TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.black),
                ),
              );
            }).toList(),
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipOval(
                child: Image.asset(
                  'assets/images/circle_avatar.png',
                  fit: BoxFit.cover,
                  width: 24,
                  height: 24,
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Marshella',
                        style: TextStyle(
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            letterSpacing: -0.5),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                        '06-20',
                        style: TextStyle(
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w400,
                            fontSize: 11,
                            letterSpacing: -0.5),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  SizedBox(
                    width: 262,
                    child: Text(
                      'Aku nungguin berapa jam yaa, Agak cepet si pelayanan SIM Keliling ini',
                      style: TextStyle(
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.5,
                          fontSize: 12),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Image.asset('assets/icons/icon_like.png'),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text(
                        '1rb',
                        style: TextStyle(
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                            letterSpacing: -0.5,
                            color: Color.fromARGB(255, 153, 153, 153)),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Image.asset('assets/icons/icon_comment.png'),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text(
                        '12',
                        style: TextStyle(
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                            letterSpacing: -0.5,
                            color: Color.fromARGB(255, 153, 153, 153)),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Image.asset('assets/icons/icon_save.png'),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text(
                        '35',
                        style: TextStyle(
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                            letterSpacing: -0.5,
                            color: Color.fromARGB(255, 153, 153, 153)),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Image.asset('assets/icons/icon_share.png'),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text(
                        '1.5rb',
                        style: TextStyle(
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                            letterSpacing: -0.5,
                            color: Color.fromARGB(255, 153, 153, 153)),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
