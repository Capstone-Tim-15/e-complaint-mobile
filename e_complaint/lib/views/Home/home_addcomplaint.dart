import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

// Kelas untuk berinteraksi dengan API keluhan
class ComplaintApiService {
  final Dio _dio = Dio();
  SharedPreferences? _prefs;
  String? bearerToken;

  // Inisialisasi shared preferences dan token
  Future<void> _initPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
    bearerToken ??= _prefs!.getString('bearerToken');
  }

  // Mendapatkan nama pengguna dari shared preferences
  Future<String?> getUserName() async {
    await _initPrefs();
    return _prefs!.getString('name');
  }

// Mendapatkan kategori dari API
  Future<Response> getCategory() async {
    await _initPrefs();

    try {
      final response =
          await _dio.get('https://api.govcomplain.my.id/user/category');
      print('Category API Response: ${response.data}');
      return response;
    } catch (e) {
      print('Error getting category: $e');
      throw e;
    }
  }

  // Mengirim keluhan ke API
  Future<Response> postComplaint({
    required String categoryId,
    required String title,
    // required String status,
    required String content,
    required XFile attachment,
  }) async {
    try {
      await _initPrefs();
      print('Bearer Token: $bearerToken');

      // Memastikan data input valid
      if (categoryId.isEmpty ||
          title.isEmpty ||
          content.isEmpty ||
          attachment == null) {
        throw ArgumentError('Invalid input data');
      }

// Membaca file attachment sebagai bytes
      final bytes = await File(attachment.path).readAsBytes();

      // Membuat FormData untuk dikirim ke API
      var formData = FormData.fromMap({
        'categoryId': categoryId,
        'title': title,
        'content': content,
        'attachment': MultipartFile.fromBytes(bytes, filename: attachment.name),
      });

// Mengirim data ke API menggunakan metode POST
      final response = await _dio.post(
        'https://api.govcomplain.my.id/user/complaint',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $bearerToken',
          },
        ),
      );

      print('Post Complaint API Response: ${response.data}');
      return response;
    } catch (e) {
      print('Error posting complaint: $e');
      print(categoryId);

      throw e;
    }
  }

// Membuat FormData untuk keluhan
  FormData _createFormData(
    String categoryId,
    String title,
    //String status,
    String content,
    XFile attachment,
  ) {
    return FormData.fromMap({
      'categoryId': categoryId,
      'title': title,
      // 'status': status,
      'content': content,
      'attachment':
          MultipartFile.fromFile(attachment.path, filename: attachment.name),
    });
  }
}

// Kelas Stateful untuk halaman penambahan keluhan
class AddComplaint extends StatefulWidget {
  @override
  State<AddComplaint> createState() => _AddComplaintState();
}

class _AddComplaintState extends State<AddComplaint> {
  final ComplaintApiService _complaintApiService = ComplaintApiService();
  TextEditingController tulisKeluhanController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  List<Map<String, dynamic>> _categoryList = [];
  String nama = '';
  String _selectedItem = '';
  int _selectedCategoryIndex = -1;

  // File dan nama gambar untuk keluhan
  XFile? _imageFile;
  String? _imageName;
  VideoPlayerController? _videoPlayerController;
  String? _videoPath;
  String? _videoName;

  // Informasi pengguna

  String imagePath = 'assets/image/jk.jpeg';
  Color textColor = Color.fromARGB(255, 249, 171, 167);

  @override
  void initState() {
    super.initState();
    _fetchCategories();
    _fetchUserName(); // Mengambil nama pengguna ketika widget diinisialisasi
  }

// Mengambil nama pengguna dari API
  Future<void> _fetchUserName() async {
    try {
      final username = await _complaintApiService.getUserName();
      if (username != null) {
        setState(() {
          nama = username;
        });
      }
    } catch (e) {
      print('Error loading user name: $e');
      // Handle the error as needed
    }
  }

  // Mengambil kategori dari API
  Future<void> _fetchCategories() async {
    try {
      final response = await _complaintApiService.getCategory();
      if (response.statusCode == 200) {
        List<dynamic> results = response.data['results'];

        setState(() {
          _categoryList = results
              .map((category) =>
                  {'id': category['id'], 'name': category['CategoryName']})
              .toList();
          if (_categoryList.isNotEmpty) {
            _selectedCategoryIndex = 0;
            _selectedItem = _categoryList[0]['name'];
          }
        });
      } else {
        print('Failed to load categories: ${response.statusCode}');
        // Implement error handling here
      }
    } catch (e) {
      print('Error loading categories: $e');
      // Implement error handling here
    }
  }

  // Fungsi untuk mendapatkan nama gambar atau video
  static String _getImageOrVideoName(File file) {
    return file.path.split('/').last;
  }

  // Fungsi untuk memilih gambar dari galeri
  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await ImagePicker().pickImage(
        source: source,
      );
      setState(() {
        _imageFile = pickedFile;
        _imageName = pickedFile?.name;
      });
    } catch (e) {
      setState(() {
        _imageFile = null;
      });
      print('Error picking image: $e');
    }
  }

