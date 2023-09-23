import 'package:auctify/const/constants.dart';
import 'package:auctify/const/util_functions.dart';
import 'package:auctify/models/product_model.dart';
import 'package:auctify/screens/home_screen.dart';
import 'package:auctify/utils/product_list_tile.dart';
import 'package:auctify/viewmodels/control_bidding.dart';
import 'package:auctify/viewmodels/manage_portal.dart';
import 'package:auctify/viewmodels/product_list_viewmodel.dart';
import 'package:flutter/material.dart';

class ProductListActiveDeactive extends StatefulWidget {
  const ProductListActiveDeactive({super.key});

  @override
  State<ProductListActiveDeactive> createState() =>
      _ProductListActiveDeactiveState();
}

class _ProductListActiveDeactiveState extends State<ProductListActiveDeactive> {
  Future<List<ProductUploadModel>> getProductListFromBackend(
      BuildContext context) async {
    return await ProductListViewModel().getActiveProductList(context);
  }

  Future<List<ProductUploadModel>> getDeactiveProductListFromBackend(
      BuildContext context) async {
    return await ProductListViewModel().getDeactiveProductList(context);
  }

  @override
  Widget build(BuildContext context) {
    ManagePortalBackend().checkForExistingPortals();
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width / 20),
          child: Column(children: [
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
                  Text("Active")
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
                        String timeLeft = UtilFunctions()
                            .getTimeLeftOrTimePassed(productList[index].endDate,
                                productList[index].endTime);
                        return GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => HomeScreen()));
                          },
                          child: ProductListTile(
                            image: productList[index].imageList[0],
                            pname: productList[index].name,
                            price: productList[index].currentPrice.toString(),
                            time: timeLeft,
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
            ),

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
                  Text("De Active")
                ],
              ),
            ),

            // list of deactive products
            SizedBox(height: MediaQuery.of(context).size.height / 80),
            FutureBuilder(
              future: getDeactiveProductListFromBackend(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData && snapshot.data != false) {
                    List<ProductUploadModel> productList = snapshot.data!;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: productList.length,
                      itemBuilder: (context, index) {
                        String timeLeft = UtilFunctions()
                            .getTimeLeftOrTimePassed(productList[index].endDate,
                                productList[index].endTime);
                        return GestureDetector(
                          onTap: () {},
                          child: ProductListTile(
                            image: productList[index].imageList[0],
                            pname: productList[index].name,
                            price: productList[index].currentPrice.toString(),
                            time: timeLeft,
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
