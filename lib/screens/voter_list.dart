import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:elap/screens/voter_details.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VoterList extends StatefulWidget {
  final String searchTerm;

  const VoterList({super.key, required this.searchTerm });

  @override
  State<VoterList> createState() => _VoterListState();
}

class _VoterListState extends State<VoterList> {

  late final SharedPreferences prefs;
  late String userid;
  List voterResponse = [];

  @override
  void initState() {
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(5),
        child: voterResponse.isEmpty ? const Center(
          child: CircularProgressIndicator(),
        ) : ListView.separated(
            itemBuilder: (context, index) {
          return GestureDetector(
            // onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const VoterDetails(),)),
            child: Card(
              
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.only(bottom: 8),
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        color: Colors.lightBlueAccent,

                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.indigoAccent,
                                borderRadius: BorderRadius.circular(6)
                              ),
                              child: Text('${voterResponse[index]['voterSerialNo']}')),
                          const SizedBox(width: 10,),
                          Text('ভোটার নং: ${voterResponse[index]['voterNo']}'),
                        ],
                      ),
            
                    ),

                    RichText(
                      text: TextSpan(
                        style: const TextStyle(color: Colors.black),
                        children: <TextSpan>[
                          const TextSpan(text: 'নাম: ', style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: '${voterResponse[index]['voterNo']}'),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(color: Colors.black),
                        children: <TextSpan>[
                          const TextSpan(text: 'পিতা: ', style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: '${voterResponse[index]['fatherName']}'),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(color: Colors.black),
                        children: <TextSpan>[
                          const TextSpan(text: 'মাতা: ', style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: '${voterResponse[index]['motherName']}'),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(color: Colors.black),
                        children: <TextSpan>[
                          const TextSpan(text: 'ভোটকেন্দ্র: ', style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: '${voterResponse[index]['voteCenter']['centerName']}'),
                        ],
                      ),
                    ),
            
                  ],
                ),
              ),
            ),
          );
        }, separatorBuilder: (context, index) => const SizedBox(height: 5,), itemCount: voterResponse.length),
      ),
    );
  }

  Future<void> getData() async {

    prefs = await SharedPreferences.getInstance();
    // userid = prefs.getString('userId')!;
    // var userUrl = "https://server.elep.app/api/v1/agents/$userid";
    // var jsonUserResponse = await http.get(
    //     Uri.parse(userUrl),
    //     headers: {"Content-Type":"application/json"}
    // );

    // var userResponse = jsonDecode(jsonUserResponse.body);

    // print(userResponse);

    // get data by vote center
    String url;
    String? accessToken;
    if(widget.searchTerm == ""){
      var voteCenter = prefs.getString('voteCenter');
      url = "https://server.elep.app/api/v1/voters/$voteCenter";
    }else{
      accessToken = await prefs.getString('accessToken');
      url = "https://server.elep.app/api/v1/voters/for-agent?searchTerm=${widget.searchTerm}";
    }

    var voterJsonResponse = await http.get(
        Uri.parse(url),
        headers: {"Content-Type":"application/json", "Authorization" : "Bearer $accessToken"}
    );

    voterResponse = jsonDecode(voterJsonResponse.body)['data'];
    setState(() {});
    print(widget.searchTerm);
  }
}
