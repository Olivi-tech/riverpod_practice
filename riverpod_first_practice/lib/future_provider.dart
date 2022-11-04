import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_first_practice/common_widgets.dart';
import 'package:riverpod_first_practice/stream_provider.dart';

/* FutureProvider: this provide works same as simple provider but works ascyronusly and updates UI when data is available 
note: autoDispose is used to dispose future or stream listeners when activity is closed. when autoDispose is used every time a new call is made to API and updated data is shown. Remove autodispose to cache data */
final todayWeather = FutureProvider.autoDispose<String>((ref) async {
  return await Future.delayed(
    const Duration(seconds: 3),
    () => '33*C',
  );
});

class MyFutureProvider extends ConsumerWidget {
  const MyFutureProvider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('////////////Calling Build Context/////////');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Future Provider'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Today\'s Weather',
            style: CommonWidgets.textStyle(),
          ),
          const SizedBox(
            height: 30,
          ),
          Consumer(
            builder: (context, ref, child) {
              print('////////////consumer Build Context/////////');
              return ref.watch(todayWeather).when(data: (data) {
                return Center(
                  child: Text(
                    data.toString(),
                    style: CommonWidgets.textStyle(),
                  ),
                );
              }, error: (StackTrace, error) {
                return Center(
                  child: Text(error.toString()),
                );
              }, loading: () {
                return const Center(child: CircularProgressIndicator());
              });
            },
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyStreamProvider()));
              },
              child: const Icon(Icons.forward))
        ],
      ),
    );
  }
}
