class CheckController < ApplicationController
  def new
    @lol = ActiveSupport::HashWithIndifferentAccess.new
    #@lol.new_column('string', 'password' )
    flash.each do |name, msg|
      @id = msg
    end
  end

  def show
    @access = check_pass_for_url(params[:ids], params[:password])
    if @access
      redirect_to @access
    else
      redirect_to root_url
    end

  end

  private

  def check_pass_for_url(id,password)
    @test = Shotner.url_to(id)
    @test.each do |first|
      @pass = first.password_link
      @url = first.original_url
      @usage_count = first.usage_count + 1
    end

    if @pass == password
      Shotner.update(id, :usage_count => @usage_count)
      @url
    else
      false
    end
 end

end
