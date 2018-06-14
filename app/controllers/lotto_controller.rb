class LottoController < ApplicationController
    
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
        
    
end
