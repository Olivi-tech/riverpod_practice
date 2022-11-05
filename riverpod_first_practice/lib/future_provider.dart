import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_first_practice/common_widgets.dart';
import 'package:riverpod_first_practice/stream_provider.dart';

/* FutureProvider: this provide works same as simple provider but works ascyronusly and updates UI when data is available 
note: autoDispose is used to dispose future or stream listeners when activity is closed. when autoDispose is used every time a new call is made to API and updated data is shown. Remove autodispose to cache data */
final todayWeather = FutureProvider.autoDispose<String>(
  (ref) => getWeather(),
);
Future<String> getWeather() async {
  return await Future.delayed(
    const Duration(seconds: 3),
    () => '34 °C',
  );
}

/* Family Provider: This is used to create unique provider to get inputs from user and then work according to input
=> Inputs: first input is as usual input of provider and 2nd input is data type of user value 
=> we can user .family(family provider with all providers to get values)
 */
final bwpWeatherFamilyProvider =
    FutureProvider.autoDispose.family<String, String>(
  (ref, arg) => getWeatherForFamilyProvider(cityName: arg),
);
Future<String> getWeatherForFamilyProvider({required String cityName}) async {
  return await Future.delayed(
    const Duration(seconds: 2),
    () => '$cityName : 30 °C',
  );
}

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
          Text(
            'Family Provider Value :',
            style:
                CommonWidgets.textStyle(color: Colors.deepOrange, fontSize: 25),
          ),
          Consumer(
            builder: (context, ref, child) {
              return ref.watch(bwpWeatherFamilyProvider('Bahawalppur')).when(
                  data: (data) {
                return Center(
                  child: Text(
                    data.toString(),
                    style: CommonWidgets.textStyle(),
                  ),
                );
              }, error: (stackTrace, error) {
                return Center(
                  child: Text(error.toString()),
                );
              }, loading: () {
                return const Center(child: CircularProgressIndicator());
              });
            },
          ),
          const SizedBox(height: 30),
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
