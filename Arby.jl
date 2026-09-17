include("src/chain_fetch.jl")

using .ChainFetch

function main(args)
    println(raw"   ____  _____ _____ __  __
  / () \ | () )| () )\ \/ /
 /__/\__\|_|\_\|_()_) |__| ")

 if length(args) != 2
    println(stderr, "Invalid number of arguments")
    println("Arguments are: Ticker, Strike-date-dd-mm-yy")
    return 1 
 end

 opt_chain_fetch(args[1], args[2])
 return 0
end

@main