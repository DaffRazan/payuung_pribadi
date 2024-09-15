import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:payuung_pribadi/screens/home_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int activeStep = 0;
  final TextEditingController _birthDateController = TextEditingController();

  File? _image; // To store the picked image file
  final ImagePicker _picker = ImagePicker(); // Image picker instance

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Current date
      firstDate: DateTime(2000), // Earliest date
      lastDate: DateTime(2101), // Latest date
    );

    if (pickedDate != null) {
      setState(() {
        // Format the picked date and set it in the text field
        _birthDateController.text =
            DateFormat("d MMMM yyyy").format(pickedDate);
        ;
      });
    }
  }

  // Initial selected value
  String? selectedGender;
  String? selectedPendidikan;
  String? selectedMaritalStatus;

  // List of gender options
  final List<String> genderOptions = ['Laki-Laki', 'Perempuan'];
  final List<String> pendidikanOptions = ['SD', 'SMP', 'SMA', 'D1', 'D2', 'D3'];
  final List<String> maritalStatusOptions = [
    'Belum Kawin',
    'Kawin',
    'Janda',
    'Duda'
  ];

  Future<void> _showImagePickerOptions() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text('Ambil gambar dari kamera'),
                onTap: () {
                  _pickImage(ImageSource.camera); // Call the camera
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Ambil gambar dari galleri'),
                onTap: () {
                  _pickImage(ImageSource.gallery); // Call the gallery
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image =
            File(pickedFile.path); // Update the state with the picked image
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
        title: const Text(
          'Informasi Pribadi',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      body: Stepper(
        currentStep: activeStep,
        onStepTapped: (index) => setState(() => activeStep = index),
        onStepContinue: () {
          if (activeStep != 2) {
            setState(() {
              activeStep++;
            });
          } else {
            Get.off(const HomeScreen());
          }
        },
        onStepCancel: () {
          if (activeStep != 0) {
            setState(() {
              activeStep--;
            });
          }
        },
        type: StepperType.horizontal,
        steps: [
          Step(
            isActive: activeStep == 0,
            label: Text(
              'Biodata Diri',
              style: TextStyle(
                  color: (activeStep == 0 || activeStep == 1 || activeStep == 2)
                      ? Colors.amber
                      : Colors.amber[200]),
            ),
            title: const Text(' '),
            content: _buildBiodataDiriSection(),
          ),
          Step(
            isActive: activeStep == 1,
            label: Text(
              'Alamat Pribadi',
              style: TextStyle(
                color: (activeStep == 1 || activeStep == 2)
                    ? Colors.amber
                    : Colors.amber[200],
              ),
            ),
            title: const Text(''),
            content: _buildAlamatPribadi(),
          ),
          Step(
            isActive: activeStep == 2,
            label: Text(
              'Info Perusahaan',
              style: TextStyle(
                color: (activeStep == 2) ? Colors.amber : Colors.amber[200],
                fontSize: 16,
              ),
            ),
            title: const Text(''),
            content: _buildInformasiPerusahaan(),
          ),
        ],
      ),
    );
  }

  Widget _buildInformasiPerusahaan() {
    return const Column(
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: 'NAMA USAHA / PERUSAHAAN',
          ),
        ),
        TextField(
          decoration: InputDecoration(
            labelText: 'ALAMAT USAHA / PERUSAHAAN',
          ),
        ),
        TextField(
          decoration: InputDecoration(
            labelText: 'JABATAN',
          ),
        ),
        TextField(
          decoration: InputDecoration(
            labelText: 'LAMA BEKERJA',
          ),
        ),
        TextField(
          decoration: InputDecoration(
            labelText: 'SUMBER PENDAPATAN',
          ),
        ),
        TextField(
          decoration: InputDecoration(
            labelText: 'PENDAPATAN KOTOR PERTAHUN',
          ),
        ),
        TextField(
          decoration: InputDecoration(
            labelText: 'NAMA BANK',
          ),
        ),
        TextField(
          decoration: InputDecoration(
            labelText: 'CABANG BANK',
          ),
        ),
        TextField(
          decoration: InputDecoration(
            labelText: 'NOMOR REKENING',
          ),
        ),
        TextField(
          decoration: InputDecoration(
            labelText: 'NAMA PEMILIK REKENING',
          ),
        ),
      ],
    );
  }

  Widget _buildAlamatPribadi() {
    return Column(
      children: [
        _image != null
            ? Image.file(_image!, height: 200, width: 200, fit: BoxFit.cover)
            : const Text('Tidak ada gambar KTP yang terpilih.'),
        const SizedBox(height: 20),
        IconButton(
          icon: const Icon(Icons.add_a_photo),
          iconSize: 50.0,
          color: Colors.amber,
          onPressed: _showImagePickerOptions, // Open image picker options
        ),
        TextField(
          keyboardType: TextInputType.number, // Numeric keyboard
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly, // Allow digits only
          ],
          decoration: const InputDecoration(
            labelText: 'NIK',
            suffixText: '*',
            suffixStyle: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
        const TextField(
          decoration: InputDecoration(
            labelText: 'ALAMAT SESUAI KTP',
            suffixText: '*',
            suffixStyle: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
        const TextField(
          decoration: InputDecoration(
            labelText: 'PROVINSI',
            suffixText: '*',
            suffixStyle: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
        const TextField(
          decoration: InputDecoration(
            labelText: 'KOTA/KABUPATEN',
            suffixText: '*',
            suffixStyle: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
        const TextField(
          decoration: InputDecoration(
            labelText: 'KECAMATAN',
            suffixText: '*',
            suffixStyle: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
        const TextField(
          decoration: InputDecoration(
            labelText: 'KELURAHAN',
            suffixText: '*',
            suffixStyle: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
        TextField(
          keyboardType: TextInputType.number, // Numeric keyboard
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly, // Allow digits only
          ],
          decoration: const InputDecoration(
            labelText: 'KODE POS',
            suffixText: '*',
            suffixStyle: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBiodataDiriSection() {
    return Column(
      children: [
        const TextField(
          decoration: InputDecoration(
            labelText: 'NAMA LENGKAP',
            alignLabelWithHint: true,
            suffixText: '*',
            suffixStyle: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
        TextField(
          controller: _birthDateController,
          readOnly: true,
          decoration: const InputDecoration(
            labelText: 'TANGGAL LAHIR',
            alignLabelWithHint: true,
            suffix: Icon(Icons.calendar_month),
            suffixStyle: TextStyle(
              color: Colors.red,
            ),
          ),
          onTap: () {
            _selectDate(context);
          },
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'JENIS KELAMIN',
            ),
            value: selectedGender,
            items: genderOptions.map((String gender) {
              return DropdownMenuItem<String>(
                value: gender,
                child: Text(gender),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedGender = newValue;
              });
            },
          ),
        ),
        const TextField(
          keyboardType: TextInputType.emailAddress, // Numeric keyboard
          decoration: InputDecoration(
            labelText: 'ALAMAT EMAIL',
            alignLabelWithHint: true,
            suffixText: '*',
            suffixStyle: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
        TextField(
          keyboardType: TextInputType.number, // Numeric keyboard
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly, // Allow digits only
          ],
          decoration: const InputDecoration(
            labelText: 'NO HP',
            alignLabelWithHint: true,
            suffixText: '*',
            suffixStyle: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'PENDIDIKAN',
            ),
            value: selectedPendidikan,
            items: pendidikanOptions.map((String pendidikan) {
              return DropdownMenuItem<String>(
                value: pendidikan,
                child: Text(pendidikan),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedPendidikan = newValue;
              });
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'STATUS PERNIKAHAN',
            ),
            value: selectedMaritalStatus,
            items: maritalStatusOptions.map((String marital) {
              return DropdownMenuItem<String>(
                value: marital,
                child: Text(marital),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedMaritalStatus = newValue;
              });
            },
          ),
        ),
      ],
    );
  }
}
