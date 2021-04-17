module ConsumesHelper

  def this_consume(user, month, week, this_category)
    if this_category.to_s == "Colación"
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
      @total_consumes.reduce(&:+)
    end
    if @total_consumes[0].nil?
      @consumes_amount = 0
    else
      @consumes_amount = @total_consumes[0]
    end
    return number_with_delimiter(@consumes_amount.round)
  end
end
