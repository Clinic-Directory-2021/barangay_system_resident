import 'package:flutter/material.dart';

class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) => EntryItem(
        data[index],
      ),
    );
  }
}

class Entry {
  final String title;
  final String date;
  final List<Entry> children;
  Entry(this.title, this.date, [this.children = const <Entry>[]]);
}

//Entire multi-level list displayed by this app
//* The query and data should traverse here
final List<Entry> data = <Entry>[
  Entry(
    'Requested Certificate List',
    'hahahaha',
    <Entry>[
      Entry('Certificate name', 'date requested'),
      Entry('Certificate name', 'date requested'),
    ],
  ),
];

//Create widget for row
class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);
  final Entry entry;

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) {
      return ListTile(
        leading: const Icon(
          Icons.check,
          color: Colors.green,
        ),
        title: Text(root.title),
        subtitle: Text(root.date),
      );
    }
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: Text(root.title),
      children: root.children.map<Widget>(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}
