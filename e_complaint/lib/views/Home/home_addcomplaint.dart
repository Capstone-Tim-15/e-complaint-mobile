import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../models/complaint.dart';
// import 'package:video_player/video_player.dart';

class AddComplaint extends StatefulWidget {
  const AddComplaint({
    super.key,
    required this.selectedLocation,
    required this.selectedLocation2,
  });

  final String selectedLocation;
  final String selectedLocation2;

  @override
  State<AddComplaint> createState() => _AddComplaintState();
}

class _AddComplaintState extends State<AddComplaint> {
   TextEditingController tulisKeluhanController = TextEditingController();
  TextEditingController alamatController = TextEditingController();

  // Daftar kategori keluhan
  List<String> _items = [
    'Kekerasan',
    'Pelecehan',
    'Bulliying',
    'Sampah',
    'Pungli',
    'Infrastruktur',
    'Umum',
    'Pelayanan',
    'Keamanan',
  ];
  String _selectedItem = '';

  // File dan nama gambar untuk keluhan
  XFile? _imageFile;
  String? _imageName;
  VideoPlayerController? _videoPlayerController;
  String? _videoPath;
  String? _videoName;

  // Informasi pengguna
  String nama = 'Jeon Jungkook';
  String imagePath = 'assets/image/jk.jpeg';
  Color textColor = Color.fromARGB(255, 249, 171, 167);

  // static Future<Complaint?> postData(String categoryId, String title,
  //     String status, String content, File attachment) async {
  //   try {
  //     var response = await Dio()
  //         .post('https://api.govcomplain.my.id/user/complaint', data: {
  //       'categoryId': categoryId,
  //       'title': title,
  //       'status': status,
  //       'content': content,
  //       'attachment': attachment
  //     });

  //     if (response.statusCode == 201) {
  //       return Complaint(
  //         categoryId: response.data['categoryId'],
  //         title: response.data['title'],
  //         status: response.data['status'],
  //         content: response.data['content'],
  //         attachment: response.data['attachment'],
  //       );
  //     }
  //   } catch (e) {
  //     throw Exception(e.toString());
  //   }
  // }

  //====
  // static Future<Complaint?> postData(String categoryId, String title,
  //     String status, String content, File attachment) async {
  //   try {
  //     FormData formData = FormData.fromMap({
  //       'categoryId': categoryId,
  //       'title': title,
  //       'status': status,
  //       'content': content,
  //       'attachment': await MultipartFile.fromFile(
  //         attachment.path,
  //         filename: _getImageOrVideoName(attachment),
  //       ),
  //     });

  //     var response = await Dio().post(
  //       'https://api.govcomplain.my.id/user/complaint',
  //       data: formData,
  //     );

