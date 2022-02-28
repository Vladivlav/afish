class PlaybillSerializer < ActiveModel::Serializer
  attributes :start_date, :finish_date, :title

  def start_date
    object.duration.begin
  end

  def finish_date
    object.duration.end
  end
end
