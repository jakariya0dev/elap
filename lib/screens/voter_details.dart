import 'package:flutter/material.dart';

class VoterDetails extends StatefulWidget {
  const VoterDetails({super.key});

  @override
  State<VoterDetails> createState() => _VoterDetailsState();
}

class _VoterDetailsState extends State<VoterDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(24),
        width: double.maxFinite,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://images.pexels.com/photos/91227/pexels-photo-91227.jpeg?auto=compress&cs=tinysrgb&w=720&h=350&dpr=1'),
            ),
            const SizedBox(height: 15),
            const Chip(
              shape: StadiumBorder(),
              label: Text('ভোটার সিরিয়াল নং- ০০০৫'),
            ),
            const SizedBox(height: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: const TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(text: 'নাম: ', style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: 'জব্বার মিয়া'),
                    ],
                  ),
                ),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(text: 'ভোটার নং: ', style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: '০৬০৪৮২৮৮৭০০৬'),
                    ],
                  ),
                ),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(text: 'পিতা: ', style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: 'আব্দুল আজিজ'),
                    ],
                  ),
                ),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(text: 'মাতা: ', style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: 'জাহেদা বেগম'),
                    ],
                  ),
                ),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(text: 'জন্ম তারিখ: ', style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: '০৫/০২/১৯৮৮'),
                    ],
                  ),
                ),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(text: 'পেশা: ', style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: 'ছাত্র/ছাত্রী'),
                    ],
                  ),
                ),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(text: 'ঠিকানা: ', style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: 'কলস গ্রাম, বরিশাল সদর, বরিশাল'),
                    ],
                  ),
                ),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(text: 'ভোটকেন্দ্র: ', style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: 'বদরগঞ্জ সরকারি কলেজ'),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

