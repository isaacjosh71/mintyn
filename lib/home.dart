
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
  int selectedIndex = 0;
  final List<String> tabs = ['Hello', 'Stats', 'Photos', 'About'];


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
      backgroundColor: Colors.transparent,
      body: Container(
        padding: const EdgeInsets.only(left: 12, right: 12),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1E0F2F),
              Color(0xFF613659),
              Color(0xFFB06AB3),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.arrow_back, color: Colors.white),
                  Icon(Icons.grid_view, color: Colors.white),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(radius: 45, backgroundImage: NetworkImage(user.profileImage)),
                  const SizedBox(width: 8),
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.green,
                    child: Icon(Icons.chat, color: Colors.white, size: 30,),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 180,
                    height: 120,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("🌞", style: TextStyle(fontSize: 20)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Growing Place', style: TextStyle(color: Colors.black87)),
                            Text(user.place, style: const TextStyle(color: Colors.black,fontSize: 18)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 180,
                    height: 120,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("📍", style: TextStyle(fontSize: 20)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Location', style: TextStyle(color: Colors.black87)),
                            Text(user.location, style: const TextStyle(color: Colors.black, fontSize: 18)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  statCard("Years", user.years.toString(), Colors.yellow),
                  statCard("Helps", user.help.toString(), Colors.orangeAccent),
                  statCard("Pounds", user.pounds.toString(), Colors.grey),
                ],
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.greenAccent.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${user.plants} plants", style: const TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 16,),
                            Wrap(
                              spacing: 10,
                              children: user.tags
                                  .map((tag) => Chip(label: Text(tag), backgroundColor: Colors.white10, labelStyle: const TextStyle(color: Colors.black87)))
                                  .toList(),
                            ),
                          ],
                        ),
                       const Row(
                         children: [
                           CircleAvatar(
                                backgroundColor: Colors.white38,
                                child: Icon(Icons.settings, color: Colors.grey)),
                           SizedBox(width: 8,),
                           CircleAvatar(
                               backgroundColor: Colors.white38,
                               child: Icon(Icons.arrow_forward, color: Colors.grey)),
                         ],
                       ),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(tabs.length, (index) {
                  final isSelected = index == selectedIndex;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.white : Colors.black,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        tabs[index],
                        style: TextStyle(
                          color: isSelected ? Colors.black : Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget statCard(String label, String value, Color color) {
    return Container(
      width: 120,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.black87)),
          const SizedBox(height: 5),
          Text(value, style:const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget bottomButton(String label) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white10,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Text(label),
    );
  }
}