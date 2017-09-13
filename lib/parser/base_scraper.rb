module Parser
  class BaseScraper

    def total_count_pages(url, options ={})
      str = agent.get(url).at(options[:paginate_container]).attr('href')
      str.scan(/\d+/).last.to_i rescue 1
    end

    def get_page_links(url, options ={})
      agent.get(url).search(options[:container_link])
    end

    def get_news_data(url, domain, options = {})
      info = Hash.new
      info[:news] = {}
      info[:photos] = {}
      page = agent.get(url)

      info[:news][:title] = page.search(options[:container_title]).text.strip
      info[:news][:date] = page.search(options[:container_date]).text.strip
      info[:news][:description] = page.search(options[:container_description]).text.strip.delete("\r").delete("\n").delete("\t")
      info[:news][:city_id] = get_city_id(info[:news][:title])

      image_node = page.search(options[:container_image])

      if !image_node.blank? && !image_node.attr('class').nil? && image_node.attr('class').value  == 'img'
        span_img = image_node.attr('style').value
        info[:news][:remote_image_url] = span_img.slice!(/http.*jpg/)
        info[:photos][:remote_photo_url] = [ info[:news][:remote_image_url] ]
      elsif !image_node.blank?
        info[:news][:remote_image_url] = get_image_url(image_node.attr('src').value, domain)

        nodes = page.search(options[:container_image])
        info[:photos][:remote_photo_url] = []
        nodes.each do |node|
          link = get_image_url(node.attr('src'), domain)
          info[:photos][:remote_photo_url] << link
          info[:photos]
        end
      end

      info
    end



    private

    def agent
      @agent ||= Mechanize.new
    end

    def save_news_and_photos(news, photos)
      record = News.create!(news)
      photos[:remote_photo_url].each { |photo| record.photos.create(remote_photo_url: photo) } unless photos[:remote_photo_url].nil?
      p "news and photos for: #{record.title}, is saved..."
    rescue ActiveRecord::RecordInvalid => e
      Rails.logger.error "Parser::BaseScraper ERROR! Message: #{e}."
    end
  end
end