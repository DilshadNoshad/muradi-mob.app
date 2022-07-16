import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:muradi_app/components/product_card.dart';
import 'package:muradi_app/models/Product.dart';
import "package:http/http.dart" as http;
import '../../../size_config.dart';
import 'section_title.dart';

Future<void> fetchproducts() async {
  const url = 'https://dummyjson.com/products';
  try {
    final response = await http.get(Uri.parse(url));
    final extractedData = json.decode(response.body) as Map<String, dynamic>;

    final List<Product> loadedProducts = [];
    extractedData['products'].forEach((prodData) {
      print(
        prodData['images'],
      );
      loadedProducts.add(Product(
        // id: prodId,
        // title: prodData['title'],
        // description: prodData['description'],
        // price: prodData['price'],
        // isFavorite: prodData['isFavorite'],
        // imageUrl: prodData['imageUrl'],

        id: 1,
        images: [
          prodData['thumbnail'],
        ],
        colors: [
          Color(0xFFF6625E),
          Color(0xFF836DB8),
          Color(0xFFDECB9C),
          Colors.white,
        ],
        title: prodData['title'],
        price: prodData['price'],
        description: prodData['description'],
        rating: prodData['rating'],
        isPopular: true,
        // images: prodData['images'],
        // colors: [
        //   Color(0xFFF6625E),
        //   Color(0xFF836DB8),
        //   Color(0xFFDECB9C),
        //   Colors.white,
        // ],
        // title: prodData['title'],
        // price: prodData['price'],
        // description: prodData['description'],
        // rating: prodData['rating'],
        isFavourite: false,
        // isPopular: true,
      ));
    });
    print(loadedProducts);
    demoProducts = loadedProducts;

    // notifyListeners();
  } catch (error) {
    throw (error);
  }
}

class PopularProducts extends StatefulWidget {
  PopularProducts({Key? key}) : super(key: key);

  @override
  State<PopularProducts> createState() => _PopularProductsState();
}

class _PopularProductsState extends State<PopularProducts> {
  var _showOnlyFavorites = false;
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      fetchproducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(title: "Popular Products", press: () {}),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                demoProducts.length,
                (index) {
                  if (demoProducts[index].isPopular)
                    return ProductCard(product: demoProducts[index]);

                  return SizedBox
                      .shrink(); // here by default width and height is 0
                },
              ),
              SizedBox(width: getProportionateScreenWidth(20)),
            ],
          ),
        )
      ],
    );
  }
}


// class PopularProducts extends StatelessWidget {
//   @override
 
// }
