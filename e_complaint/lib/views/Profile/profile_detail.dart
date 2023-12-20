import 'package:e_complaint/models/user_profile.dart';
import 'package:e_complaint/viewModels/provider/edit_profile.dart';
import 'package:e_complaint/viewModels/provider/profile_id.dart';
import 'package:e_complaint/views/Profile/profile_edit_success.dart';
import 'package:e_complaint/views/Profile/profile_page.dart';
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
  final ProfileIdProvider _profileIdProvider = ProfileIdProvider();
  UserProfile? user; // Change UserProfile to be nullable
  late String userName;
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
    fetchUserProfile();
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
        automaticallyImplyLeading: false,
        shadowColor: const Color.fromARGB(255, 248, 248, 248),
        backgroundColor: const Color.fromARGB(255, 255, 253, 253),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
                iconSize: 25,
                icon: const Icon(Icons.arrow_back),
                color: const Color.fromARGB(255, 255, 0, 0),
                onPressed: () {
                  Navigator.pushNamed(context, '/profile');
                }),
            const Text(
              "Detail Profil",
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 19,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
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
                      print(
                          "Profile image ditekan, ubah gambar jika diperlukan");
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
                        color: Colors.grey.withOpacity(0.5),
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
              padding: const EdgeInsets.only(
                  right: 16, left: 16, top: 10, bottom: 10),
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
            const Divider(color: Colors.grey),
            //bio
            Container(
              height: 45,
              padding: const EdgeInsets.only(
                  right: 16, left: 16, top: 10, bottom: 10),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      "Username",
                      style: TextStyle(
                        fontFamily: "Nunito",
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      username,
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
            const Divider(color: Colors.grey),
            //no hp
            Container(
              height: 45,
              padding: const EdgeInsets.only(
                  right: 16, left: 16, top: 10, bottom: 10),
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
            const Divider(color: Colors.grey),
            //email
            Container(
              height: 45,
              padding: const EdgeInsets.only(
                  right: 16, left: 16, top: 10, bottom: 10),
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
            const Divider(color: Colors.grey),
            ElevatedButton(
                onPressed: () {
                  showUpdateDialog(context);
                },
                child: const Text('Edit'))
          ],
        ),
      ),
    );
  }

  void showUpdateDialog(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jwt = prefs.getString('token') ?? '';

    // ignore: use_build_context_synchronously
    final editUserProvider =
        Provider.of<EditUserProvider>(context, listen: false);
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
                  const Text(
                    "Edit Profile",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
                    decoration:
                        const InputDecoration(labelText: 'Phone Number'),
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
                    obscureText: true,
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
                            String newPhoneNumber =
                                editUserProvider.phoneCtrl.text;
                            String newEmail = editUserProvider.emailCtrl.text;
                            String password =
                                editUserProvider.passwordCtrl.text;
                            EditUserProvider().updateUser(
                                userId,
                                username,
                                newName,
                                newPhoneNumber,
                                newEmail,
                                jwt,
                                password);
                            prefs.remove('id');
                            prefs.setString('name', newName);
                            prefs.remove('username');
                            prefs.remove('email');
                            prefs.remove('phone');
                            prefs.remove('imageUrl');
                            prefs.getKeys().forEach((key) {
                              print('$key: ${prefs.get(key)}');
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditSuccess()),
                            );
                          }
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

  Future<void> saveProfile(String id, String username, String name,
      String email, String phone, String imageUrl) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('id', id);
    await prefs.setString('username', username);
    await prefs.setString('name', name);
    await prefs.setString('email', email);
    await prefs.setString('phone', phone);
    await prefs.setString('imageUrl', imageUrl);
  }

  Future<void> fetchUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('id') ?? '';
    String? jwt = prefs.getString('beareToken') ?? '';

    try {
      Map<String, dynamic> userData =
          await _profileIdProvider.getUserByName(id, jwt);

      setState(() {
        user = UserProfile(
          id: userData['results']['id'],
          username: userData['results']['username'],
          name: userData['results']['name'],
          profileImageUrl: userData['results']['imageUrl'] ?? '',
          coverImageUrl: userData['results']['coverImageUrl'] ?? '',
          email: userData['results']['email'] ?? '',
          phoneNumber: userData['results']['phone'] ?? '',
        );
        saveProfile(
          user!.id,
          user!.username,
          user!.name,
          user!.email,
          user!.phoneNumber,
          user!.profileImageUrl,
        );
        getProfile();
      });
    } catch (error) {
      print('Error fetching user profile: $error');
    }
  }
}
