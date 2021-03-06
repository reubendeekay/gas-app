import 'package:flutter/material.dart';
import 'package:gas/constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:gas/helpers/cached_image.dart';
import 'package:gas/helpers/ratings_stars.dart';
import 'package:gas/models/provider_model.dart';
import 'package:gas/screens/provider_details/product_category_widget.dart';
import 'package:gas/screens/provider_details/product_select_dialog.dart';
import 'package:gas/screens/provider_details/product_widget.dart';

import 'package:palette_generator/palette_generator.dart';

class ProviderDetailsScreen extends StatefulWidget {
  const ProviderDetailsScreen({Key? key, required this.provider})
      : super(key: key);

  final ProviderModel provider;

  @override
  State<ProviderDetailsScreen> createState() => _ProviderDetailsScreenState();
}

class _ProviderDetailsScreenState extends State<ProviderDetailsScreen> {
// Calculate dominant color from ImageProvider
  Future<Color> getImagePalette(ImageProvider imageProvider) async {
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(imageProvider);
    return paletteGenerator.dominantColor!.color;
  }

  Color? majorColor;
  String categoryDisplay = 'All';

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      majorColor = await getImagePalette(NetworkImage(widget.provider.logo!));
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: size.height * .3,
                  floating: false,
                  pinned: true,
                  backgroundColor: majorColor ?? kIconColor,
                  iconTheme: const IconThemeData(color: Colors.white),
                  flexibleSpace: FlexibleSpaceBar(
                    expandedTitleScale: 1.1,
                    title: Text(widget.provider.name!,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16)),
                    background: CarouselSlider(
                      options: CarouselOptions(
                          autoPlayAnimationDuration: const Duration(seconds: 2),
                          autoPlayInterval: const Duration(seconds: 10),
                          height: size.height * 0.5,
                          autoPlay: true,
                          viewportFraction: 1),
                      items: List.generate(
                          widget.provider.images!.length,
                          (index) => Builder(
                                builder: (BuildContext context) {
                                  return cachedImage(
                                    widget.provider.images![index],
                                    fit: BoxFit.cover,
                                  );
                                },
                              )),
                    ),
                  ),
                ),
              ];
            },
            body: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.provider.name!,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Ratings(
                          rating: (widget.provider.ratings! /
                                  widget.provider.ratingCount!)
                              .toDouble()),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        widget.provider.address!,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                const SizedBox(
                  height: 15,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text('Choose your Fuel Type',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                ),
                const SizedBox(
                  height: 10,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          categoryDisplay = 'All';
                        });
                      },
                      child: ProductCategoryWidget(
                        category: 'All',
                        color: categoryDisplay == 'All' ? majorColor : null,
                      ),
                    ),
                    ...widget.provider.categories!
                        .map((e) => InkWell(
                              onTap: () {
                                setState(() {
                                  categoryDisplay = e;
                                });
                              },
                              child: ProductCategoryWidget(
                                category: e,
                                color: categoryDisplay == e ? majorColor : null,
                              ),
                            ))
                        .toList(),
                  ]),
                ),
                const SizedBox(
                  height: 10,
                ),
                ...List.generate(
                    categoryDisplay == 'All'
                        ? widget.provider.products!.length
                        : widget.provider.products!
                            .where((e) => e.category == categoryDisplay)
                            .toList()
                            .length,
                    (index) => InkWell(
                          onTap: () {
                            if (widget.provider.products![index].quantity > 0) {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (ctx) => ProductSelectDialog(
                                        product: categoryDisplay == 'All'
                                            ? widget.provider.products![index]
                                            : widget.provider.products!
                                                .where((e) =>
                                                    e.category ==
                                                    categoryDisplay)
                                                .toList()[index],
                                        provider: widget.provider,
                                      ));
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text(
                                  'Product is out of stock',
                                ),
                                backgroundColor: kIconColor,
                              ));
                            }
                          },
                          child: ProductWidget(
                            product: categoryDisplay == 'All'
                                ? widget.provider.products![index]
                                : widget.provider.products!
                                    .where((e) => e.category == categoryDisplay)
                                    .toList()[index],
                          ),
                        )),
              ],
            )));
  }
}
