import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:get/get.dart';
import 'package:product_list/features/app/controllers/product_list_controller.dart';
import 'package:product_list/features/app/screens/base_screen.dart';
import 'package:product_list/features/domain/entites/product_entity.dart';
import 'package:product_list/generated/l10n.dart';

class ProductListScreen extends BaseScreen<ProductListController> {
  const ProductListScreen({super.key});

  Widget _buildItemProduct({required ProductEntity product}) => Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Thumbnail
            Image.network(
              product.thumbnail ?? "",
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              loadingBuilder: (ct, w, e) {
                if (e == null) return w;

                return Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.purple.withOpacity(0.2),
                  ),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Colors.purple,
                    ),
                  ),
                );
              },
              errorBuilder: (ct, o, s) => Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.purple.withOpacity(0.2),
                ),
                child: const Center(
                  child: Icon(
                    Icons.error_outline,
                    size: 30,
                    color: Colors.purple,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          product.title ?? '--',
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async => await controller.onToggleProduct(
                          product: product,
                        ),
                        child: Icon(
                          product.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_outline_sharp,
                          size: 22,
                          color: product.isFavorite ? Colors.red : Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${product.price ?? 0}\$',
                    style: const TextStyle(
                      color: Colors.purple,
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 5),
                  RatingStars(
                    value: product.rating ?? 0,
                    starCount: 5,
                    starSize: 16,
                    starColor: Colors.yellow,
                    starOffColor: Colors.grey,
                    valueLabelVisibility: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        centerTitle: true,
        title: Text(
          S.current.product.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              if (controller.searchController.text.isNotEmpty) {
                await controller.getListProductSearch(
                  search: controller.searchController.text,
                );
                return;
              }

              await controller.onRefreshDataProduct();
            },
            icon: const Icon(
              Icons.refresh,
              size: 22,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 50,
              child: TextFormField(
                controller: controller.searchController,
                onChanged: (value) async {
                  if (value.isNotEmpty) {
                    await controller.getListProductSearch(search: value);
                    return;
                  }

                  await controller.onRefreshDataProduct();
                },
                decoration: InputDecoration(
                  hintText: S.current.enterNameProduct,
                  contentPadding: const EdgeInsets.only(
                    top: 5,
                    left: 10,
                    right: 10,
                  ),
                  suffixIcon: const Icon(
                    CupertinoIcons.search,
                    color: Colors.black,
                    size: 22,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(color: Colors.purple),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: Obx(
                () => controller.productList.isNotEmpty
                    ? NotificationListener(
                        onNotification: (notification) {
                          if (notification is ScrollEndNotification) {
                            if (notification.metrics.atEdge) {
                              bool isTop = notification.metrics.pixels == 0;
                              bool isCheckLoadMore = !isTop &&
                                  controller.productList.length <
                                      controller.totalItems.value;

                              if (isCheckLoadMore) {
                                if (controller.searchController.text.isEmpty) {
                                  controller.loadMoreProduct();
                                }
                              }
                            }
                          }
                          return false;
                        },
                        child: RefreshIndicator(
                          onRefresh: () async {
                            if (controller.searchController.text.isNotEmpty) {
                              await controller.getListProductSearch(
                                search: controller.searchController.text,
                              );
                              return;
                            }

                            await controller.onRefreshDataProduct();
                          },
                          child: ListView.builder(
                            controller: controller.scrollController,
                            padding: EdgeInsets.zero,
                            itemCount: controller.productList.length,
                            itemBuilder: (ct, i) => _buildItemProduct(
                              product: controller.productList[i],
                            ),
                          ),
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error,
                            size: 30,
                            color: Colors.purple,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            S.current.noProduct,
                            style: const TextStyle(
                              color: Colors.purple,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
            Obx(() => controller.isLoadMore.value
                ? Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: const Center(
                      child: CircularProgressIndicator(color: Colors.purple),
                    ),
                  )
                : const SizedBox()),
          ],
        ),
      ),
    );
  }
}
