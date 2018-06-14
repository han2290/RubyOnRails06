

# DAY 06

* `$ rake routes`로 현재 라우팅 목록을 확인할 수 있음

## Controller

* 역할?
  * 서비스로직을 가지고 있음
  * 그동안 app.rb에서 작성했던 모든 내용이 `Controller`에 들어감
* `Controller`는 하나의 서비스에 대해서만 관련한다.
* `Controller`를 만들 떄에는 `$ rails g controller 컨드롤러명`을 이용한다.

```
$ rails g controller name
# app/controllers/home_controller.rb 파일 생성
```

```ruby
Running via Spring preloader in process 1729
      create  app/controllers/home_controller.rb
      invoke  erb
      create    app/views/home
      invoke  test_unit
      create    test/controllers/home_controller_test.rb
      invoke  helper
      create    app/helpers/home_helper.rb
      invoke    test_unit
      invoke  assets
      invoke    coffee
      create      app/assets/javascripts/home.coffee
      invoke    scss
      create      app/assets/stylesheets/home.scss
```



*app/controllers/home_controller.rb*

```ruby
class HomeController < ApplicationController
	#모든 컨트롤러는 ApplicationController를 상속한다.
end
```



> home_controller.rb

```ruby
class HomeController < ApplicationController
    
    def index
        @lotto = [1..45].to_a.sample(6)
    end
    
end
```

* `HomeController`를 만들면 *app/views* 하위에 컨트롤러 명과 일치하는 폴더가 생긴다.
* `HomeController`에서 액션(def)를 작성하면 해당 액션명과 일치하는 `view` 파일을 *app/views/home* 폴터 밑에 작성한다.
* 사용자의 요청을 받는 url 설정은 *config/routes.rb*에서 한다

> Rails에는 Development, Test, Production 환경(모드)가 있4다.
> Development 환경에서는 변경사항이 자동적으로 확인되고, 모든 로그가 적힌다.
> Production 환경에서는 변경사항도 자동으로 저장되지 않고, 로그도 일부만 적힌다. `$ rails s`로 서버를 실행하지는 않는다.



> routes.rb

``` ruby
Rails.application.routes.draw do
  get '/home/index' => 'home#index'
end
```

 `routes.rb`에서 컨트롤러에 대한 매칭을 명시해준다.



### 과제 01

* 점심메뉴를 무작위로 출력한다.
* 글자 + 이미지가 출력된다.
* 점심메뉴를 저장하는 변수는 `Hash`타입으로 한다.
  * `@lunch = {"점심메뉴 이름" => "img src"}`
* 요청은 `/lunch`로 받는다.



> home_controller.erb

```ruby
    def menu
        @lunchs = {
            "20층" => "https://scontent-sea1-1.cdninstagram.com/vp/90ffb84a809b0714026d392a3cf58f62/5BBEC8CC/t51.2885-15/e35/32859163_192201064758460_1303143212759646208_n.jpg?se=7&ig_cache_key=MTc4MTcwMDUzNzQ0NDcwOTczMA%3D%3D.2",
            "순남시레기" => "http://mblogthumb2.phinf.naver.net/20141025_85/yeoma86_1414239233821ujCoB_JPEG/IMG_5972.JPG?type=w2",
            "한솥" => "http://file.mk.co.kr/meet/neds/2017/12/image_readtop_2017_863575_15146784063153509.png",
            "편의점" => "http://cfile10.uf.tistory.com/image/2139A939590B52102170A1"
        }
        #puts (0..(lunchs.length-1)).to_a
        @lunch = @lunchs.keys.sample
    end
```



> routes.rb

```ruby
get '/lunch' => 'home#menu'
```



> menu.html.erb

```ruby
<h1>오늘의 점심 메뉴</h1>

<h3><%=@lunch%></h3>
<img src = "<%=@lunchs[@lunch]%>">
```





## Model



#### 모델 생성

```
$ rails g model 모델명
```

 ` $ rails g model user`  명령을 통해 user라는 이름을 가진 모델을 만들어 낸다.

```sql
Running via Spring preloader in process 4769
      invoke  active_record
      create    db/migrate/20180614021006_create_users.rb
      create    app/models/user.rb
      invoke    test_unit
      create      test/models/user_test.rb
      create      test/fixtures/users.yml
```



### DB

- Rails는 ORM()을 기본적으로 장착하고 있음. (Active Record)
- migrate 파일을 이용해서 DB의 구조를 잡아주고 명령어를 통해 실제 DB를 생성/변경한다.
- Model 파일을 이용해서 DB에 있는 자료를 조작함



모델을 생성시 같이 만들어졌던`db/migrate/20180614021006_create_users.rb`를 확인하고 몇 가지를 추가한다.

