import 'package:auctify/const/constants.dart';
import 'package:auctify/models/product_model.dart';
import 'package:auctify/screens/product_detail_screen.dart';
import 'package:auctify/utils/product_list_tile.dart';
import 'package:auctify/viewmodels/product_list_viewmodel.dart';
import 'package:flutter/material.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  // variables and all
  @override
  void initState() {
    super.initState();
  }

  Future<List<ProductUploadModel>> getProductListFromBackend(
      BuildContext context) async {
    return await ProductListViewModel().getProductList(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width / 20),
          child: Column(children: [
            SizedBox(height: MediaQuery.of(context).size.height / 40),
            // search bar container
            Container(
              // i want container with 12 radius border on all sides'
              // width: 350,
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: secondaryAccentColor,
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(12),
              ),

              child: Row(children: [
                const Icon(
                  Icons.search_outlined,
                ),
                const SizedBox(
                  width: 12,
                ),
                Flexible(
                    child: TextFormField(
                  decoration: InputDecoration(
                      hintText: "Search", border: InputBorder.none),
                )),
              ]),
            ),

            // filter part
            SizedBox(height: MediaQuery.of(context).size.height / 40),
            GestureDetector(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.filter_list_rounded,
                    color: primaryAccentColor,
                  ),
                  SizedBox(width: MediaQuery.of(context).size.height / 60),
                  Text("Filter")
                ],
              ),
            ),

            // list of products
            SizedBox(height: MediaQuery.of(context).size.height / 80),
            FutureBuilder(
              future: getProductListFromBackend(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData && snapshot.data != false) {
                    List<ProductUploadModel> productList = snapshot.data!;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: productList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductDetail(
                                          product: productList[index],
                                        )));
                          },
                          child: ProductListTile(
                            image: productList[index].imageList[0],
                            pname: productList[index].name,
                            price: productList[index].currentPrice.toString(),
                            time: productList[index].endTime.toString(),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(child: Text("No data found"));
                  }
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            )
          ]),
        ),
      ),
    );
  }
}
