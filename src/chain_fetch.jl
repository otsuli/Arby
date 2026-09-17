module ChainFetch
export opt_chain_fetch

using YFinance
using DataFrames
using Dates

function opt_chain_fetch(ticker::String, target_date::String)
    exp_date = Date(target_date, "dd-mm-yy")
    data = get_Options(ticker; expiration_date=exp_date, throw_error=false)
end
end