```ruby
class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      
      t.string "user_name"
      t.string "password"
      
      t.timestamps
    end
  end
end
```

 

`$ rake db:migrate`를 통해 설정한 속성에 맞게 스키마를 만들어낸다.

그 결과를 아래와 같이 확인할 수 있다.

```
== 20180614021006 CreateUsers: migrating ======================================
-- create_table(:users)
   -> 0.0019s
== 20180614021006 CreateUsers: migrated (0.0020s) =============================
```



> db/schema.rb

```ruby
ActiveRecord::Schema.define(version: 20180614021006) do

  create_table "users", force: :cascade do |t|
    t.string   "user_name"
    t.string   "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
```

 `db/migrate/20180614021006_create_users`에서 정의한 구조에 맞게 생성된 것을 알 수 있다.



```ruby
> u1 = User.new #유저 새로 생성, u1은 table의 인스턴스(tlble's row)가 된다.
> u1.save #유저 저장
> u1.user_name = "haha" 
> u1.save #이렇게 save를 해서 commit하지 않으면, 변경사항은 적용되지 않는다.
```

 

#### DB구조 변경

*스키마 수정 시* 기존의 스키마를 버리고, 새로 만들어야 한다.

`$ rake db:drop` 명령으로 기존의 스키마를 지우고

`$ rake db:migrate`명령으로 새로운 스키마를 구현한다.



#### DB 조작

* DB를 조작할 때는 `User(Model_name)`를 이용해 조작한다.
  * `Model.all`
  * `Model.find()`
  * `Model.new`
  * `Model.save`



`$ rails g controller user`로 DB와 관련된 처리할 컨트롤러를 생성한다.



컨트롤러와 매핑시키기 위해 routes.erb에 *user_controller*에 정의된 액션(def)을 명시해준다.

> routes.erb

```ruby
    #user_controller
    get '/users' => 'user#index'
    get '/user/:id' =>'user#show' #RESTful
    get '/users/new' => 'user#new'
    post '/user/create' => 'user#create'
```

그리고 `user controller`에 액션(def)를 정의해준다.





### 간단 과제

* 과거 추천 내역을 저장해주는 로또번호 추천기
* `/lotto` => 새로 추천받은 번호를 출력
  * `a 테그`를 이용해서 새로운 번호를 발급받는
  * 새로 발급된 번호가 가장 마지막 최상단에 같이
  * 최상단의 메세지는 `이번주 로또 번호는 {...} 입니다.`
* `/lotto/new` => 신규 번호를 발급 및 저장 후 `/lotto`로 리디렉션
* 모델명 : Lotto
* 컨트롤러명 :LottoController
* 신규 발급 버튼





1. *Lotto*라는 이름을 가진 컨트롤러와 모델을 생성한다.

   ```ruby
   $ rails g model Lotto
   $ rails g controller Lotto
   ```

   

2. routes.rb에 액션을 명시해 준다.

   > routes.rb

   ```ruby
       #Lotto
       get '/lotto' => 'lotto#index'
       post '/lotto/new' => 'lotto#new'
   ```



3. DB 구조를 정의한다.

   > db/migrate/...create_lotters.rb

   ```ruby
    def change
       create_table :lottos do |t|
         t.string "lotto_num"
         t.timestamps
       end
    end
   ```

   

4. Lotto 컨트롤러에서 액션 정의하기

   > lotto_controller.rb

   ```ruby
       def index
           @lottos = Lotto.all
           @new_lotto = Lotto.last
       end
       
       def new
           @lotto = (1..45).to_a.sample(6).sort
           
           lotto_s = Lotto.new
           lotto_s.lotto_num = @lotto.to_s
           lotto_s.save
           
           redirect_to "/lotto"
       end
   ```



5. html 문서를 작성한다.

   > index.html.erb

   ```ruby
   <h1>이번주 로또 번호는 <%= @new_lotto.lotto_num%>입니다.</h1>
   
   <form action="/lotto/new" method="POST">
       <input type="hidden" name="authenticity_token" value = "<%= form_authenticity_token %>"><br/>
       <input type="submit" value = "로또번호신규발급">
   </form>
   
   <ul>
       <% @lottos.each do |lotto|%>
           <li><%=lotto.lotto_num%></li>
       <%end%>
   </ul>
   ```

    여기서 주의할 점은 rails는 form의 액션에 데이터를 보낼때, *token*을 같이 전송해줘야 정상적으로 동작한다는 것이다.

   > controllers/application_controller.rb

   ```ruby
   protect_from_forgery with: :exception
   ```

    이 코드가 토큰이 전송되었는지를 판단한다. 이 부분을 주석처리한다면 더이상 토큰을 전송하지 않아도 된다. 하지만 보안에 있어서 취약해진다는 단점이 생긴다.

   





