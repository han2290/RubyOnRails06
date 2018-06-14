class UserController < ApplicationController
    
    def index #목록
        puts "index임"
        @users = User.all #모든 인스턴스(table's row) 가져옴
    end
    
    def show #하나
        @user = User.find(params[:id])
    end
    
        
    def new #생성
    end
    
    def create
        u1 = User.new
        u1.user_name = params[:name]
        u1.password = params[:password]
        u1.save
        
        redirect_to "/user/#{u1.id}"#redirect_to를 통해 redirect를 한다.
    end
    
end
