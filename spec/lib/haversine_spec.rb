require 'spec_helper'

describe App do

  def app
    Haversine
  end

  describe "Formula" do

    let(:car_position) {[-43, -172]}
    let(:call_position) {[-44, -171]}

    let(:car1){[40.71427, -74.00197]}
    let(:car2){[40.71428, -74.00597]}
    let(:car3){[40.71423, -74.00397]}
    let(:car4){[40.71123, -74.00397]}
    let(:call){[40.71330, -74]}

    let(:distance1) { app.distance(car_position, call_position) }
    let(:eta1) { app.eta distance1 }

    describe "calculates" do

      before do
        # too lazy to let them be (:
        @cars = [car1, car2, car3, car4]
      end

      let(:etas) { app.calculate_eta(@cars, call) }

      it { expect(distance1.round(12)).to eql(137.365669065197) }
      it { expect(app.eta(distance1).round(12)).to eql(206.048503597796) }
      it { expect(etas[0]).to eql(0.2969931637091627) }
      it { expect(app.eta_best(etas)).to eql(0.2969931637091627) }
      it { expect(app.eta_median(etas)).to eql(0.5672658348688635) }

    end

    describe "errors" do
      it { expect{app.distance(nil, call_position)}.to raise_error ArgumentError }
      it { expect{app.calculate_eta(nil, call_position)}.to raise_error ArgumentError }
      it { expect{app.calculate_eta([[1,2]], nil)}.to raise_error ArgumentError }
    end
  end

end