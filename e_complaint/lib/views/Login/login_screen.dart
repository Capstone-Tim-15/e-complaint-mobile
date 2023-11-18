import 'package:flutter/material.dart';

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
                height: 50,
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
                        fontSize: 54,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w600,
                        height: 0.02,
                      ),
                    ),
                    const SizedBox(height: 20),
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
                              fontSize: 14,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w700,
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
                                  fontSize: 14,
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
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
                      height: 10,
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
                                fontSize: 14,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 175,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (Form.of(context).validate()) {
                            _handleLogin();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Color(0xFFEC7B73),
                        ),
                        child: Text('Login'),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleLogin() {
    // Implementasi logika login di sini
    String username = usernameController.text;
    String password = passwordController.text;

    // Contoh logika sederhana, Anda harus menggantinya dengan logika yang sesuai
    if (username == 'user' && password == 'password') {
      // Login berhasil, lanjutkan dengan navigasi ke halaman beranda
      Navigator.pushNamed(context, '/home');
    } else {
      // Tampilkan pesan kesalahan atau tindakan yang sesuai
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Login Gagal'),
          content: Text('Username atau password salah.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
