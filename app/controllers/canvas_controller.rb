class CanvasController < ApplicationController
  def index
      @canvas = Canvas.find(:all)
      respond_to do |format|
          format.html
      end
  end

  def refresh
      can = Canvas.find_by_name(params[:id])
      render :update do |page|
        page.replace_html params[:id], :partial => "gauge", :locals => {:can => can}
      end
  end


end
