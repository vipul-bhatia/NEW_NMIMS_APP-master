import 'package:flutter/material.dart';

//data
import './classData.dart';

class searchClass extends StatefulWidget {
  const searchClass({super.key});

  @override
  State<searchClass> createState() => _searchClassState();
}

class _searchClassState extends State<searchClass> {
  List<ClassInfo> searchResults = [];
  TextEditingController _searchController = TextEditingController();
  ClassInfo? selectedClass;

  void _searchClasses(String query) {
    List<ClassInfo> results = classes.where((classInfo) {
      return classInfo.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      searchResults = results;
    });
  }

  void _selectClass(ClassInfo classInfo) {
    setState(() {
      selectedClass = classInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Classes'),
      ),
      body: Column(
      children: [
        TextField(
          controller: _searchController,
          onChanged: _searchClasses,
          decoration: InputDecoration(
            hintText: 'Search for a class...',
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: searchResults.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(searchResults[index].name),
                subtitle: Text(searchResults[index].location),
                onTap: () {
                  _selectClass(searchResults[index]);
                },
              );
            },
          ),
        ),
        if (selectedClass != null)
          Text('Location: ${selectedClass!.location}'),
      ],
      )
    );

  }
}