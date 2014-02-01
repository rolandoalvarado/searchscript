class UsersController < ApplicationController
  before_filter :load_current_user
  #before_filter :authorize, :except => [:new, :create, :new_merchant, :create_merchant]
  
  def index
  end
  
  def new
    @user = User.new
    @user.build_classifications
  end
  
  def create
    @user = User.new(user_params)
    # Attribute accessor to prevent automated registration.
    # This field should be left blank otherwise data will not be saved. 
    @nick_name = @user.nick_name 
    
    respond_to do |format|
      if @nick_name.blank?	
        if @user.save
          UserMailer.welcome(@user).deliver
					format.html { redirect_to root_path, notice: 'Your registration is successful!' }
          #format.json { render action: 'show', status: :created, location: @user }
        else
          format.html { render action: 'new' }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end  
      end # /if @nick_name
    end # /respond_to
    
  end
  
  def new_merchant
    @user = User.new
    @user.build_merchants
  end
  
  def create_merchant
    @user = User.new(user_merchant_params)
    # Attribute accessor to prevent automated registration.
    # This field should be left blank otherwise data will not be saved. 
    @nick_name = @user.nick_name 
    
    respond_to do |format|
      if @nick_name.blank?	
        if @user.save
          # Add Location Records for GeoTagging.
          address = "#{params[:user][:merchants_attributes][:m_city]}, #{params[:user][:merchants_attributes][:m_state]}, #{request.location.country}"
          address_city = "#{params[:user][:merchants_attributes][:m_city]}, #{request.location.country}"
          address_state = "#{params[:user][:merchants_attributes][:m_state]}, #{request.location.country}"
          
          location_records = [
            { :user_id => @user.id, :address => address },
            { :user_id => @user.id, :address => address_city },
            { :user_id => @user.id, :address => address_state }
          ]
          
          Location.create(location_records)
          #---------------------------------------------------------------------
          UserMailer.welcome(@user).deliver
					format.html { redirect_to login_path, notice: 'Registration is successful! You ca now login using your username.' }
          #format.json { render action: 'show', status: :created, location: @user }
        else
          format.html { render action: 'new_merchant' }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end  
      end # /if @nick_name
    end # /respond_to
    
  end

  private
  
  def user_params
    params.require(:user).permit(:u_username, :nick_name, :password, 
      :password_confirmation, :u_email, :u_phone_number, :u_newsletter, 
      :agree_wt_use,
      classifications_attributes: [:id, :c_make, :c_model, :c_year])                                
  end

  def user_merchant_params
    params.require(:user).permit(:u_username, :nick_name, :password, 
      :password_confirmation, :u_email, :agree_wt_use,
      merchants_attributes: [:id, :m_business_name, :m_contact_name, :m_business_email, 
                             :m_business_phone_number, :m_business_address, :m_city, 
                             :m_state, :m_zip_code])
  end
end
