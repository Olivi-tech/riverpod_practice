import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_first_practice/common_widgets.dart';
import 'package:riverpod_first_practice/stateNotifierProvider/timeStateNotifier.dart';
import 'package:intl/intl.dart';

/* Stream Provider: This is same like Future Provider. We use stream where events are to be triggered very few seconds
=> use in firebase, websockets
 */

class StateNotifierUI extends ConsumerWidget {
  const StateNotifierUI({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('////////////Calling Build Context/////////');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('StateNotifier Provider'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'StateNotifierProvider',
              style: CommonWidgets.textStyle(),
            ),
            const SizedBox(
              height: 30,
            ),
            Consumer(builder: (context, ref, child) {
              print('////////////consumer Build Context/////////');
              final timeNow = ref.watch(timeProvider);
              final formattedTime = DateFormat.Hms().format(timeNow);
              return Text(
                formattedTime.toString(),
                style: CommonWidgets.textStyle(),
              );
            }),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const MyStreamProvider()));
                },
                child: const Icon(Icons.forward))
          ],
        ),
      ),
    );
  }
}
