import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Profiledetail extends StatefulWidget {
  const Profiledetail({super.key});

  @override
  State<Profiledetail> createState() => _ProfiledetailState();
}

class _ProfiledetailState extends State<Profiledetail> {
  String coverImagePath = 'assets/images/news_image.jpg';
  String profileImagePath = 'assets/images/user.png';

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
        title: const Text('Profile Detail'),
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
                      "Nama",
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
          //jenis
          Container(
            height: 45,
            padding:
                const EdgeInsets.only(right: 16, left: 16, top: 10, bottom: 10),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Jenis Kelamin",
                    style: TextStyle(
                      fontFamily: "Nunito",
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "Jenis",
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
          //tgl lahir
          Container(
            height: 45,
            padding:
                const EdgeInsets.only(right: 16, left: 16, top: 10, bottom: 10),
            child: const Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Tanggal Lahir",
                    style: TextStyle(
                      fontFamily: "Nunito",
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "Tanggal",
                        style: TextStyle(
                          fontFamily: "Nunito",
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      // Gap(5),
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
                        "Nomor",
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
                        "Email",
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
          //alamat (jadi header)
          Container(
            height: 45,
            padding:
                const EdgeInsets.only(right: 16, left: 16, top: 10, bottom: 10),
            child: const Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Alamat",
                    style: TextStyle(
                      fontFamily: "Nunito",
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(color: Colors.black),
          //alamat
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 16, top: 10, right: 16),
            child: const Text(
              "Alamat",
              style: TextStyle(
                fontFamily: "Nunito",
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          )
        ],
      ),
    );
  }
}
