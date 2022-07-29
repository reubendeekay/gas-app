import 'package:flutter/material.dart';
import 'package:gas/models/provider_model.dart';
import 'package:gas/providers/gas_providers.dart';
import 'package:gas/screens/home/homepage_provider_widget.dart';
import 'package:gas/widgets/loading_effect.dart';
import 'package:provider/provider.dart';

class FrequentProvidersScreen extends StatelessWidget {
  const FrequentProvidersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Frequent Providers'),
          elevation: 0,
        ),
        body: FutureBuilder<List<ProviderModel>>(
          future: Provider.of<GasProviders>(context, listen: false)
              .getFrequentProviders(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return LoadingEffect.getSearchLoadingScreen(context);
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text('Error'),
              );
            }
            if (snapshot.data!.isEmpty) {
              return const Center(
                child: Text('No Providers yet'),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (ctx, index) {
                return HomepageProviderWidget(
                  provider: snapshot.data![index],
                  isHome: false,
                );
              },
            );
          },
        ));
  }
}
