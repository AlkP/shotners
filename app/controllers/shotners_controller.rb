class ShotnersController < ApplicationController
  def create
    if /^(http|https|ftp):\/\/[a-z0-9\-]*\.[a-z]*/ =~ params["shotner"][:original_url].downcase
      #@url = "#{request.protocol}#{request.host_with_port}/" + url_generate
      @url = url_generate
      #@shotner = Shotner.new(:user_id => current_user.id, :type_url => params["lili"][:type_url], :original_url => params["lili"][:original_url], :shortened_url => @url, :usage_count => 0 )
      if current_user.nil?
        @shotner = Shotner.new( :original_url => params["shotner"][:original_url], :shortened_url => @url, :usage_count => 0 )
      else
        @shotner = Shotner.new( :password_link => params["shotner"][:password_link], :public_link => params["shotner"][:public_link], :user_id => current_user.id, :original_url => params["shotner"][:original_url], :shortened_url => @url, :usage_count => 0 )
      end

      if @shotner.save
        redirect_to root_url#, :notice => "Create new shotner"
      else
        redirect_to root_url, flash: { save: "Shotner not save" }#:notice => "Shotner not save"
      end
    else
      redirect_to root_url, flash: { save: "Wrong format URL" }#:notice => "Wrong format URL"
    end
  end

  def index
    @shotner_new = Shotner.new
    @url = "#{request.protocol}#{request.host_with_port}/"
    @shotners_last = list_shotners_last
    @shotners_popular = list_shotners_popular
    @shotners_my = list_shotners_my
  end

  def request_url
    present_url(params[:tail])
  end

  private

  def present_url(tail)
    @url_to = Shotner.find_by_shortened_url(tail)
    @usage_count = @url_to.usage_count + 1
    @url_to_link = @url_to.original_url
    if @url_to.present?
      if @url_to.public_link.nil?
        # Если ссылку ввел не пользователь системы
        Shotner.update(@url_to.id, :usage_count => @usage_count)
        redirect_to @url_to_link
      else

        if current_user
          if current_user.id == @url_to.user_id
            # Текущий пользователь является владельцем ссылки
            Shotner.update(@url_to.id, :usage_count => @usage_count)
            redirect_to @url_to_link
          else
            # Текущий пользователь НЕ является владельцем ссылки
            redirect_to root_url, :notice => "You are  not have access to short URL"
          end

        else
          if @url_to.public_link
            #redirect_to "#modal-container-258522"
            # Не залогинен в систему и ссылка является публичной  НУЖНО ДОБАВИТЬ ПРОВЕРКУ ПАРОЛЯ ВАЖНО!!!
            redirect_to new_check_path, flash: { password: @url_to.id }
            #Shotner.update(@url_to.id, :usage_count => @usage_count)
            #redirect_to @url_to_link
          else
            redirect_to root_url, :notice => "You are  not have access to short URL"
          end
        end




      end
    else
      redirect_to root_url, :notice => "Wrong short URL"
    end
  end

  def url_generate(len=7)
    chars = ('a'..'z').to_a + ('A'..'Z').to_a + ('1'..'9').to_a - ['o', 'O', 'i', 'I']
    return Array.new(len) { chars[rand(chars.size)] }.join
  end

  def list_shotners_last
    Shotner.index_last(nil)
  end

  def list_shotners_popular
    Shotner.index_popular(nil)
  end

  def list_shotners_my
    Shotner.index_my(current_user)
  end
  
end
