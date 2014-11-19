require 'open3'

def hole_path(path=nil)
  File.expand_path(File.join(__FILE__, '../../../holes')) + "/#{path}.rb"
end

def run_script(path, args)
  Open3.popen3("ruby #{hole_path(path)}") do |stdin, stdout, stderr|
    stdin.puts args
    stdin.close
    return stdout.read.chomp
  end
end

def score(path)
  puts File.size(hole_path(path))
end

describe "first hole" do
  describe "given an argument n from STDIN it should print the binary represenation of n to STDOUT" do
    # Example
    # 1 => 1
    # 3 => 11
    # 9 => 1001
    specify {
      expect(run_script('01', '1')).to eq('1')
    }
    specify {
      expect(run_script('01', '3')).to eq('11')
    }
    specify {
      expect(run_script('01', '9')).to eq('1001')
    }
    specify {
      score('01')
    }
  end
end

describe "second hole" do
  describe "given an argument n from STDIN it should print the first n Fibonacci sequence numbers as a space separated list" do
    specify {
      expect(run_script('02', '1')).to eq('1')
    }
    specify {
      expect(run_script('02', '4')).to eq('1 1 2 3')
    }
    specify {
      expect(run_script('02', '7')).to eq('1 1 2 3 5 8 13')
    }
    specify {
      score('02')
    }
  end
end

describe "third hole" do
  describe "given an argument n from STDIN as a set of space separated integers, it should be able to print out the unique values in any order" do
    # Example
    # 1 2 3 => 1 2 3
    # 3 3 3 => 3
    # 2 3 3 5 8 8 7 0 9 9 6 => 2 3 5 8 7 0 9 6
    specify {
      expect(run_script('03', '1 2 3').split(" ").sort.join(" ")).to eq('1 2 3')
    }
    specify {
      expect(run_script('03', '3 3 3').split(" ").sort.join(" ")).to eq('3')
    }
    specify {
      expect(run_script('03', '2 3 3 5 8 8 7 0 9 9 6').split(" ").sort.join(" ")).to eq('0 2 3 5 6 7 8 9')
    }
    specify {
      score('03')
    }
  end
end

describe "fourth hole" do
  describe "given an argument n from STDIN as a set of space separated integers, it should be able to print out the number of occurrences of each integer, beside the integer on separate lines" do
    # Example
    # 1 2 3 =>
    # 1 1
    # 2 1
    # 3 1
    #
    specify {
      expect(run_script('04', '1 2 3').split("\n").sort.join("\n")).to eq('1 1
2 1
3 1'
                                                                       )
    }
    # 3 3 3 =>
    specify {
      expect(run_script('04', '3 3 3').split("\n").sort.join("\n")).to eq('3 3')
    }

    # 3 3
    #
    # 2 3 3 5 8 8 7 0 9 9 6 =>
    # 2 1
    # 3 2
    # 5 1
    # 8 2
    # 7 1
    # 0 1
    # 9 2
    # 6 1
    specify {
      expect(run_script('04', '2 3 3 5 8 8 7 0 9 9 6').split("\n").sort.join("\n")).to eq('0 1
2 1
3 2
5 1
6 1
7 1
8 2
9 2'
                                                                                       )
    }
    specify {
      score('04')
    }

  end
end

describe "fifth hole" do
  describe "given input from STDIN as a set of sentences followed by on a separate line an integer n and then on n separate lines a set of words, it should list the words that are NOT in the sentence, separated by space" do
    # Example
    # Mary had a little lamb
    # 3
    # had
    # goat
    # fleece
    # goat fleece
    specify {
      expect(run_script('05', 'Mary had a little lamb
3
had
goat
fleece')).to eq('goat fleece')
    }
    specify {
        expect(run_script('05', 'It was the best of times, it was the worst of times
3
worst
times
ever')).to eq('ever')
    }
    specify {
      score('05')
    }
  end
end

describe "sixth hole" do
  describe "a checker that returns 1 if a sentence from STDIN is palindromic and 0 otherwise" do
    specify {
      expect(run_script('06', "Not a palindrome").to eq('0'))
    }
    specify {
      expect(run_script('06', "A car, a man, a maraca").to eq('1'))
    }
    specify {
      score("06")
    }
  end
end
