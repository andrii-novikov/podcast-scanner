class PodcastLinksController < ApplicationController
  def index
    result = PodcastLink.search(
      query: {
        multi_match: {
          query: params[:q],
          fields: ['title^10','content^2','link']
        }
      }
    )

    respond_to do |format|
      format.json { render json: result }
    end
  end

  private

  def query_params
    params.permit(:q)
  end
end
