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
                      description:
                          '안녕하세요! 저희는 한동대학교 작사작곡 동아리 NEO입니다. 매 해 정기공연과 축제 공연, NEO카페를 통해 저희 만의 이야기를 들려드리고 있습니다.',
                      posters: [
                        'assets/images/poster.png',
                        'assets/images/poster.png',
                        'assets/images/poster.png',
                        'assets/images/poster.png',
                        'assets/images/poster.png',
                        'assets/images/poster.png'
                      ],
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
      initialChildSize: 0.6,
      maxChildSize: 0.6,
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
                    radius: 50,
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/artist.png',
                        width: 53,
                        height: 18,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        name,
                        style: const TextStyle(
                          color: const Color(0xFFE5E5E5),
                          fontSize: 20,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.40,
                        ),
                      ),
                      SizedBox(height: 8),
                      SizedBox(
                        width: 220,
                        child: Text(
                          description,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color(0xFF818181),
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            letterSpacing: -0.24,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(height: 20),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: posters.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 0,
                  childAspectRatio: 136 / 194,
                ),
                itemBuilder: (context, index) => Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Image.asset(
                      posters[index],
                      fit: BoxFit.fill,
                      width: 136,
                      height: 194,
                    ),
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
