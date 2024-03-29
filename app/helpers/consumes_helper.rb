module ConsumesHelper

  def this_consume(user, month, week, this_category)
    if this_category == "Colación"
      @user_consumes = Consume.where(user_id: user, category: this_category)
    else 
      @user_consumes = Consume.where(user_id: user).where.not(category: "Colación")
    end
    @total_consumes = []
    @user_consumes.each do |consume|
      @date = consume.created_at.strftime("%d-%m-%Y")
      @fixed_date = @date.split('-')
      @day = @fixed_date[0].to_i
      @month = @fixed_date[1].to_i
      @year = @fixed_date[2].to_i
      @number_of_week = Date.new(@year, @month, @day).week_of_month
      if @number_of_week == week and @month == month
        @total_consumes.push(consume.total_amount)
      end
    end
    @total_consumes.reduce(&:+)
    if @total_consumes[0].nil?
      @consumes_amount = 9000
    else
      @consumes_amount = 9000 - @total_consumes.reduce(&:+)
    end
    return number_with_delimiter(@consumes_amount.round)
  end


  def monthly_consumes(user, month, year)
    @user_consumes = Consume.where(user_id: user, category: "Colación")
    @total_consumes = []
    @user_consumes.each do |consume|
      @date = consume.created_at.strftime("%d-%m-%Y")
      @fixed_date = @date.split('-')
      @day = @fixed_date[0].to_i
      @month = @fixed_date[1].to_i
      @year = @fixed_date[2].to_i
      if @month == month && @year == year
        @total_consumes.push(consume.total_amount)
      end
    end
    @total_consumes.reduce(&:+)
    if @total_consumes[0].nil?
      @consumes_amount = 0
    else
      @consumes_amount = @total_consumes.reduce(&:+)
    end
    return @consumes_amount.round
  end
end
