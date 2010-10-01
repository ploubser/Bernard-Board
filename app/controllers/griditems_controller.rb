class GriditemsController < ApplicationController
  protect_from_forgery :only => [:index, :create_grid_item]
  # GET /griditems
  # GET /griditems.xml
  def index
    @fullscreen = params["fullscreen"]
    @load_board = params["load_board"]
    @griditems = Griditem.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @griditems }
    end
  end


  def create_grid_item
    @dimentions = [params[:height], params[:width]]
    @type = params[:type]
    @parameters = params
    @refresh_rate = params[:refresh_rate]
    @title = params[:title]

    render :update do |page|
        page << "disablePopup();"
        page.insert_html :bottom, :container, :partial => "item" 
    end
  end
 
  def update_grid_item
    @dimentions = [params[:height], params[:width]]
    @timestamp = "#{Time.now.to_i}#{rand(16)}#{rand(10)}#{rand(10)}#{rand(10)}"
    @type = params[:type]
    @parameters = params
    @refresh_rate = params[:refresh_rate]
    @title = params[:title]

    render :update do |page|
      page << "var lastPosition = jQuery(lastTarget).offset();"
      page << "disablePopup();"
      page << "jQuery(lastTarget).remove()"
      page.insert_html :bottom, :container, :partial => "item"
      page << "jQuery('#item#{@timestamp}').offset(lastPosition);"
    end
  end

  def save_state
      @json = ActiveSupport::JSON.decode(params[:json])
        
      #Ungodly terrible hack used to update an already stored table. Fix it
      if Board.find_by_name(params[:board_name])
          Board.delete_all("name='#{params[:board_name]}'")
          BoardItem.delete_all("board='#{params[:board_name]}'")
      end
      
      @json.each do |item|
          board_item = BoardItem.create do |u|
            u.name = item[0]
            u.height = item[1]["height"].to_i
            u.width = item[1]["width"].to_i
            u.x_axis = item[1]["left"]
            u.y_axis = item[1]["top"]
            u.board_type = item[1]["type"]
            u.parameters = item[1]["params"]
            u.refresh_rate = item[1]["refresh_rate"]
            u.board = params[:board_name]
            u.title = item[1]["title"]
          end
      end

     Board.create do |u|
          u.name = params[:board_name]
          u.height = params[:board_height]
          u.width = params[:board_width]
     end
    
      render :update do |page|
        page.call :alert, "Window state has been saved"
        page.replace_html  :content, :partial => "boards"
      end
  end

  def resize_screen
    @screen_height = params[:height]
    @screen_width = params[:width]
    render :update do |page|
        page <<  "window.resizeTo(#{params[:width]}, #{params[:height]});"
    end
  end

  def refresh
      @title = params[:title]
      @parameters = {}
      params[:parameters].split(";").each do |p|
        tmp = p.split(/:/, 2)
        @parameters[tmp[0]] = tmp[1]
      end

      render :update do |page|
        page.replace_html params[:id], :partial => "griditems/plugins/#{params[:type].downcase}/#{params[:type].downcase}"
      end
  end

  def render_form
      render :update do |page|
       unless  params[:type] == ""
           page.replace_html "form_content", :partial => "griditems/plugins/#{params[:type].downcase}/formfor_#{params[:type].downcase}", :locals =>{:type=>params[:type]}
       else 
           page.replace_html "form_content", :text => ""
       end
      end
  end

  def load_board

      board_items = BoardItem.find_all_by_board(params[:name])

      render :update do |page|
          page << "jQuery('.item').remove()"
          board_items.each do |item|
            @dimentions = [item.height, item.width]
            @type = item.board_type
            @parameters = {}
            @position = []
            @timestamp = item.name.gsub("item", "")
            @refresh_rate = item.refresh_rate
            @title = item.title

            item.parameters.split(";").each do |p|
              tmp = p.split(/:/, 2)
              @parameters[tmp[0]] = tmp[1]
            end
            RAILS_DEFAULT_LOGGER.debug @parameters.inspect
            @position = [item.x_axis, item.y_axis]
            @state = params[:state]
            page.insert_html :bottom, :container, :partial => "item"
            @position = ""
            page << "disablePopup()"
          end
      end
  end

  def delete_board
      Board.delete_all("name = '#{params[:name]}'")
      BoardItem.delete_all("board = '#{params[:name]}'")
      
      render :update do |page|
        page.replace_html  :content, :partial => "boards"
      end

  end

  def redraw_gauge
      div = ""
      value = ""
      if params[:id] =~ /item(\d+)/
          div = "con#{$1}"
      end
      @parameters = {}
      params[:parameters].split(";").each do |p|
        tmp = p.split(/:/, 2)
        @parameters[tmp[0]] = tmp[1]
      end
        
      unless @parameters["remote"] == "true"
        tmp = File.open(@parameters["path"], 'r')
        value = tmp.gets()
      else
          Net::HTTP.start(@parameters["url"]) do |http|
              resp = http.get("/#{@parameters["path"]}")
              value = resp.body
          end
      end

      render :update do |page|
          page << "redrawGauge(#{value}, '#{div}')"
      end
  end

  def edit
      item = BoardItem.find_by_name(params[:last_target])
      render :update do |page|
           page << "centerPopup('popup');"
           page << "loadPopup('popup')"
           page.replace_html "form_content", :partial => "griditems/plugins/#{item.board_type.downcase}/formfor_#{item.board_type.downcase}", :locals =>{:type=>item.board_type}
      end
  end

end
