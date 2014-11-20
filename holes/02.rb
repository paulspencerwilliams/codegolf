c = [1,1]
n = []
ARGV[0].to_i.times {
  n << c[0]
  x = c[0] + c[1]
  c[0] = c[1]
  c[1] = x
}
puts n.join(" ")
