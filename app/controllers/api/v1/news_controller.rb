module Api
  module V1
    class NewsController < ApiController
      before_action { self.namespace_for_serializer = Api::V1 }

      def index
        news = News.all
        success!(news, NewsSerializer)
      end

      def show
        news = News.find_by_id(params[:id])
        raise Error::NotVisibleError unless news

        success!(news, NewsLightSerializer)
      end
    end
  end
end