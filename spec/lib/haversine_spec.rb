require 'spec_helper'

describe App do

  def app
    Haversine
  end

  describe "Formula" do

    let(:car_position) {[-43, -172]}
    let(:call_position) {[-44, -171]}

    let(:distance1) { app.distance(car_position, call_position) }
    let(:eta1) { distance1 * 1.5 }

    describe "calculate haversine distance and eta" do
      it {expect(distance1.round(12)).to eql(137.365669065197)}
      it {expect(eta1.round(12)).to eql(206.048503597796)}
    end
  end

end