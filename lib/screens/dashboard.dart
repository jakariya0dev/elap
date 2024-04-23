import 'package:elap/screens/voter_list.dart';
import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {

  TextEditingController searchKeywordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        height: double.maxFinite,
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: searchKeywordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'ভোটার নং/নাম/জন্মতারিখ/পিতার নাম/মাতার নাম/ঠিকানা'
              ),
            ),
            ElevatedButton(onPressed: () =>
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => VoterList(searchTerm: searchKeywordController.text,))), child: const Text('অনুসন্ধান করুন')),
            ElevatedButton(onPressed: () =>
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const VoterList(searchTerm: '',))),
                child: const Text('সকল ভোটার')),

          ],
        ),
      ),
    );
  }
}
