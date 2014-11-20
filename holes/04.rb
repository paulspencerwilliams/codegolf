s = gets
n = gets.to_i
w = []
n.times do 
  w << gets.chomp  
end
u = [] 
w.each { | a | 
  unless s.include?(a) u << a 
}
puts u.join(' ')
