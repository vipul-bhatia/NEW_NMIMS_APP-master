

class ClassInfo {
  final String name;
  final int id;
  final String location;

  ClassInfo({required this.name, required this.id, required this.location});
}

List<ClassInfo> classes = [
  ClassInfo(name: 'Math', id: 1, location: 'A Place'),
  ClassInfo(name: 'Physics', id: 2, location: 'B Place'),
  ClassInfo(name: 'Chemistry', id: 3, location: 'C Place'),
  // ... more classes
];

