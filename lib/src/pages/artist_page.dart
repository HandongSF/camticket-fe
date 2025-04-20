import 'package:flutter/material.dart';

import '../../utility/color.dart';

class ArtistPage extends StatefulWidget {
  const ArtistPage({super.key});

  @override
  State<ArtistPage> createState() => _ArtistPageState();
}

class _ArtistPageState extends State<ArtistPage> {
  int selectedCategory = 0;
  int selectedSort = 0; // 등록순(0) / 최신순(1)

  final List<String> categories = ['음악', '연극 / 뮤지컬', '댄스', '전시'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                '아티스트',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: List.generate(categories.length, (index) {
                  final isSelected = selectedCategory == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = index;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.subPurple
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: AppColors.gray3),
                      ),
                      child: Text(
                        categories[index],
                        style: TextStyle(
                          color: isSelected
                              ? AppColors.mainBlack
                              : AppColors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                // padding:
                //     const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                children: [
                  _buildSectionTitle('밴드 / 작사작곡 / 재즈'),
                  _buildArtistRow([
                    {
                      'name': '네오',
                      'image': 'assets/images/zzanggu.png',
                    },
                    {'name': '리퀴드', 'image': 'assets/images/zzanggu.png'},
                    {'name': '미르', 'image': 'assets/images/zzanggu.png'},
                    {'name': '즉새두', 'image': 'assets/images/zzanggu.png'},
                  ]),
                  const SizedBox(height: 24),
                  _buildSectionTitle('사물놀이'),
                  _buildArtistRow([
                    {'name': '한풍', 'image': 'assets/images/zzanggu.png'},
                  ]),
                  const SizedBox(height: 24),
                  _buildSectionTitle('아카펠라'),
                  _buildArtistRow([
                    {'name': '실버라이닝', 'image': 'assets/images/zzanggu.png'},
                    {'name': '피치파이프', 'image': 'assets/images/zzanggu.png'},
                  ]),
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
      padding: const EdgeInsets.only(bottom: 12, left: 20),
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.gray4,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: -0.28,
        ),
      ),
    );
  }

  Widget _buildArtistRow(List<Map<String, dynamic>> artists) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          border: Border.symmetric(
            horizontal: BorderSide(
              width: 1,
              color: AppColors.gray2,
            ),
          ),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: artists.map((artist) {
              return GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => ArtistDetailBottomSheet(
                      name: artist['name'],
                      profile: 'assets/images/zzanggu.png',
                      description: '설명없음',
                      posters: [],
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 28),
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          CircleAvatar(
                            radius: 32,
                            backgroundColor: AppColors.gray2,
                            backgroundImage: AssetImage(artist['image']!),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        artist['name']!,
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          height: 1.43,
                          letterSpacing: 0.10,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class ArtistDetailBottomSheet extends StatelessWidget {
  final String name;
  final String profile;
  final String description;
  final List<String> posters;

  const ArtistDetailBottomSheet({
    Key? key,
    required this.name,
    required this.profile,
    required this.description,
    required this.posters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      maxChildSize: 0.95,
      minChildSize: 0.6,
      builder: (context, scrollController) => Container(
        decoration: const BoxDecoration(
          color: AppColors.mainBlack,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close, color: AppColors.white),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(profile),
                    radius: 36,
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.subPurple,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          '아티스트',
                          style: TextStyle(
                            fontSize: 10,
                            color: AppColors.mainBlack,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 20,
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 16),
              Text(
                description,
                style: const TextStyle(
                  color: AppColors.gray4,
                  fontSize: 13,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: posters.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemBuilder: (context, index) => Stack(
                  alignment: Alignment.topRight,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        posters[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Positioned(
                      top: 6,
                      right: 6,
                      child: CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.yellow,
                        child: Text(
                          '박',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
