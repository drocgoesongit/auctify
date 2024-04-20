import 'package:flutter/material.dart';

class FAQsScreen extends StatefulWidget {
  @override
  _FAQsScreenState createState() => _FAQsScreenState();
}

class _FAQsScreenState extends State<FAQsScreen> {
  late List<bool> _isOpenList;

  @override
  void initState() {
    super.initState();
    // Initialize the list of booleans to track the expansion state of each panel
    _isOpenList = List.generate(3, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FAQs"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            ExpansionPanelList(
              expansionCallback: (int index, bool isExpanded) {
                // Update the state to expand or collapse the panel
                setState(() {
                  _isOpenList[index] = !isExpanded;
                });
              },
              children: <ExpansionPanel>[
                ExpansionPanel(
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      title: Text('How do I bid on items?'),
                    );
                  },
                  body: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'To bid on items, simply navigate to the item you want to bid on and tap on the "Bid Now" button. Enter your bid amount and submit.',
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  isExpanded: _isOpenList[0],
                ),
                ExpansionPanel(
                  canTapOnHeader: true,
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      title: Text('How can I view my bidding history?'),
                    );
                  },
                  body: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'You can view your bidding history by navigating to your profile and selecting the "Bidding History" option. There, you will find a list of all the items you have bid on along with their status.',
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  isExpanded: _isOpenList[1],
                ),
                ExpansionPanel(
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      title: Text('How do I pay for items I\'ve won?'),
                    );
                  },
                  body: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Once you have won an item, you will receive payment instructions via email. Follow the provided instructions to complete the payment process.',
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  isExpanded: _isOpenList[2],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
