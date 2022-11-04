import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_first_practice/common_widgets.dart';

import 'stateNotifierProvider/stateNotifierUi.dart';

/* Stream Provider: This is same like Future Provider. We use stream where events are to be triggered very few seconds
=> use in firebase, websockets
 */
final streamValue = StreamProvider.autoDispose<int>((ref) {
  return Stream.periodic(
    const Duration(seconds: 2),
    (x) => x,
  );
});

class MyStreamProvider extends ConsumerWidget {
  const MyStreamProvider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('////////////Calling Build Context/////////');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Stream Provider'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Getting Values From Stream',
            style: CommonWidgets.textStyle(),
          ),
          const SizedBox(
            height: 30,
          ),
          Consumer(
            builder: (context, ref, child) {
              print('////////////consumer Build Context/////////');
              return ref.watch(streamValue).when(data: (data) {
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
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const StateNotifierUI()));
              },
              child: const Icon(Icons.forward))
        ],
      ),
    );
  }
}
