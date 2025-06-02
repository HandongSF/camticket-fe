import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Searchpage extends StatefulWidget {
  const Searchpage({super.key});

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

    _searchController.text = query;

    setState(() {
      _searchResults = _mockSearch(query);
      _recentSearches.remove(query);
      _recentSearches.insert(0, query);
      if (_recentSearches.length > 20) {
        _recentSearches = _recentSearches.sublist(0, 20);
      }
    });

    _saveRecentSearches();
  }

  List<String> _mockSearch(String query) {
    final data = ['스트리트 무대', '캠티켓', '마이크 쇼케이스', '클래식 페스티벌', '서울 댄스 페어'];
    return data.where((item) => item.contains(query)).toList();
  }

  void _removeRecentSearch(String term) {
    setState(() {
      _recentSearches.remove(term);
    });
    _saveRecentSearches();
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Center(
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF242424),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              controller: _searchController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: '검색어를 입력하세요',
                hintStyle:
                    const TextStyle(color: Color(0xFF5D5D5D), fontSize: 16),
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search, color: Color(0xFF5D5D5D)),
                  onPressed: () => _onSearch(_searchController.text),
                ),
              ),
              onSubmitted: _onSearch,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '최근 검색어',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            const SizedBox(height: 12),
            ...(_recentSearches.isEmpty
                ? [
                    Center(
                      child: Text(
                        '최근 검색기록이 없습니다',
                        style:
                            TextStyle(color: Color(0xff828282), fontSize: 12),
                      ),
                    )
                  ]
                : [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: _recentSearches
                            .map((term) => GestureDetector(
                                  onTap: () => _onSearch(term),
                                  child: Container(
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
                                            style: const TextStyle(
                                                color: Colors.white)),
                                        const SizedBox(width: 6),
                                        GestureDetector(
                                          onTap: () =>
                                              _removeRecentSearch(term),
                                          child: const Icon(Icons.close,
                                              size: 16, color: Colors.white54),
                                        ),
                                      ],
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    )
                  ]),
            const SizedBox(height: 24),
            if (_searchResults.isEmpty)
              Container(
                width: double.infinity,
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/mic.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            if (_searchResults.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: _searchResults.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(
                      _searchResults[index],
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