  //     if (response.statusCode == 201) {
  //       return Complaint(
  //         categoryId: response.data['categoryId'],
  //         title: response.data['title'],
  //         status: response.data['status'],
  //         content: response.data['content'],
  //         attachment: response.data['attachment'],
  //       );
  //     }
  //   } catch (e) {
  //     throw Exception(e.toString());
  //   }
  // }
  static Future<Complaint?> postData(String categoryId, String title,
      String status, String content, File attachment) async {
    try {
      FormData formData = FormData.fromMap({
        'categoryId': categoryId,
        'title': title,
        'status': status,
        'content': content,
        'attachment': await MultipartFile.fromFile(
          attachment.path,
          filename: _getImageOrVideoName(attachment),
        ),
      });

      var response = await Dio().post(
        'https://api.govcomplain.my.id/user/complaint',
        data: formData,
      );

      print(
          'Request sent successfully!'); // Menambahkan log bahwa permintaan dikirim

      if (response.statusCode == 201) {
        print(
            'Complaint successfully posted!'); // Menambahkan log bahwa keluhan berhasil diposting

        return Complaint(
          categoryId: response.data['categoryId'],
          title: response.data['title'],
          status: response.data['status'],
          content: response.data['content'],
          attachment: response.data['attachment'],
        );
      } else {
        print('Failed to post complaint. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error posting complaint: $e');
      throw Exception(e.toString());
    }
  }

// Helper function to get image or video name
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

  Future<void> _pickVideo() async {
    try {
      final XFile? pickedFile = await ImagePicker().pickVideo(
        source: ImageSource.gallery,
      );
      if (pickedFile != null) {
        _videoPlayerController =
            VideoPlayerController.file(File(pickedFile.path!))
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 239, 83, 72),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          // App bar untuk formulir keluhan
          leading: IconButton(
            onPressed: () {
              print('leading berhasil');
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
                      width: 25,
                    ),
                    Text(nama, style: TextStyle(fontSize: 18)),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                // Input teks untuk keluhan
                TextField(
                  maxLines: 3,
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
                // Menampilkan gambar yang dipilih
                Center(
                  child: Visibility(
                    visible:
                        _imageFile != null || _videoPlayerController != null,
                    child: Container(
                      width: 210,
                      height: 200,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Color.fromARGB(255, 249, 200, 197)),
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
                                      child:
                                          VideoPlayer(_videoPlayerController!),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        _videoPlayerController!.value.isPlaying
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
                              icon: Icon(Icons.image_outlined),
                            ),
                            Text(
                              _imageName != null
                                  ? _imageName! // Tampilkan nama gambar jika gambar dipilih
                                  : _videoName != null
                                      ? _videoName! // Tampilkan nama video jika video dipilih
                                      : 'Tambahkan Foto/Video',
                              style: TextStyle(
                                color:
                                    (_imageName == null && _videoName == null)
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
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.location_on_outlined),
                      ),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Tambah Alamat",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                              ),
                            ),
                          ),
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
                            return _items.map((String item) {
                              return PopupMenuItem(
                                value: item,
                                child: Container(
                                    width:
                                        MediaQuery.of(context).size.width - 0,
                                    child: Text(item,
                                        style: TextStyle(color: Colors.red))),
                              );
                            }).toList();
                          },
                          onSelected: (String item) {
                            setState(() {
                              _selectedItem = item;
                            });
                          },
                          child: Icon(Icons.grid_view, color: Colors.red),
                        ),
                      ),
                      SizedBox(width: 20),
                      AnimatedSwitcher(
                        duration: Duration(milliseconds: 250),
                        child: _selectedItem.isEmpty
                            ? Text('Pilih Kategori',
                                style: TextStyle(color: Colors.red))
                            : Text(
                                _selectedItem,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
                // Container(
                //   padding: EdgeInsets.only(left: 10),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Icon(Icons.grid_view),
                //       Container(
                //         margin: EdgeInsets.all(8),
                //         padding: EdgeInsets.symmetric(
                //           horizontal: 10,
                //         ),
                //         decoration: BoxDecoration(
                //           border: Border.all(color: Colors.red, width: 0),
                //           color: Colors.white,
                //           borderRadius: BorderRadius.circular(10),
                //         ),
                //         child: DropdownButton<CategoryName?>(
                //           hint: Text(
                //             'Pilih Kategori',
                //             style: TextStyle(
                //               fontSize: 14,
                //               color: textColor,
                //             ),
                //           ),
                //           value: selectedValue,
                //           onChanged: (value) {
                //             setState(() {
                //               selectedValue = value;
                //             });
                //           },
                //           underline: SizedBox(),
                //           items: category
                //               .map<DropdownMenuItem<CategoryName>>(
                //                 (e) => DropdownMenuItem(
                //                   child: Text((e?.name ?? '').toString()),
                //                   value: e,
                //                 ),
                //               )
                //               .toList(),
                //           dropdownColor: Colors.white,
                //           iconEnabledColor: Colors.red,
                //           style: TextStyle(color: Colors.black),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                const SizedBox(
                  height: 80,
                ),
                // Tombol untuk memposting keluhan
                Container(
                  width: double.infinity,
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: () async {
                      // Logika yang dijalankan saat tombol ditekan.
                      try {
                        String categoryId = _getCategoryIdByName(_selectedItem);
                        String title = tulisKeluhanController.text;
                        String status = 'open'; // Ubah status sesuai kebutuhan
                        String content = tulisKeluhanController.text;

                        if (_imageFile != null ||
                            _videoPlayerController != null) {
                          Complaint? result = await postData(
                            categoryId,
                            title,
                            status,
                            content,
                            _imageFile != null
                                ? File(_imageFile!.path)
                                : File(_videoPath!),
                          );

                          if (result != null) {
                            // Lakukan sesuatu setelah posting berhasil
                          }
                        }
                      } catch (e) {
                        print('Error posting complaint: $e');
                      }
                      // Logika yang dijalankan saat tombol ditekan.
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Fungsi untuk membuka peta (placeholder lokasi)
  void openMaps() async {
    // Ganti koordinat dengan nilai yang sesuai dengan lokasi yang ingin ditampilkan
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

  void _editMedia() async {
    if (_imageFile != null) {
      // Implementasi logika edit untuk gambar
      _editImage();
    } else if (_videoPath != null) {
      // Implementasi logika edit untuk video
      _editVideo();
    }
  }

  void _deleteMedia() {
    setState(() {
      if (_imageFile != null) {
        // Implementasi logika delete untuk gambar
        _deleteImage();
      } else if (_videoPlayerController != null) {
        // Implementasi logika delete untuk video
        _deleteVideo();
      }
    });
  }

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

  void _toggleVideoPlayPause() {
    setState(() {
      if (_videoPlayerController!.value.isPlaying) {
        _videoPlayerController!.pause();
      } else {
        _videoPlayerController!.play();
      }
    });
  }

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

  String _getCategoryIdByName(String categoryName) {
    // Implementasi sesuai dengan kebutuhan
    // Anda dapat memiliki daftar kategori dan mencocokkan nama dengan ID
    // Contoh sederhana:
    switch (categoryName) {
      case 'Kekerasan':
        return '1';
      case 'Pelecehan':
        return '2';
      // tambahkan kategori lainnya...
      default:
        return '0'; // ID default jika tidak ditemukan
    }
  }
}


