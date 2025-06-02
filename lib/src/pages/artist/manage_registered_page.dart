import 'package:flutter/material.dart';
import '../searchpage.dart';
import 'artist_performance_detail_page.dart';

class ManageRegisteredPage extends StatefulWidget {
  const ManageRegisteredPage({super.key});
  @override
  State<ManageRegisteredPage> createState() => _ManageRegisteredPageState();
}

class _ManageRegisteredPageState extends State<ManageRegisteredPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 16,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Image.asset(
                'assets/images/navi logo.png',
                width: 110,
                height: 28,
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Searchpage()),
                  );
                },
                icon: const Icon(
                  Icons.search,
                  size: 24,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '등록된 공연 관리',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildSectionTitle('진행 중인 공연'),
                  _buildPosterGrid(3),
                  _buildDivider(),
                  _buildSectionTitle('만료된 공연'),
                  _buildPosterGrid(7),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 20),
      child: Text(
        title,
        style: const TextStyle(
          color: Color(0xFFE5E5E5),
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.28,
        ),
      ),
    );
  }

  Widget _buildPosterGrid(int count) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(), // ListView와 충돌 방지
      itemCount: count,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        childAspectRatio: 136 / 194,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap:  () {
            // 여기서 원하는 동작 실행
            debugPrint('포스터 $index 클릭됨');
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ArtistPerformanceDetailPage(),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF5C5C5C),
              borderRadius: BorderRadius.circular(2),
              image: const DecorationImage(
                image: AssetImage('assets/images/poster.png'),
                fit: BoxFit.cover,
              ),
            ),
          )
        );
      },
    );
  }

  Widget _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 24),
      height: 1,
      color: const Color(0xFF3C3C3C),
    );
  }
}