module Api
  module V1
    class NewsController < ApiController
      before_action { self.namespace_for_serializer = Api::V1 }
      swagger_controller :news, 'News Management'

      # GET /news
      swagger_api :index do
        summary 'To get all news'
        notes 'Implementation notes, such as required params, example queries for apis are written here.'
        # param :form, "user[name]", :string, :required, "Name of user"
        # param :form, "user[age]", :integer, :optional, "Age of user"
        # param_list :form, "user[status]", :string, :required, "Status of user, can be active or inactive"
        response :success
        response :unprocessable_entity
        response 500, 'Internal Error'
      end
      def index
        @news = News.all
        render json: @news, status: :ok
        # success!(news, NewsSerializer)
      end

      # GET /news/:id
      swagger_api :show do
        summary 'To get one news'
        notes 'Implementation notes, such as required params, example queries for apis are written here.'
        param :path, :id, :integer, :optional, 'News Id'
        response :ok, 'Success', :News
        response :unauthorized
        response :not_acceptable
        response :not_found
      end
      def show
        news = News.find_by_id(params[:id])
        raise Error::NotVisibleError unless news

        success!(news, NewsLightSerializer)
      end
    end
  end
end