module Jekyll
  class LlmsFullGenerator < Generator
    safe true
    priority :low

    def generate(site)
      posts = site.posts.docs.sort_by(&:date).reverse
      content = build_content(site, posts)

      page = PageWithoutAFile.new(site, site.source, "", "llms-full.txt")
      page.content = content
      page.data["layout"] = nil
      page.data["permalink"] = "/llms-full.txt"
      page.data["render_with_liquid"] = false
      site.pages << page
    end

    private

    def build_content(site, posts)
      url = site.config["url"].to_s.chomp("/")
      title = site.config["title"]
      author = site.config.dig("social", "name") || site.config["author"]

      lines = []
      lines << "# #{title} — Full Content Index"
      lines << ""
      lines << "> Author: #{author}"
      lines << "> Language: Korean (한국어)"
      lines << "> URL: #{url}"
      lines << "> Total Posts: #{posts.size}"
      lines << "> Post Index: #{url}/llms.txt"
      lines << ""
      lines << "---"

      posts.each do |post|
        lines << ""
        lines << "# #{post.data["title"]}"
        lines << ""
        lines << "URL: #{url}#{post.url}"
        lines << "Date: #{post.date.strftime("%Y-%m-%d")}"

        cats = Array(post.data["categories"]).reject(&:empty?)
        lines << "Categories: #{cats.join(", ")}" unless cats.empty?

        tags = Array(post.data["tags"]).reject(&:empty?)
        lines << "Tags: #{tags.join(", ")}" unless tags.empty?

        desc = post.data["description"].to_s.strip
        lines << "Summary: #{desc}" unless desc.empty?

        lines << ""
        lines << raw_markdown(post.path)
        lines << ""
        lines << "---"
      end

      lines.join("\n")
    end

    def raw_markdown(path)
      raw = File.read(path, encoding: "utf-8")
      # Strip YAML front matter (everything between first and second ---)
      parts = raw.split(/^---\s*$/, 3)
      parts.size >= 3 ? parts[2].strip : raw.strip
    rescue Errno::ENOENT
      ""
    end
  end
end
