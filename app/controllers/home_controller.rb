class HomeController < ApplicationController
    
    def index
        @msg = "아아안녀어어엉"
    end
    
    def lotto
        @lotto = (1..45).to_a.sample(6).sort
    end
    
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
    
end
