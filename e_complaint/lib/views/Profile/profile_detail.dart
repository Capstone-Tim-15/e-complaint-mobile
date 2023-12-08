import 'package:e_complaint/viewModels/provider/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profiledetail extends StatefulWidget {
  const Profiledetail({super.key});

  @override
  State<Profiledetail> createState() => _ProfiledetailState();
}

class _ProfiledetailState extends State<Profiledetail> {
  late final EditUserProvider editUserProvider;
  String coverImagePath = 'assets/images/news_image.jpg';
  String profileImagePath = 'assets/images/user.png';

  late String userId = '';
  late String username = '';
  late String name = '';
  late String email = '';
  late String phone = '';
  late String imageUrl = '';

  @override
  void initState() {
    super.initState();
    editUserProvider = context.read<EditUserProvider>();
    getProfile();
  }

  Future<void> getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('id') ?? '';
      username = prefs.getString('username') ?? '';
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
        title: const Text('Profile Detail'),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.orange),
        toolbarTextStyle: const TextTheme(
          titleLarge: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
          ),
        ).bodyMedium,
        titleTextStyle: const TextTheme(
          titleLarge: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
          ),
        ).titleLarge,
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
          const SizedBox(height: 10),
          // nama
          Container(
            height: 45,
            padding: const EdgeInsets.only(right: 16, left: 16, top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  "Nama Lengkap",
                  style: TextStyle(
                    fontFamily: "Nunito",
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  name,
                  style: const TextStyle(
                    fontFamily: "Nunito",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: Colors.black),
          //bio
          Container(
            height: 45,
            padding: const EdgeInsets.only(right: 16, left: 16, top: 10, bottom: 10),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    username,
                    style: const TextStyle(
                      fontFamily: "Nunito",
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    userId,
                    style: const TextStyle(
                      fontFamily: "Nunito",
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(color: Colors.black),
          //no hp
          Container(
            height: 45,
            padding: const EdgeInsets.only(right: 16, left: 16, top: 10, bottom: 10),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    "No. Handphone",
                    style: TextStyle(
                      fontFamily: "Nunito",
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    phone,
                    style: const TextStyle(
                      fontFamily: "Nunito",
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(color: Colors.black),
          //email
          Container(
            height: 45,
            padding: const EdgeInsets.only(right: 16, left: 16, top: 10, bottom: 10),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
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
                        style: const TextStyle(
                          fontFamily: "Nunito",
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const Divider(color: Colors.black),
          ElevatedButton(
              onPressed: () {
                showUpdateDialog(context);
              },
              child: const Text('Edit'))
        ],
      ),
    );
  }

  void showUpdateDialog(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jwt = prefs.getString('token') ?? '';

    final editUserProvider = Provider.of<EditUserProvider>(context, listen: false);
    editUserProvider.nameCtrl.text = name;
    editUserProvider.phoneCtrl.text = phone;
    editUserProvider.emailCtrl.text = email;

    final formKey = GlobalKey<FormState>();

    // ignore: use_build_context_synchronously
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    controller: editUserProvider.nameCtrl,
                    decoration: const InputDecoration(labelText: 'Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: editUserProvider.phoneCtrl,
                    decoration: const InputDecoration(labelText: 'Phone Number'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a phone number';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.phone,
                  ),
                  TextFormField(
                    controller: editUserProvider.emailCtrl,
                    decoration: const InputDecoration(labelText: 'email'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a email';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.phone,
                  ),
                  TextFormField(
                    controller: editUserProvider.passwordCtrl,
                    decoration: const InputDecoration(labelText: 'Password'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                        child: const Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('Update'),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            String newName = editUserProvider.nameCtrl.text;
                            String newPhoneNumber = editUserProvider.phoneCtrl.text;
                            String newEmail = editUserProvider.emailCtrl.text;
                            String password = editUserProvider.passwordCtrl.text;
                            EditUserProvider().updateUser(userId, username, newName,
                                newPhoneNumber, newEmail, jwt, password);
                            Navigator.of(context).pop();
                          }
                          getProfile();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
