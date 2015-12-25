require 'saff_squeeze'

describe SaffSqueeze do
  context 'TDDing it up' do
    it 'should doit right' do
      input = [
          [0, 1, 0],
          [0, 0, 1],
          [1, 1, 1],
      ]

      expected_results = [
          [0, 0, 0],
          [1, 0, 1],
          [0, 1, 1],
      ]

      results = SaffSqueeze.new.doit(input)

      expect(results).to eq expected_results
    end

    it 'should doit right again' do
      input = [
          [0, 0, 0],
          [1, 1, 1],
          [0, 1, 0],
      ]

      expected_results = [
          [0, 1, 0],
          [1, 1, 1],
          [1, 1, 1],
      ]

      results = SaffSqueeze.new.doit(input)

      expect(results).to eq expected_results
    end
  end
end