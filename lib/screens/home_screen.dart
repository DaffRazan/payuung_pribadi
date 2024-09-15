import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:payuung_pribadi/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class Product {
  final String iconPath;
  final String title;

  Product({required this.iconPath, required this.title});
}

List<Product> _productKeuanganList = [
  Product(iconPath: 'assets/ic_urun.svg', title: 'Urun'),
  Product(iconPath: 'assets/ic_porsihaji.svg', title: 'Pembiayaan Porsi Haji'),
  Product(
      iconPath: 'assets/ic_financialcheckup.svg', title: 'Financial Check Up'),
  Product(iconPath: 'assets/ic_car.svg', title: 'Asuransi Mobil'),
  Product(iconPath: 'assets/ic_property.svg', title: 'Asuransi Properti'),
];

List<Product> _kategoriPilihanList = [
  Product(iconPath: 'assets/ic_hobi.svg', title: 'Hobi'),
  Product(iconPath: 'assets/ic_officefashion.svg', title: 'Merchandise'),
  Product(iconPath: 'assets/ic_healthylife.svg', title: 'Gaya Hidup Sehat'),
  Product(
      iconPath: 'assets/ic_counsellingspiritual.svg',
      title: 'Konseling & Rohani'),
  Product(iconPath: 'assets/ic_selfdevelopment.svg', title: 'Self Development'),
  Product(
      iconPath: 'assets/ic_personalfinance.svg', title: 'Perencanaan Keuangan'),
  Product(iconPath: 'assets/ic_mask.svg', title: 'Konsultasi Medis'),
  Product(iconPath: 'assets/ic_more.svg', title: 'Lihat Semua'),
];

class Wellness {
  final String imagePath;
  final String caption;
  final String voucherPrice;

  Wellness(
      {required this.imagePath,
      required this.caption,
      required this.voucherPrice});
}

List<Wellness> _wellnessList = [
  Wellness(
    imagePath: 'assets/img_indomaret.png',
    caption: 'Voucher Digital Indomaret Rp 25.000',
    voucherPrice: 'Rp 25.000',
  ),
  Wellness(
    imagePath: 'assets/img_hm.png',
    caption: 'Voucher Digital H&M Rp 100.000',
    voucherPrice: 'Rp 100.000',
  ),
  Wellness(
    imagePath: 'assets/img_alfamart.png',
    caption: 'Voucher Digital Alfamart Rp 25.000',
    voucherPrice: 'Rp 25.000',
  ),
  Wellness(
    imagePath: 'assets/img_excelso.png',
    caption: 'Voucher Digital Excelso Rp 50.000',
    voucherPrice: 'Rp 50.000',
  ),
  Wellness(
    imagePath: 'assets/img_bakmigm.png',
    caption: 'Voucher Digital Bakmi GM Rp 100.000',
    voucherPrice: 'Rp 100.000',
  ),
  Wellness(
    imagePath: 'assets/img_haagendazs.png',
    caption: 'Voucher Digital Haagen Dazs Rp 100.000',
    voucherPrice: 'Rp 100.000',
  ),
];

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.amber,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/ic_beranda.svg'),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/ic_search.svg'),
            label: 'Cari',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/ic_cart.svg'),
            label: 'Keranjang',
          ),
        ],
      ),
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: false,
            expandedHeight: 100.0,
            flexibleSpace: _buildHeaderSticky(),
          ),
          _buildPayuungTabBar(),
          _buildProductKeuanganSection(),
          _buildKategoriPilihanSection(),
          _buildExploreWellnessSection(),
        ],
      ),
    );
  }

  Widget _buildProductKeuanganSection() {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Text(
              'Produk Keuangan',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(
            height: 200,
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    SvgPicture.asset(
                      _productKeuanganList[index].iconPath,
                      height: 30,
                      width: 30,
                    ),
                    Text(
                      _productKeuanganList[index].title,
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              },
              padding: const EdgeInsets.all(8.0),
              itemCount: _productKeuanganList.length,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildKategoriPilihanSection() {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Text(
              'Kategori Pilihan',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(
            height: 200,
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    SvgPicture.asset(
                      _kategoriPilihanList[index].iconPath,
                      height: 30,
                      width: 30,
                    ),
                    Text(
                      _kategoriPilihanList[index].title,
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              },
              padding: const EdgeInsets.all(8.0),
              itemCount: _kategoriPilihanList.length,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildExploreWellnessSection() {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Text(
              'Explore Wellness',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(
            height: 600,
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 3 / 2.8,
                crossAxisCount: 2,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Image.asset(
                      _wellnessList[index].imagePath,
                      height: 100,
                      width: 100,
                    ),
                    Text(
                      _wellnessList[index].caption,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      _wellnessList[index].voucherPrice,
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              },
              padding: const EdgeInsets.all(8.0),
              itemCount: _wellnessList.length,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPayuungTabBar() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Text(
                    'Payuung Pribadi',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                child: Text(
                  'Payuung Karyawan',
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSticky() {
    return Container(
      color: Colors.amber,
      padding: const EdgeInsets.only(
        top: 28,
        right: 16,
        left: 16,
        bottom: 30,
      ),
      child: Row(
        children: [
          Text(
            'Selamat Sore\nDaffa',
            style: TextStyle(color: Colors.white),
          ),
          Spacer(),
          const Icon(
            Icons.notifications_active_outlined,
            color: Colors.white,
          ),
          SizedBox(
            width: 8,
          ),
          InkWell(
            onTap: () {
              print('ketekan');
              Get.to(const ProfileScreen());
            },
            child: CircleAvatar(
              backgroundColor: Colors.grey,
              child: Text(
                'D',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
