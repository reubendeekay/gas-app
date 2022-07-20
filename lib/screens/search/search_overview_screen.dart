import 'package:flutter/material.dart';
import 'package:gas/models/provider_model.dart';
import 'package:gas/providers/gas_providers.dart';
import 'package:gas/screens/home/homepage_provider_widget.dart';
import 'package:gas/widgets/loading_effect.dart';
import 'package:gas/widgets/my_text_field.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SearchOverviewScreen extends StatefulWidget {
  const SearchOverviewScreen({Key? key}) : super(key: key);

  @override
  State<SearchOverviewScreen> createState() => _SearchOverviewScreenState();
}

class _SearchOverviewScreenState extends State<SearchOverviewScreen> {
  String? searchTerm;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 2),
            child: MyTextField(
              hintText: 'Search',
              textInputAction: TextInputAction.search,
              onChanged: (val) {
                setState(() {
                  searchTerm = val;
                  if (val.isEmpty || searchTerm!.isEmpty) {
                    searchTerm == null;
                  }
                });
              },
              prefixIcon: Iconsax.search_favorite,
            ),
          ),
          if (searchTerm == null)
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/searching.json'),
                  const Text('Search for a provider or gas product'),
                ],
              ),
            ),
          if (searchTerm != null)
            FutureBuilder<List<ProviderModel>>(
              future: Provider.of<GasProviders>(context, listen: false)
                  .searchProviders(searchTerm!),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        LoadingEffect.getSearchLoadingScreen(context),
                      ],
                    ),
                  );
                }

                if (!snapshot.hasData) {
                  return const Center(
                    child: Text('No results'),
                  );
                }

                return Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: List.generate(
                      snapshot.data!.length,
                      (i) =>
                          HomepageProviderWidget(provider: snapshot.data![i]),
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
