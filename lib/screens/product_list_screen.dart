import 'package:auctify/const/constants.dart';
import 'package:auctify/models/product_model.dart';
import 'package:auctify/screens/product_detail_screen.dart';
import 'package:auctify/utils/product_list_tile.dart';
import 'package:auctify/utils/product_tile_home_screen.dart';
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
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(height: MediaQuery.of(context).size.height / 40),

            Container(
              height: 40,
              child: Padding(
                padding: const EdgeInsets.symmetric(),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextFormField(
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 10),
                            hintText: "Search Auctify",
                            hintStyle: normalText.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey),
                            prefixIcon: const Icon(
                              Icons.search_rounded,
                              color: primaryAccentColor,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: primaryAccentColor, width: 1),
                            ),
                            suffixIcon: const Icon(Icons.mic_rounded)),
                      ),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.filter_list_rounded,
                          color: primaryAccentColor,
                        ))
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            //search suggestion
            Container(
              width: double.infinity,
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Recent Searches",
                      style: normalImportant,
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Row(
                      children: [
                        SearchSuggestionItem("Clock"),
                        SearchSuggestionItem("gramphones"),
                        SearchSuggestionItem("uniques"),
                      ],
                    ),
                    // const SizedBox(
                    //   height: 8,
                    // ),
                    // Row(
                    //   children: [
                    //     SearchSuggestionItem("vintages"),
                    //     SearchSuggestionItem("Exclusives"),
                    //   ],
                    // ),
                    const SizedBox(
                      height: 24,
                    ),
                    const Text(
                      "Trending Searches",
                      style: normalImportant,
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Row(
                      children: [
                        SearchSuggestionItem("flora"),
                        SearchSuggestionItem("Tucocoo Vintage Canvas"),
                        SearchSuggestionItem("Notre"),
                      ],
                    ),
                    // const SizedBox(
                    //   height: 8,
                    // ),
                    // Row(
                    //   children: [
                    //     SearchSuggestionItem("meganta flask"),
                    //     SearchSuggestionItem("Antique metal flourish signs"),
                    //   ],
                    // ),
                    const SizedBox(
                      height: 24,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            // list of products

            FutureBuilder(
              future: getProductListFromBackend(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData && snapshot.data != false) {
                    List<ProductUploadModel> productList = snapshot.data!;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
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
                    return const Center(child: Text("No data found"));
                  }
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            )
          ]),
        ),
      ),
    );
  }
}

SearchSuggestionItem(String text) {
  return Container(
    height: 24,
    margin: const EdgeInsets.only(left: 8),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
    decoration: BoxDecoration(
      color: secondaryAccentColor,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: primaryAccentColor, // Outline color
        width: 0.5, // Outline thickness
      ),
    ),
    child: Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: smallNormal.copyWith(color: primaryAccentColor),
      textAlign: TextAlign.center,
    ),
  );
}
