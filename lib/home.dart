
import 'package:flutter/material.dart';
import 'package:mintyn/repo.dart';
import 'model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<User> users = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadUsers();
  }

  Future<void> loadUsers() async {
    final repo = UserRepository();
    final data = await repo.fetchUser();
    setState(() {
      users = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) return const Center(child: CircularProgressIndicator());
    final user = users[0];
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.arrow_back, color: Colors.white),
                  Text("Profile", style: TextStyle(color: Colors.white, fontSize: 20)),
                  Icon(Icons.grid_view, color: Colors.white),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(radius: 45, backgroundImage: NetworkImage(user.profileImage)),
                  const SizedBox(width: 20),
                  const CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Icon(Icons.question_mark, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 150,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("🌞", style: TextStyle(fontSize: 20)),
                        const SizedBox(height: 8),
                        const Text('Growing Place', style: TextStyle(color: Colors.white54)),
                        Text(user.place, style: const TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  Container(
                    width: 150,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("📍", style: TextStyle(fontSize: 20)),
                        const SizedBox(height: 8),
                        Text(user.place, style: const TextStyle(color: Colors.white54)),
                        Text(user.location, style: const TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  statCard("Years", user.years.toString()),
                  statCard("Helps", user.help.toString()),
                  statCard("Pounds", user.pounds.toString()),
                ],
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("${user.plants} plants", style: const TextStyle(color: Colors.white)),
              ),
              Wrap(
                spacing: 10,
                children: user.tags
                    .map((tag) => Chip(label: Text(tag), backgroundColor: Colors.white10, labelStyle: TextStyle(color: Colors.white)))
                    .toList(),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  bottomButton("Hello"),
                  bottomButton("Stats"),
                  bottomButton("Photos"),
                  bottomButton("About"),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget statCard(String label, String value) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.orange.shade700,
      ),
      child: Column(
        children: [
          Text(label, style: const TextStyle(color: Colors.white70)),
          const SizedBox(height: 5),
          Text(value, style:const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget bottomButton(String label) {
    return ElevatedButton(
      onPressed: () {},
      child: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white10,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}