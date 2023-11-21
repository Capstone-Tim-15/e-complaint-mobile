import 'package:e_complaint/viewModels/provider/register.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HalamanDaftar extends StatelessWidget {
  const HalamanDaftar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RegistrationProvider(),
      child: _HalamanDaftarContent(),
    );
  }
}

class _HalamanDaftarContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final registrationProvider = Provider.of<RegistrationProvider>(context);

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
                SizedBox(height: 80),
                Text(
                  'Halo!',
                  style: TextStyle(
                    color: Color(0xFF191C1D),
                    fontSize: 57,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 50),
                TextFormField(
                  controller: registrationProvider.name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Nama",
                  ),
                  validator: (value) =>
                      registrationProvider.validateField(value, "Nama"),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: registrationProvider.phone,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Nomor Telepon",
                  ),
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
                SizedBox(height: 90),
                Container(
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
