// ignore_for_file: prefer_const_constructors

import 'package:dio/dio.dart';
import 'package:e_complaint/views/widget/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;
  bool rememberMe = false;
  final Dio _dio = Dio();

  Future<Response> login(String username, String password) {
    return _dio.post(
      'http://34.128.69.15:8000/user/login', // Sesuaikan dengan skema URL yang benar
      data: {
        'username': username,
        'password': password,
      },
    );
  }

  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 150,
              ),
              Container(
                width: 265,
                height: 88,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Halo!',
                      style: TextStyle(
                        color: Color(0xFF191C1D),
                        fontSize: 57,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w400,
                        height: 0.02,
                        letterSpacing: -0.25,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Belum mempunyai akun?',
                            style: TextStyle(
                              color: Color(0xFF191C1D),
                              fontSize: 16,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/register');
                            },
                            child: Text(
                              ' Buat akun disini',
                              style: TextStyle(
                                color: Color(0xFF990000),
                                fontSize: 16,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: usernameController,
                      decoration: const InputDecoration(
                        labelText: "Username",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Color(0xFFEC7B73),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Username harus diisi';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Kata Sandi',
                        suffixIcon: IconButton(
                          icon: Icon(
                            isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                        ),
                      ),
                      obscureText: !isPasswordVisible,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password harus diisi';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/forgotpwd');
                          },
                          child: Text(
                            'Lupa Kata Sandi?',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: rememberMe,
                              onChanged: (value) {
                                setState(() {
                                  rememberMe = value!;
                                });
                              },
                            ),
                            Text(
                              'Ingat Saya',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 220,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          try {
                            var response = await login(
                              usernameController.text,
                              passwordController.text,
                            );

                            if (response.statusCode == 200) {
                              // Assuming response is in the format you provided
                              Map<String, dynamic> responseData = response.data;

                              // Check if 'meta' field indicates success
                              if (responseData['meta']['success'] == true) {
                                // Extract token from the 'results' field
                                String? token =
                                    responseData['results']['token'];

                                if (token != null) {
                                  // Save token to Shared Preferences
                                  await saveToken(token);

                                  // Navigate to the home page and remove all previous routes
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BottomNavigation()), // Gantilah dengan halaman beranda yang sesuai
                                    (Route<dynamic> route) => false,
                                  );
                                } else {
                                  print('Token is null in the response');
                                  // Handle the case where the token is null
                                }
                              } else {
                                print(
                                    'Login failed: ${responseData['meta']['message']}');
                                // Handle login failure here
                              }
                            } else {
                              print('Login failed: ${response.statusCode}');
                              // Handle login failure here
                            }
                          } catch (error) {
                            print('Error during login: $error');
                            // Handle other errors during login
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Color(0xFFEC7B73),
                        ),
                        child: Text('Masuk'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
