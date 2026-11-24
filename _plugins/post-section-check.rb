# 글의 카테고리가 _data/sections.yml 목록 안에 있는지 보고, 큰 갈래로 섹션(기술·성찰)을 정한다.
# 카테고리는 [큰 갈래, 작은 갈래] 두 개여야 한다.
# 목록 밖이면 홈과 섹션 목록 어디에도 나오지 않으므로, 배포 빌드에서는 멈추고 로컬에서는 경고한다.

Jekyll::Hooks.register :site, :post_read do |site|
  owners = {}
  site.data.fetch("sections", {}).each do |section, info|
    info.fetch("categories", {}).each { |top, subs| owners[top] = [section, subs] }
  end

  problems = site.posts.docs.reject do |post|
    categories = Array(post.data["categories"])
    section, subs = owners[categories.first]
    next false unless section && categories.size == 2 && subs.include?(categories.last)

    post.data["section"] = section
  end
  next if problems.empty?

  listed = problems.map { |post| "#{post.relative_path} #{post.data['categories'].inspect}" }
  message = "카테고리가 _data/sections.yml 목록과 맞지 않는 글: #{listed.join(', ')}"
  raise message if Jekyll.env == "production"

  Jekyll.logger.warn "Categories:", message
end
