import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_first_practice/common_widgets.dart';

/* StateProvider : this provider notifies about its state, thus it is mutable and We can use this for permitive data types or where data is so complex. In Simple words, use this State provider where we need minor updates on UI */
final currentTimeStateprovider = StateProvider<int>(
  (ref) => 0,
);

class MyStateProvider extends ConsumerWidget {
  const MyStateProvider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('RiverPod State Provider'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                final int time = ref.watch(currentTimeStateprovider);
                return Text(
                  time.toString(),
                  style: CommonWidgets.textStyle(),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => MyStateProvider()));
                },
                child: const Icon(
                  Icons.forward,
                ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            ref.read(currentTimeStateprovider.notifier).state++;
          },
          child: const Icon(Icons.add)),
    );
  }
}
