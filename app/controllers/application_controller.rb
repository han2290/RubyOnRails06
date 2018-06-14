class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception #토큰이 넘어왔는지 않넘어왔는지 판단하는 코드
end
