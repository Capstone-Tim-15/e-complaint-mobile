import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profiledetail extends StatefulWidget {
  const Profiledetail({super.key});

  @override
  State<Profiledetail> createState() => _ProfiledetailState();
}

class _ProfiledetailState extends State<Profiledetail> {
  String coverImagePath = 'assets/images/news_image.jpg';
  String profileImagePath = 'assets/images/user.png';

  late String name = '';
  late String email = '';
  late String phone = '';
  late String imageUrl = '';

  @override
  void initState() {
    super.initState();
    getProfile();
  }

Future<void> getProfile() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  setState(() {
    name = prefs.getString('name') ?? '';
    email = prefs.getString('email') ?? '';
    phone = prefs.getString('phone') ?? '';
    imageUrl = prefs.getString('imageUrl') ?? '';
  });
}


  Future<void> _pickImage(ImageSource source, bool isCoverImage) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        if (isCoverImage) {
          coverImagePath = pickedFile.path;
        } else {
          profileImagePath = pickedFile.path;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Detail'),
        backgroundColor:
            Colors.white, // Mengatur warna background AppBar menjadi putih
        iconTheme: IconThemeData(color: Colors.orange),
        toolbarTextStyle: TextTheme(
          headline6: TextStyle(
            color: Colors.black, // Mengatur warna teks title menjadi hitam
            fontSize: 18.0, // Mengatur ukuran teks title
          ),
        ).bodyText2,
        titleTextStyle: TextTheme(
          headline6: TextStyle(
            color: Colors.black, // Mengatur warna teks title menjadi hitam
            fontSize: 18.0, // Mengatur ukuran teks title
          ),
        ).headline6,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // image
          SizedBox(
            width: double.infinity,
            height: 239,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    _pickImage(ImageSource.gallery, true);
                    print("Cover image ditekan, ubah gambar jika diperlukan");
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.grey,
                      image: DecorationImage(
                        image: AssetImage(coverImagePath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _pickImage(ImageSource.gallery, false);
                    print("Profile image ditekan, ubah gambar jika diperlukan");
                  },
                  child: Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      image: DecorationImage(
                        image: AssetImage(profileImagePath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: 18,
                    width: 5000,
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.black.withOpacity(0.5),
                    ),
                    child: const Text(
                      "Tekan untuk ubah",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          // nama
          Container(
            height: 45,
            padding:
                const EdgeInsets.only(right: 16, left: 16, top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Nama Lengkap",
                  style: TextStyle(
                    fontFamily: "Nunito",
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontFamily: "Nunito",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          const Divider(color: Colors.black),
          //bio
          Container(
            height: 45,
            padding:
                const EdgeInsets.only(right: 16, left: 16, top: 10, bottom: 10),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Bio",
                    style: TextStyle(
                      fontFamily: "Nunito",
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "Bio",
                        style: TextStyle(
                          fontFamily: "Nunito",
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const Divider(color: Colors.black),
          //no hp
          Container(
            height: 45,
            padding:
                const EdgeInsets.only(right: 16, left: 16, top: 10, bottom: 10),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "No. Handphone",
                    style: TextStyle(
                      fontFamily: "Nunito",
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        phone,
                        style: TextStyle(
                          fontFamily: "Nunito",
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const Divider(color: Colors.black),
          //email
          Container(
            height: 45,
            padding:
                const EdgeInsets.only(right: 16, left: 16, top: 10, bottom: 10),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Email",
                    style: TextStyle(
                      fontFamily: "Nunito",
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        email,
                        style: TextStyle(
                          fontFamily: "Nunito",
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const Divider(color: Colors.black),
        ],
      ),
    );
  }
}
