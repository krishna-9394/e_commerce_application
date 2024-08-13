import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_application/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_application/common/widgets/products/sortable/sortable_products.dart';
import 'package:e_commerce_application/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:e_commerce_application/features/shop/controllers/all_product_controller.dart';
import 'package:e_commerce_application/features/shop/models/products/product_model.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:e_commerce_application/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllProducts extends StatelessWidget {
  final String title;
  final Query? query;
  final Future<List<ProductModel>>? futureMethod;
  const AllProducts({
    super.key,
    required this.title,
    this.query,
    this.futureMethod,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductController());
    return Scaffold(
      appBar: const TAppBar(
        showBackArrow: true,
        title: Text('Popular Products'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: FutureBuilder(
            future: futureMethod ?? controller.fetchProductByQuery(query),
            builder: (context, snapshot) {
              const loader = TVerticalProductShimmer(itemCount: 8);

              final widget = TCloudHelperFunctions.checkMultiRecordState(
                  snapshot: snapshot, loader: loader);

              if (widget != null) return widget;

              final products = snapshot.data!;
              return TSortableProducts(products: products);
            },
          ),
        ),
      ),
    );
  }
}
