import 'dart:async';
import 'dart:io';
import 'package:e_complaint/viewModels/provider/complaint.dart';
import 'package:e_complaint/views/Home/addcomplaint_location.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
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
  bool isJalanSelected = false;
  // Daftar kategori keluhan
  List<CategoryName> category = [
    CategoryName(id: 1, name: "Kekerasan"),
    CategoryName(id: 2, name: "Pelecehan"),
    CategoryName(id: 3, name: "Bulliying"),
    CategoryName(id: 4, name: "Sampah"),
    CategoryName(id: 5, name: "Pungli"),
    CategoryName(id: 6, name: "Infrastruktur"),
    CategoryName(id: 7, name: "Umum"),
    CategoryName(id: 8, name: "Pelayanan"),
    CategoryName(id: 9, name: "Keamanan"),
  ];

  // Kategori keluhan yang dipilih
  CategoryName? selectedValue;

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

  void handleLocationSelection() {
    // Lakukan logika pemilihan lokasi, dan kemudian atur nilai isJalanSelected
    setState(() {
      isJalanSelected = true; // Mengubah nilai menjadi kebalikannya
    });
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
    final complaintProvider = Provider.of<AddComplaintProvider>(context);
    print(complaintProvider.selectedLocation);
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
                        onPressed: () {
                          // Panggil fungsi handleLocationSelection saat tombol ditekan
                          handleLocationSelection();

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ComplaintLocation(),
                            ),
                          );
                        },
                        icon: Icon(Icons.location_on_outlined),
                      ),
                      Visibility(
                        visible: !isJalanSelected,
                        child: Text(
                          complaintProvider.selectedLocation,
                          style: TextStyle(
                            color: textColor,
                           
                          ),
                        ),
                      ),
                      Visibility(
                        visible: isJalanSelected,
                        child: Text(
                          '${widget.selectedLocation2 ?? ''}, ${widget.selectedLocation ?? ''}',
                          style: TextStyle(
                            color: textColor,
                           
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.grid_view),
                      Container(
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.red, width: 0),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: DropdownButton<CategoryName?>(
                          hint: Text(
                            'Pilih Kategori',
                            style: TextStyle(
                              fontSize: 14,
                              color: textColor,
                            ),
                          ),
                          value: selectedValue,
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value;
                            });
                          },
                          underline: SizedBox(),
                          items: category
                              .map<DropdownMenuItem<CategoryName>>(
                                (e) => DropdownMenuItem(
                                  child: Text((e.name ?? '').toString()),
                                  value: e,
                                ),
                              )
                              .toList(),
                          dropdownColor: Colors.white,
                          iconEnabledColor: Colors.red,
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                // Tombol untuk memposting keluhan
                Container(
                  width: double.infinity,
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: () {
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
}

// Kelas yang mewakili kategori keluhan
class CategoryName {
  CategoryName({this.id, this.name});

  int? id;
  String? name;
}
