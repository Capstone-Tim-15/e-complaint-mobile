import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HalamanDaftar(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HalamanDaftar extends StatefulWidget {
  const HalamanDaftar({super.key});

  @override
  State<HalamanDaftar> createState() => _HalamanDaftarState();
}

class _HalamanDaftarState extends State<HalamanDaftar> {
  final _formKey = GlobalKey<FormState>(); // Kunci global untuk form

  bool ingatkanSaya = false;
  bool obscureTextKataSandi = true;
  bool obscureTextKonfirmasiKS = true;

  TextEditingController conNama = TextEditingController();
  TextEditingController conNoTelp = TextEditingController();
  TextEditingController conEmail = TextEditingController();
  TextEditingController conUsername = TextEditingController();
  TextEditingController conKataSandi = TextEditingController();
  TextEditingController conKonfirmasiKS = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey, // Menggunakan kunci form
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Halo!",
                  style: TextStyle(fontSize: 40),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Text("Sudah mempunya akun?"),
                    TextButton(
                      onPressed: () {},
                      child: Text("Masuk Disini"),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: conNama,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Nama",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: conNoTelp,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Nomor Telepon",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nomor Telepon tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: conEmail,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "E-Mail",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email tidak boleh kosong';
                    } else if (!value.endsWith("@gmail.com")) {
                      return 'Harap masukkan akun Gmail';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: conUsername,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Username",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Username tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: conKataSandi,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Kata Sandi",
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscureTextKataSandi = !obscureTextKataSandi;
                        });
                      },
                      icon: Icon(
                        obscureTextKataSandi
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                  ),
                  obscureText: obscureTextKataSandi,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Kata Sandi tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: conKonfirmasiKS,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Konfirmasi Kata Sandi",
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscureTextKonfirmasiKS = !obscureTextKonfirmasiKS;
                        });
                      },
                      icon: Icon(
                        obscureTextKonfirmasiKS
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                  ),
                  obscureText: obscureTextKonfirmasiKS,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Konfirmasi Kata Sandi tidak boleh kosong';
                    } else if (value != conKataSandi.text) {
                      return 'Konfirmasi Kata Sandi tidak cocok';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                CheckboxListTile(
                  title: Text("Ingat Saya"),
                  value: ingatkanSaya,
                  onChanged: (newValue) {
                    setState(() {
                      ingatkanSaya = newValue!;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  height: 35,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Formulir valid, lakukan tindakan pendaftaran di sini
                        // Contoh: simpan data ke database atau lakukan login
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange, // Warna oranye
                    ),
                    child: Text("Masuk"),
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
