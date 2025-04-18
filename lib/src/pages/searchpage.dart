import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:camticket/utility/color.dart';

class Searchpage extends StatefulWidget {
  const Searchpage({Key? key}) : super(key: key);

  @override
  _Searchstate createState() => _Searchstate();
}

class _Searchstate extends State<Searchpage> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _searchResults = [];
  List<String> _recentSearches = [];

  @override
  void initState() {
    super.initState();
    _loadRecentSearches();
  }

  Future<void> _loadRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _recentSearches = prefs.getStringList('recent_searches') ?? [];
    });
  }

  Future<void> _saveRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('recent_searches', _recentSearches);
  }

  void _onSearch(String query) {
    if (query.trim().isEmpty) return;

    setState(() {
      _searchResults = _mockSearch(query);
      _recentSearches.remove(query);
      _recentSearches.insert(0, query);
      if (_recentSearches.length > 20) {
        _recentSearches = _recentSearches.sublist(0, 20);
      }
    });

    _saveRecentSearches();
    _searchController.clear();
  }

//임시로 search되는 것들 리스트
  List<String> _mockSearch(String query) {
    final data = ['스트리트 무대', '캠티켓', '마이크 쇼케이스', '클래식 페스티벌', '서울 댄스 페어'];
    return data.where((item) => item.contains(query)).toList();
  }

//최근 검색어 삭제
  void _removeRecentSearch(String term) {
    setState(() {
      _recentSearches.remove(term);
    });
    _saveRecentSearches();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: TextField(
          controller: _searchController,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: '검색어를 입력하세요',
            hintStyle: const TextStyle(color: Colors.white54),
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: () => _onSearch(_searchController.text),
            ),
          ),
          onSubmitted: _onSearch,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_recentSearches.isNotEmpty) ...[
              const Text('최근 검색어', style: TextStyle(color: Colors.white)),
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _recentSearches
                      .map((term) => Container(
                            margin: const EdgeInsets.only(right: 8),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.grey[800],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                Text(term,
                                    style:
                                        const TextStyle(color: Colors.white)),
                                const SizedBox(width: 6),
                                GestureDetector(
                                  onTap: () => _removeRecentSearch(term),
                                  child: const Icon(Icons.close,
                                      size: 16, color: Colors.white54),
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                ),
              ),
              const SizedBox(height: 24),
            ],
            if (_searchResults.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: _searchResults.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(_searchResults[index],
                        style: const TextStyle(color: Colors.white)),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
