import 'package:flutter/material.dart';
import '/FetchBanners.dart';
import 'package:dealsdray/FetchCategory.dart';
import 'package:dealsdray/FetchProducts.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;
  late Future<List<String>> bannerImagesFuture;
   Future<List<Map<String, String>>>? futureCategories;
  Future<List<Map<String, String>>>? futureProducts;


  @override
  void initState() {
    super.initState();
    bannerImagesFuture = FetchBanners().fetchBannerImages();
    futureCategories = FetchCategory().fetchCategory();
    futureProducts=FetchProducts().fetchProducts();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Theme(
        data: ThemeData(
          canvasColor: Colors.white,
        ),
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.white,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: const Color.fromRGBO(194, 52, 62, 1),
          unselectedItemColor: Colors.black54,
          selectedLabelStyle: const TextStyle(color: Colors.black),
          unselectedLabelStyle:  TextStyle(color: Colors.black),
          items: [
            BottomNavigationBarItem(
              icon: _selectedIndex == 0
                  ? ColorFiltered(
                colorFilter: ColorFilter.mode(
                    const Color.fromRGBO(194, 52, 62, 1), BlendMode.srcIn),
                child: Image.asset('assets/home.png', height: 20),
              )
                  : Image.asset('assets/home.png', height: 20),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: _selectedIndex == 1
                  ? ColorFiltered(
                colorFilter: ColorFilter.mode(
                    const Color.fromRGBO(194, 52, 62, 1), BlendMode.srcIn),
                child: Image.asset('assets/menu.png', height: 24),
              )
                  : Image.asset('assets/menu.png', height: 24),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: _selectedIndex == 2
                  ? ColorFiltered(
                colorFilter: ColorFilter.mode(
                    const Color.fromRGBO(194, 52, 62, 1), BlendMode.srcIn),
                child: Image.asset('assets/discount.png', height: 30),
              )
                  : Image.asset('assets/discount.png', height: 30),
              label: 'Deals',
            ),
            BottomNavigationBarItem(
              icon: _selectedIndex == 3
                  ? ColorFiltered(
                colorFilter: ColorFilter.mode(
                    const Color.fromRGBO(194, 52, 62, 1), BlendMode.srcIn),
                child: Image.asset('assets/trolley.png', height: 25),
              )
                  : Image.asset('assets/trolley.png', height: 25),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: _selectedIndex == 4
                  ? ColorFiltered(
                colorFilter: ColorFilter.mode(
                    const Color.fromRGBO(194, 52, 62, 1), BlendMode.srcIn),
                child: Image.asset('assets/User.png', height: 20),
              )
                  : Image.asset('assets/User.png', height: 20),
              label: 'Profile',
            ),
          ],
        ),
      ),
      appBar: AppBar(
        toolbarHeight: 90,
        leading: const Padding(
          padding: EdgeInsets.only(left: 16),
          child: Icon(Icons.menu, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 6,
        shadowColor: Colors.black54,
        surfaceTintColor: Colors.white,
        title: Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search here',
              hintStyle: TextStyle(color: Colors.grey[600]),
              border: InputBorder.none,
              suffixIcon: const Icon(Icons.search_outlined, color: Colors.grey),
              prefixIcon: Container(
                height: 10,
                width: 10,
                padding: const EdgeInsets.only(left: 10, right: 5),
                child: Image.asset('assets/Searchlogo.png', fit: BoxFit.fitWidth),
              ),
              contentPadding: const EdgeInsets.only(left: 20, top: 12),
            ),
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.notifications_none_outlined, color: Colors.black),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<List<String>>(
              future: bannerImagesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  List<String> banners = snapshot.data!;
                  return Container(
                    padding: const EdgeInsets.only(top: 30, bottom: 30),
                    width: double.infinity,
                    height: 250,
                    child: PageView.builder(
                      itemCount: banners.length,
                      controller: PageController(viewportFraction: 0.7),
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              banners[index],
                              fit: BoxFit.fill,
                              width: 120,
                              height: 120,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey.shade300,
                                  width: 150,
                                  height: 150,
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Center(child: Text('No banners available'));
                }
              },
            ),
            Container(
              height: 180,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  Text("KYC Pending",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                  SizedBox(height: 5,),
                  Text("You need to provide the required", style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 14),),
                  SizedBox(height: 5,),
                  Text("documents for your account activation.",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 14),),
                  SizedBox(height: 30,),
                  TextButton(onPressed: (){}, child: Text("Click Here",style:TextStyle(color: Colors.white,fontSize: 20,decoration: TextDecoration.underline,decorationColor: Colors.white),),
                  )
                ],
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [
                    Color.fromRGBO(133, 139, 242, 1),
                    Color.fromRGBO(84, 88, 204, 1),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
            ),
            const SizedBox(height: 20),
            FutureBuilder<List<Map<String, String>>>(
              future: futureCategories,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No categories found.'));
                }

                return SizedBox(
                  height: 115,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Color circleColor;
                      switch (index % 4) {
                        case 0:
                          circleColor = const Color.fromRGBO(100, 106, 217, 1);
                          break;
                        case 1:
                          circleColor = const Color.fromRGBO(40, 199, 133, 1);
                          break;
                        case 2:
                          circleColor = const Color.fromRGBO(252, 88, 110, 1);
                          break;
                        case 3:
                          circleColor = const Color.fromRGBO(240, 153, 72, 1);
                          break;
                        default:
                          circleColor = Colors.grey[300]!;
                          break;
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 35,
                              backgroundColor: Colors.transparent,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: RadialGradient(
                                    colors: [
                                      circleColor.withOpacity(0.6),
                                      circleColor,
                                    ],
                                    radius: 1.0,
                                    center: Alignment.topLeft,
                                  ),
                                ),
                                child: ClipOval(
                                  child: Image.network(
                                    snapshot.data![index]['icon']!,
                                    fit: BoxFit.cover,
                                    width: 70,
                                    height: 70,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(snapshot.data![index]['label']!),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 400,
              margin: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(98, 176, 204, 1),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Text(
                          "EXCLUSIVE FOR YOU",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.arrow_forward, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 300,
                    child: FutureBuilder<List<Map<String, String>>>(
                      future: futureProducts,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return Center(child: Text('No products found.'));
                        }

                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final product = snapshot.data![index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Container(
                                width: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Image.network(
                                            product['icon']!,
                                            fit: BoxFit.cover,
                                            width: 150,
                                            height: 150,
                                            errorBuilder: (context, error, stackTrace) {
                                              return Container(
                                                color: Colors.grey.shade300,
                                                width: 150,
                                                height: 150,
                                                child: const Center(child: Text('Image not available')),
                                              );
                                            },
                                          ),
                                        ),
                                        Positioned(
                                          top: 8,
                                          right: 8,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: const Color.fromRGBO(86, 158, 9, 1),
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                            child: Text(
                                              product['offer']!,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      product['label']!,
                                      style: const TextStyle(color: Colors.black, fontSize: 16),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      product['subLabel']!,
                                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        width: 120,
        height: 48,
        child: FloatingActionButton.extended(
          onPressed: () {},
          backgroundColor: const Color.fromRGBO(245, 29, 44, 1),
          label: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/chat.png',
                height: 20,
                color: Colors.white,
              ),
              const SizedBox(width: 8),
              const Text(
                'Chat',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