// Fungsi untuk memilih video dari galeri
  Future<void> _pickVideo() async {
    try {
      final XFile? pickedFile = await ImagePicker().pickVideo(
        source: ImageSource.gallery,
      );
      if (pickedFile != null) {
        _videoPlayerController =
            VideoPlayerController.file(File(pickedFile.path))
              ..initialize().then((_) {
                setState(() {});
                _videoPlayerController!.play();
              });

        final String fileName =
            '${DateTime.now().millisecondsSinceEpoch}_${pickedFile.path.split('/').last}';
        setState(() {
          _videoPath = pickedFile.path;
          _videoName = fileName;
        });

        print('_videoName: $_videoName'); // Tambahkan log ini
      }
    } catch (e) {
      print('Error picking video: $e');
    }
  }

// Membuat tampilan untuk halaman penambahan keluhan
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // App bar untuk formulir keluhan
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: const Text('Buat Keluhan'),
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(
            color: Color.fromARGB(255, 239, 83, 72),
          ),
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontSize: 18,
            fontStyle: FontStyle.normal,
          ),
        ),
        body: Container(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                  // Komponen formulir keluhan
                  children: [
                    // Tampilan informasi pengguna
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25.0,
                          backgroundImage: AssetImage(imagePath),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(nama, style: TextStyle(fontSize: 18)),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    // Input teks untuk keluhan
                    TextField(
                      maxLines: 3,
                      controller: tulisKeluhanController,
                      cursorColor: Colors.red,
                      decoration: InputDecoration(
                        hintText: 'Tulis keluhan anda...',
                        hintStyle: TextStyle(
                          color: const Color.fromARGB(255, 237, 109, 94),
                        ),
                        fillColor: Color.fromARGB(255, 249, 219, 216),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 249, 200, 197),
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 240, 119, 110),
                            width: 2.0,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 25,
                          horizontal: 16.0,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // Menampilkan gambar atau video yang dipilih
                    Center(
                      child: Visibility(
                        visible: _imageFile != null ||
                            _videoPlayerController != null,
                        child: Container(
                          width: 210,
                          height: 200,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.red.shade400),
                          ),
                          child: _imageFile?.path != null
                              ? Image.file(File(_imageFile!.path),
                                  fit: BoxFit.cover)
                              : _videoPlayerController != null
                                  ? Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        AspectRatio(
                                          aspectRatio: _videoPlayerController!
                                              .value.aspectRatio,
                                          child: VideoPlayer(
                                              _videoPlayerController!),
                                        ),
                                        IconButton(
                                          color: Colors.red.shade300,
                                          icon: Icon(
                                            _videoPlayerController!
                                                    .value.isPlaying
                                                ? Icons.pause
                                                : Icons.play_arrow,
                                          ),
                                          onPressed: () {
                                            _toggleVideoPlayPause();
                                          },
                                        ),
                                      ],
                                    )
                                  : Container(),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 25,
                    ),
                    // Tombol pemilihan gambar
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Tombol untuk memilih gambar dari galeri
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    _showImageOptions(); // Panggil fungsi untuk menampilkan bottom sheet
                                  },
                                  icon: Icon(
                                    Icons.image_outlined,
                                    color: Colors.red.shade400,
                                  ),
                                ),
                                Text(
                                  _imageName != null
                                      ? _imageName! // Tampilkan nama gambar jika gambar dipilih
                                      : _videoName != null
                                          ? _videoName! // Tampilkan nama video jika video dipilih
                                          : 'Tambahkan Foto/Video',
                                  style: TextStyle(
                                    color: (_imageName == null &&
                                            _videoName == null)
                                        ? textColor
                                        : Colors.black,
                                  ),
                                ),
                              ],
                            ),

                            // Tombol untuk mengedit dan menghapus gambar yang dipilih
                            // Tombol untuk mengedit dan menghapus gambar yang dipilih
                            if (_imageName != null || _videoName != null)
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      _editMedia();
                                    },
                                    icon: Icon(Icons.mode_edit_outlined),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      _deleteMedia();
                                    },
                                    icon: Icon(Icons.delete_outline),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // Tombol untuk menambahkan lokasi
                    Container(
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: alamatController,
                              decoration: InputDecoration(
                                  labelText: 'Tambah Alamat',
                                  labelStyle:
                                      TextStyle(color: Colors.red.shade400),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1,
                                    ),
                                  ),
                                  prefixIcon: Icon(Icons.location_on_outlined),
                                  prefixIconColor: Colors.red.shade400),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    // Dropdown untuk memilih kategori keluhan
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedItem = '';
                              });
                            },
                            child: PopupMenuButton<String>(
                              itemBuilder: (BuildContext context) {
                                return _categoryList
                                    .map<PopupMenuEntry<String>>(
                                        (Map<String, dynamic> category) {
                                  return PopupMenuItem<String>(
                                    value: category['name'],
                                    child: Container(
                                      width:
                                          MediaQuery.of(context).size.width - 0,
                                      child: Text(
                                        category['name'],
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  );
                                }).toList();
                              },
                              onSelected: (String item) {
                                setState(() {
                                  _selectedItem = item;
                                  _selectedCategoryIndex =
                                      _categoryList.indexWhere((category) =>
                                          category['name'] == item);
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    Icon(Icons.grid_view, color: Colors.red),
                                    SizedBox(width: 5),
                                    Text(
                                      _selectedItem.isEmpty
                                          ? 'Pilih Kategori'
                                          : _selectedItem,
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 20),

                    const SizedBox(
                      height: 80,
                    ),
                    // Tombol untuk memposting keluhan
                    Container(
                      width: double.infinity,
                      height: 50.0,
                      child: ElevatedButton(
                        onPressed: () async {
                          String categoryId =
                              _getCategoryIdByName(_selectedItem);
                          try {
                            Response response =
                                await _complaintApiService.postComplaint(
                              categoryId: categoryId,
                              title: alamatController.text,
                              // status: 'SEND',
                              content: tulisKeluhanController.text,
                              attachment: _imageFile!,
                            );
                            if (response.statusCode == 201) {
                              print(response.data);
// Show a Snackbar
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text('Complaint posted successfully!'),
                                  duration: Duration(
                                      seconds:
                                          2), // You can adjust the duration
                                ),
                              );

                              // Navigate to home after a delay (to give time for the user to read the Snackbar)
                              Future.delayed(Duration(seconds: 2), () {
                                Navigator.pushNamed(context, '/news');
                              });
                            } else {
                              print(response.statusMessage);
                            }
                          } catch (e) {
                            print(e);
                          }
                        },
                        child: const Text(
                          'Posting',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 243, 82, 64),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                    ),
                  ]),
            )));
  }

  // Fungsi untuk mengedit gambar yang dipilih
  void _editImage() async {
    try {
      final XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if (pickedFile != null) {
        final String fileName = pickedFile.path.split('/').last;
        setState(() {
          _imageFile = pickedFile;
          _imageName = fileName;
        });
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  // Fungsi untuk menghapus gambar yang dipilih
  void _deleteImage() {
    setState(() {
      _imageFile = null;
      _imageName = null;
    });
  }

// Fungsi untuk mengedit media (gambar atau video) yang dipilih
  void _editMedia() async {
    if (_imageFile != null) {
      // Jika gambar dipilih, implementasikan logika edit gambar
      _editImage();
    } else if (_videoPath != null) {
      // Jika video dipilih, implementasikan logika edit video
      _editVideo();
    }
  }

// Fungsi untuk menghapus media (gambar atau video) yang dipilih
  void _deleteMedia() {
    setState(() {
      if (_imageFile != null) {
        // Jika gambar dipilih, implementasikan logika delete gambar
        _deleteImage();
      } else if (_videoPlayerController != null) {
        // Jika video dipilih, implementasikan logika delete video
        _deleteVideo();
      }
    });
  }

// Fungsi untuk mengedit video yang dipilih
  void _editVideo() async {
    try {
      final XFile? pickedFile = await ImagePicker().pickVideo(
        source: ImageSource.gallery,
      );
      if (pickedFile != null) {
        // Hentikan dan buang objek VideoPlayerController yang terkait dengan video lama
        _videoPlayerController?.dispose();

        final String fileName = pickedFile.path.split('/').last;
        setState(() {
          _videoPath = pickedFile.path;
          _videoName = fileName;

          // Inisialisasi controller video baru
          _videoPlayerController =
              VideoPlayerController.file(File(_videoPath!));
          print('Video Path: $_videoPath');

          _videoPlayerController!.initialize().then((_) {
            print('Video Initialization Successful');
            setState(() {});
          });
        });
      }
    } catch (e) {
      print('Error picking video: $e');
    }
  }

// Fungsi untuk menghapus video yang dipilih
  void _deleteVideo() {
    setState(() {
      _videoPlayerController?.dispose();
      _videoPlayerController = null;
      _videoPath = null;
      _videoName = null;
    });
  }

// Fungsi untuk memutar atau menghentikan video
  void _toggleVideoPlayPause() {
    setState(() {
      if (_videoPlayerController!.value.isPlaying) {
        _videoPlayerController!.pause();
      } else {
        _videoPlayerController!.play();
      }
    });
  }

// Menampilkan opsi pemilihan gambar atau video dalam BottomSheet
  void _showImageOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.image),
                title: Text('Pilih Gambar'),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.videocam),
                title: Text('Pilih Video'),
                onTap: () {
                  _pickVideo(); // Implementasi untuk memilih video
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

// Mendapatkan ID kategori berdasarkan nama kategori
  String _getCategoryIdByName(String categoryName) {
    // Mencari kategori berdasarkan nama
    Map<String, dynamic>? selectedCategory = _categoryList.firstWhere(
      (category) => category['name'] == categoryName,
      orElse: () => Map<String, dynamic>.from({'id': '0'}),
    );

    // Mengembalikan ID dari kategori yang ditemukan atau '0' jika tidak ditemukan
    return selectedCategory['id'].toString();
  }
}
