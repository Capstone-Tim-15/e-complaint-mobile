// ignore_for_file: prefer_const_constructors

import 'package:e_complaint/viewModels/provider/register.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HalamanDaftar extends StatelessWidget {
  const HalamanDaftar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final registrationProvider = Provider.of<RegistrationProvider>(context);

    TextEditingController conpassword = TextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: registrationProvider.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 175),
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
                Row(
                  children: [
                    Text(
                      "Sudah mempunya akun?",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        height: 0.08,
                        fontSize: 16,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: Text(
                        "Masuk Disini",
                        style: TextStyle(
                          color: Color(0xFF990000),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                          height: 0.08,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                TextFormField(
                  controller: registrationProvider.name,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Nama",
                      helperStyle:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  validator: (value) =>
                      registrationProvider.validateField(value, "Nama"),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: registrationProvider.phone,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Nomor Telepon",
                      helperStyle: TextStyle()),
                  validator: (value) => registrationProvider.validateField(
                      value, "Nomor Telepon"),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: registrationProvider.email,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "E-Mail",
                  ),
                  validator: (value) =>
                      registrationProvider.validateEmail(value),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: registrationProvider.username,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Username",
                  ),
                  validator: (value) =>
                      registrationProvider.validateField(value, "Username"),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: registrationProvider.password,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Kata Sandi",
                    suffixIcon: IconButton(
                      onPressed: () {
                        registrationProvider.togglePasswordVisibility();
                      },
                      icon: Icon(
                        registrationProvider.obscureTextKataSandi
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                  ),
                  obscureText: registrationProvider.obscureTextKataSandi,
                  validator: (value) =>
                      registrationProvider.validateField(value, "Kata Sandi"),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: conpassword,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Konfirmasi Kata Sandi",
                    suffixIcon: IconButton(
                      onPressed: () {
                        registrationProvider.togglePasswordVisibility();
                      },
                      icon: Icon(
                        registrationProvider.obscureTextKataSandi
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                SizedBox(
                  width: double.infinity,
                  height: 35,
                  child: ElevatedButton(
                    onPressed: () async {
                      await registrationProvider.register(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFEC7B73),
                    ),
                    child: Text("Buat Akun"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
