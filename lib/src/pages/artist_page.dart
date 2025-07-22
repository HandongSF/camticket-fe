/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'package:camticket/provider/artist_manager_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/artist_performance_provider.dart';
import '../../utility/color.dart';

class ArtistPage extends StatefulWidget {
  const ArtistPage({super.key});

  @override
  State<ArtistPage> createState() => _ArtistPageState();
}

class _ArtistPageState extends State<ArtistPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ArtistManagerProvider>(context, listen: false).loadManagers();
    });
  }

  int selectedCategory = 0;
  int selectedSort = 0; // 등록순(0) / 최신순(1)

  final List<String> categories = ['전체', '음악', '연극 / 뮤지컬', '댄스'];

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
            Flexible(
              child: Consumer<ArtistManagerProvider>(
                builder: (context, provider, child) {
                  final artists = provider.managers;

                  return ListView(
                    children: [
                      _buildSectionTitle('아티스트 목록'),
                      _buildArtistRow(
                        artists
                            .map((e) => {
                                  'name': e.nickName,
                                  'image': e.profileImageUrl,
                                  'userId': e.userId
                                })
                            .toList(),
                      ),
                    ],
                  );
                },
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
    List<Widget> rows = [];

    for (int i = 0; i < artists.length; i += 3) {
      final chunk = artists.sublist(
        i,
        i + 3 > artists.length ? artists.length : i + 3,
      );

      rows.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(3, (index) {
              if (index < chunk.length) {
                final artist = chunk[index];
                return Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      await Provider.of<ArtistPerformanceProvider>(context,
                              listen: false)
                          .loadPerformances(artist['userId']);
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) =>
                            Consumer<ArtistPerformanceProvider>(
                          builder: (context, provider, _) {
                            return ArtistDetailBottomSheet(
                              name: artist['name'],
                              profile: artist['image'],
                              posters: provider.performances
                                  .map((e) => e.profileImageUrl)
                                  .toList(),
                              description:
                                  '안녕하세요! 저희는 한동대학교 동아리 ${artist['name']}입니다.',
                            );
                          },
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 32,
                          backgroundColor: AppColors.gray2,
                          backgroundImage: NetworkImage(artist['image']),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          artist['name'],
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
              } else {
                return const Expanded(child: SizedBox()); // 빈 공간 채우기
              }
            }),
          ),
        ),
      );
    }

    return Column(children: rows);
  }
}

class ArtistDetailBottomSheet extends StatelessWidget {
  final String name;
  final String profile;
  final String description;
  final List<String> posters;

  const ArtistDetailBottomSheet({
    super.key,
    required this.name,
    required this.profile,
    required this.description,
    required this.posters,
  });

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
                    backgroundImage: NetworkImage(profile),
                    radius: 50,
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        profile,
                        width: 53,
                        height: 18,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        name,
                        style: const TextStyle(
                          color: Color(0xFFE5E5E5),
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
                    Image.network(
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
