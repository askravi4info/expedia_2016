# x = "$189354535343"
x = "$1,054"

# p x[1..-1].to_i
p x.sub('$','').sub(',','').to_i