class HomeController < ApplicationController
  require 'csv'

  # GET ('/')
  def index
  end


  # POST ('/upload')
  def upload
    begin
      top_list = HomeHelper.get_list(params[:user][:file].path)

      filepath = HomeHelper.print(top_list)

      redirect_to show_results_url(path: filepath)
    rescue => ex
      puts "#{ex.backtrace}"
    end
  end

  # GET ('/results')
  def results
    @file_url = params[:path].gsub('/public', '') if params[:path]
  end
end